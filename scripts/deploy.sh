#!/usr/bin/env bash
# deploy หน้าเว็บขึ้น Cloudflare Workers (static assets)
#
#   ./scripts/deploy.sh          # render + ตรวจ + dry-run บอกว่าจะทำอะไร
#   ./scripts/deploy.sh --go     # deploy จริง
#
# ตั้งค่าอยู่ใน wrangler.jsonc ซึ่งอยู่ใน git — ต่างจาก Pages ที่เก็บไว้ในแดชบอร์ด
# ที่ไม่มีตัวตรวจตัวไหนใน repo นี้มองเห็น
#
# render ใหม่จาก YAML ทุกครั้งก่อน deploy — หน้าเว็บจึงไม่มีทางค้างคนละเวอร์ชันกับข้อมูล

set -uo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

DIST="$REPO_ROOT/web/dist"
GO=0
for a in "$@"; do
  case "$a" in
    --go) GO=1 ;;
    *) echo "ไม่รู้จัก option: $a" >&2; exit 1 ;;
  esac
done

wr() { npx --yes wrangler@4 "$@"; }

echo "▸ ตรวจข้อมูลก่อน — ไม่ปล่อยของที่ยังไม่ผ่านขึ้นเว็บ"
for c in audit radar-check recipe-check entity-check; do
  if "$REPO_ROOT/scripts/$c.sh" >/dev/null 2>&1; then
    printf '  \033[32m✓\033[0m %s\n' "$c"
  else
    printf '  \033[31m✗\033[0m %s — แก้ก่อนแล้วค่อย deploy\n' "$c"
    "$REPO_ROOT/scripts/$c.sh" 2>&1 | grep -E '✗' | head -5
    exit 1
  fi
done

echo "▸ สร้างหน้าเว็บใหม่จาก YAML"
"$REPO_ROOT/scripts/render-web.sh" || exit 1

rm -rf "$DIST"; mkdir -p "$DIST"
cp "$REPO_ROOT/web/index.html" "$DIST/index.html"
cp "$REPO_ROOT/web/_headers" "$DIST/_headers"

echo "▸ สร้างชั้นที่ agent อ่านได้"
"$REPO_ROOT/scripts/render-agent.sh" || exit 1
echo "▸ dist: $(du -h "$DIST/index.html" | cut -f1) ไฟล์เดียว ไม่มี dependency ภายนอก"

if ! wr whoami >/dev/null 2>&1; then
  echo "  ยังไม่ได้ล็อกอิน — รัน: npx wrangler@4 login" >&2; exit 1
fi

if [ "$GO" != "1" ]; then
  echo "▸ dry-run (ไม่ได้ใส่ --go)"
  wr deploy --dry-run 2>&1 | tail -6
  echo
  echo "  สั่ง ./scripts/deploy.sh --go เพื่อขึ้นจริง"
  exit 0
fi

# deploy สองรอบโดยตั้งใจ — เจอมาแล้วว่ารอบแรก wrangler บอก "Uploaded 1 of 1 asset"
# แต่ยังเสิร์ฟไฟล์เก่าอยู่ ต้องสั่งซ้ำถึงติด แล้วค่อยดึงหน้าจริงมาเทียบว่าตรงกันไหม
wr deploy || exit 1
sleep 3
wr deploy >/dev/null 2>&1

echo "▸ ตรวจว่าที่เสิร์ฟจริงตรงกับที่ build"
# ตรวจทุกไฟล์ ไม่ใช่แค่ index.html — เคยเกือบพลาดเพราะ report.md กับ data.json
# เป็นชั้นที่ agent อ่าน ถ้าค้างเก่าจะไม่มีอะไรจับได้เลย และมันจะโกหกเงียบๆ
sleep 4
url="https://solana-learn.solana-thailand.workers.dev"
tmp="$(mktemp)"; trap 'rm -f "$tmp"' EXIT

check_all() {
  local f name bad=0
  for f in "$DIST"/*; do
    name="$(basename "$f")"
    case "$name" in _headers) continue ;; esac   # ไม่ได้เสิร์ฟเป็นไฟล์
    curl -s -L --max-time 30 "$url/$name?cb=$RANDOM$$" -o "$tmp" 2>/dev/null
    if cmp -s "$tmp" "$f"; then
      printf '    \033[32m✓\033[0m %s\n' "$name"
    else
      printf '    \033[33m!\033[0m %s ยังไม่ตรง\n' "$name"; bad=1
    fi
  done
  # หน้าแรกต้องตรงกับ index.html ด้วย
  curl -s -L --max-time 30 "$url/?cb=$RANDOM$$" -o "$tmp" 2>/dev/null
  cmp -s "$tmp" "$DIST/index.html" || { printf '    \033[33m!\033[0m / ยังไม่ตรง\n'; bad=1; }
  return $bad
}

for i in 1 2 3; do
  if check_all; then
    printf '  \033[32m✓\033[0m ทุกไฟล์ตรงกับที่ build — %s\n' "$url"; exit 0
  fi
  printf '  รอ propagate แล้วตรวจใหม่ (%s/3)\n' "$i"; sleep 8
done
printf '  \033[31m✗\033[0m ยังมีไฟล์ที่เสิร์ฟไม่ตรงกับที่ build — รันซ้ำอีกครั้ง\n' >&2
exit 1

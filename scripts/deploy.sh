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
sleep 4
url="https://solana-learn.solana-thailand.workers.dev"
tmp="$(mktemp)"; trap 'rm -f "$tmp"' EXIT
for i in 1 2 3; do
  curl -s -L --max-time 25 "$url/?cb=$i$$" -o "$tmp"
  if cmp -s "$tmp" "$DIST/index.html"; then
    printf '  \033[32m✓\033[0m ตรงกันทุกไบต์ — %s\n' "$url"; exit 0
  fi
  sleep 6
done
printf '  \033[31m✗\033[0m ที่เสิร์ฟยังไม่ตรงกับที่ build — ลองรันซ้ำอีกครั้ง\n' >&2
exit 1

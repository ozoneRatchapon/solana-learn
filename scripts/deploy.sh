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

wr deploy

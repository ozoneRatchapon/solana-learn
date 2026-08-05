#!/usr/bin/env bash
# deploy หน้าเว็บขึ้น Cloudflare Pages
#
#   ./scripts/deploy-cf.sh              # เตรียมของ + ตรวจ แล้วบอกว่าจะทำอะไร (ไม่ deploy)
#   ./scripts/deploy-cf.sh --go         # deploy จริงเป็น preview (ปิดด้วย Access ได้)
#   ./scripts/deploy-cf.sh --go --prod  # deploy เป็น production (เปิดสาธารณะ)
#
# ต้องใส่ --go เสมอ — กันเผลอเผยแพร่ด้วยการพิมพ์ผิด
#
# ─────────────────────────────────────────────────────────────────────
# ทำไม Cloudflare Pages ไม่ใช่ GitHub Pages
# ─────────────────────────────────────────────────────────────────────
# GitHub Pages บนแพลนฟรี **ทำเว็บส่วนตัวไม่ได้** ขึ้นแล้วทุกคนเห็น
# ส่วน Pages ปิดด้วย Cloudflare Access ได้ ซึ่งเป็นเหตุผลเดียวที่เลือกตัวนี้
# ตอนที่ยังอยากดูเองก่อน
#
# ค่าใช้จ่าย (ตรวจ 2026-08-05):
#   · static asset ฟรีและไม่จำกัด — หน้านี้เป็น static ล้วน ไม่มี Functions
#   · bandwidth ไม่จำกัดทุกแพลน
#   · build 500 ครั้ง/เดือน บนแพลนฟรี
#   · Zero Trust (Access) ฟรีถึง 50 ผู้ใช้
#   · ใช้ซับโดเมน .pages.dev ไม่ต้องซื้อโดเมน
# จะเสียเงินก็ต่อเมื่อเกินเพดานพวกนี้ ซึ่ง repo ขนาดนี้ไม่มีทางแตะ

set -uo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

PROJECT="${CF_PROJECT:-solana-learn}"
DIST="$REPO_ROOT/web/dist"
GO=0; PROD=0
for a in "$@"; do
  case "$a" in
    --go) GO=1 ;;
    --prod) PROD=1 ;;
    *) echo "ไม่รู้จัก option: $a" >&2; exit 1 ;;
  esac
done

wr() { npx --yes wrangler@4 "$@"; }

echo "▸ สร้างหน้าเว็บใหม่จาก YAML"
"$REPO_ROOT/scripts/render-web.sh" || exit 1

# dist มีแค่ index.html — ไม่เอา template.html ขึ้นไปด้วย
rm -rf "$DIST"; mkdir -p "$DIST"
cp "$REPO_ROOT/web/index.html" "$DIST/index.html"
echo "▸ dist พร้อม: $(du -h "$DIST/index.html" | cut -f1)  (ไฟล์เดียว ไม่มี dependency)"

echo "▸ ตรวจว่าล็อกอิน Cloudflare แล้วหรือยัง"
if ! wr whoami >/dev/null 2>&1; then
  cat >&2 <<'MSG'

  ยังไม่ได้ล็อกอิน — รันคำสั่งนี้ก่อน (เปิดเบราว์เซอร์ให้กดอนุญาต ทำครั้งเดียว)

      npx wrangler@4 login

  ถ้ายังไม่มีบัญชี Cloudflare สมัครฟรีที่ https://dash.cloudflare.com/sign-up
MSG
  exit 1
fi
wr whoami 2>/dev/null | grep -iE 'account|email' | head -3

# wrangler ไม่สร้างโปรเจกต์ให้อัตโนมัติตอน deploy (เจอตอน deploy ครั้งแรก
# ได้ error "The Pages project does not exist" แล้วมันชวนไปใช้ Workers แทน)
if ! wr pages project list 2>/dev/null | grep -q "$PROJECT"; then
  echo "▸ ยังไม่มีโปรเจกต์ '$PROJECT' — สร้างให้ก่อน"
  if [ "$GO" = "1" ]; then
    wr pages project create "$PROJECT" --production-branch main || exit 1
  else
    echo "  (จะสร้างตอนสั่ง --go)"
  fi
fi

if [ "$GO" != "1" ]; then
  cat <<MSG

  ── ยังไม่ได้ deploy (ไม่ได้ใส่ --go) ──

  ถ้าสั่ง --go จะทำ:
    · สร้างโปรเจกต์ '$PROJECT' บน Cloudflare Pages ถ้ายังไม่มี
    · อัปโหลด web/dist/index.html ขึ้นเป็น **preview** ของสาขา 'private'
    · ได้ URL แบบ https://private.$PROJECT.pages.dev

  หลัง deploy ครั้งแรก ให้ไปปิดไม่ให้คนนอกเห็น (ทำครั้งเดียว):
    Cloudflare dashboard → Workers & Pages → $PROJECT
    → Settings → General → เปิด "Enable access policy"
    ผลคือต้องล็อกอินบัญชี Cloudflare ของคุณก่อนถึงจะเปิดหน้าได้

  พร้อมเปิดสาธารณะจริงค่อยใช้ --go --prod

MSG
  exit 0
fi

if [ "$PROD" = "1" ]; then
  printf '\n\033[33m  กำลังจะ deploy เป็น production = เปิดให้ทุกคนเห็น\033[0m\n'
  printf '  พิมพ์ PUBLIC เพื่อยืนยัน: '
  read -r confirm
  [ "$confirm" = "PUBLIC" ] || { echo "ยกเลิก"; exit 1; }
  wr pages deploy "$DIST" --project-name "$PROJECT" --branch main
else
  wr pages deploy "$DIST" --project-name "$PROJECT" --branch private
  cat <<MSG

  ▸ ขึ้นเป็น preview แล้ว — **แต่ยังเปิดสาธารณะอยู่จนกว่าจะตั้ง Access**
    ไปเปิดที่ dashboard → Workers & Pages → $PROJECT → Settings → General
    → "Enable access policy"  แล้วคนนอกจะเปิดไม่ได้

MSG
fi

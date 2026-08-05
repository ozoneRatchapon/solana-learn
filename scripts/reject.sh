#!/usr/bin/env bash
# บันทึกว่า "ดูแล้ว ไม่เอา" ลง data/rejected.yml
#
#   ./scripts/reject.sh -u <url> -r "<เหตุผล>" [-b <url ที่ดีกว่า>]
#
# ตัวอย่าง:
#   ./scripts/reject.sh -u https://old-tutorial.dev/anchor \
#     -r "Anchor 0.29 ทั้งบทความ ไม่อัปเดตตั้งแต่ 2024" \
#     -b https://learn.blueshift.gg/
#
# คู่กับ add.sh — ตัดสินใจ "เอา" ใช้ add.sh, ตัดสินใจ "ไม่เอา" ใช้ตัวนี้
# ทั้งสองทางต้องทิ้งเหตุผลไว้ ไม่ใช่แค่ทางเดียว

set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
need yq

# single-quoted scalar — escape แค่ ' ตัวเดียว (double-quoted เคยทำ resources.yml พังมาแล้ว)
yesc() { printf '%s' "$1" | sed "s/'/''/g"; }

url=""; reason=""; better=""
while getopts "u:r:b:" opt; do
  case $opt in
    u) url="$OPTARG" ;;
    r) reason="$OPTARG" ;;
    b) better="$OPTARG" ;;
    *) exit 1 ;;
  esac
done

[ -z "$url" ] || [ -z "$reason" ] && {
  echo "ต้องมี -u <url> -r \"<เหตุผล>\"" >&2
  echo "เหตุผลคือทั้งหมดของไฟล์นี้ — ปฏิเสธโดยไม่บอกเหตุผลก็เท่ากับไม่ได้บันทึกอะไร" >&2
  exit 1; }

n="$(norm "$url")"

# อยู่ในแคตตาล็อกแล้วหรือเปล่า — ปฏิเสธของที่เก็บอยู่ไม่ได้
if entries_tsv | cut -f1 | while read -r u; do
     if [ "$(norm "$u")" = "$n" ]; then echo dup; fi
   done | grep -q dup; then
  echo "URL นี้อยู่ในแคตตาล็อกแล้ว — ถ้าจะถอดออก ให้ลบจาก resources.yml ก่อน" >&2
  exit 1
fi

# ปฏิเสธซ้ำ
if rejected_sv | cut -d"$SEP" -f1 | while read -r u; do
     if [ "$(norm "$u")" = "$n" ]; then echo dup; fi
   done | grep -q dup; then
  echo "เคยบันทึกว่าไม่เอาไปแล้ว: $url" >&2
  exit 1
fi

# `rejected: []` ตอนไฟล์ยังว่าง — เปลี่ยนเป็น list จริงก่อน append
if grep -q '^rejected: \[\]' "$REJECTED"; then
  # ใช้ awk แทน sed -i เพราะ BSD/GNU sed ต่างกันเรื่อง -i (macOS ต้องมี argument)
  awk '/^rejected: \[\]/ { print "rejected:"; next } { print }' "$REJECTED" > "$REJECTED.tmp"
  mv "$REJECTED.tmp" "$REJECTED"
fi

{
  echo ""
  echo "  - url: $url"
  printf "    reason: '%s'\n" "$(yesc "$reason")"
  if [ -n "$better" ]; then echo "    superseded_by: $better"; fi
  echo "    checked: $(date +%F)"
} >> "$REJECTED"

echo "บันทึกแล้ว: $url"
echo "  เหตุผล: $reason"
[ -n "$better" ] && echo "  ใช้แทน: $better"
echo "ครั้งหน้า ./scripts/check.sh จะตอบ [เคยไม่เอา] พร้อมเหตุผลนี้"

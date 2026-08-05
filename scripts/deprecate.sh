#!/usr/bin/env bash
# ทำเครื่องหมายว่า entry นี้ "ยังเปิดได้แต่ไม่ควรใช้แล้ว"
#
#   ./scripts/deprecate.sh -u <url> -r "<เหตุผล>" [-b <url ที่ใช้แทน>]
#   ./scripts/deprecate.sh -u <url> --undo
#
# ต่างจาก reject.sh: reject คือ "ไม่เคยเก็บ" — ตัวนี้คือ "เคยเก็บ แต่ตอนนี้อย่าใช้"
# ยังอยู่ในแคตตาล็อกโดยตั้งใจ เพราะคนที่เจอลิงก์นี้จากที่อื่นต้องรู้ว่าเราดูแล้ว
# และรู้ว่าใช้อะไรแทน การลบทิ้งเฉยๆ ทำให้เขาไปเสียเวลากับมันอยู่ดี
#
# ทำไมไม่ใช้ status: deprecated — ดูคำอธิบายหัวไฟล์ data/resources.yml
# (สั้นๆ: linkcheck --fix จะเขียนทับเป็น ok เพราะลิงก์ยังได้ HTTP 200)

set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
need yq

url=""; reason=""; better=""; undo=0
while [ $# -gt 0 ]; do
  case "$1" in
    -u) url="$2"; shift 2 ;;
    -r) reason="$2"; shift 2 ;;
    -b) better="$2"; shift 2 ;;
    --undo) undo=1; shift ;;
    *) echo "ไม่รู้จัก: $1" >&2; exit 1 ;;
  esac
done

[ -z "$url" ] && { echo "ต้องมี -u <url>" >&2; exit 1; }
grep -qF "  - url: $url" "$DATA" || { echo "ไม่พบใน $DATA: $url" >&2; exit 1; }

if [ "$undo" = "1" ]; then
  awk -v target="$url" '
    /^  - url: / { cur = substr($0, 10); print; next }
    /^    (deprecated|superseded_by): / { if (cur == target) next; print; next }
    { print }
  ' "$DATA" > "$DATA.tmp" && mv "$DATA.tmp" "$DATA"
  echo "ยกเลิกการทำเครื่องหมายแล้ว: $url"
  echo "รัน ./scripts/render.sh ต่อ"
  exit 0
fi

[ -z "$reason" ] && {
  echo "ต้องมี -r \"<เหตุผล>\"" >&2
  echo "เหตุผลคือทั้งหมดของฟีเจอร์นี้ — บอกว่าเลิกใช้เพราะอะไร ไม่งั้นคนอ่านก็ยังไม่รู้ว่าต้องระวังอะไร" >&2
  exit 1; }
[ "${#reason}" -lt 20 ] && { echo "เหตุผลสั้นเกินไป (${#reason} ตัวอักษร) — อย่างน้อย 20" >&2; exit 1; }

# escape single-quoted YAML scalar — ' → ''
resc="$(printf '%s' "$reason" | sed "s/'/''/g")"

# แทรกก่อน status: (หรือแทนที่ของเดิม) ด้วย awk แบบเดียวกับ linkcheck.sh --fix / setnote.sh
# — ไม่ใช้ yq -i เพราะมันเขียนไฟล์ใหม่ทั้งไฟล์แล้วบรรทัดว่างหายหมด
awk -v target="$url" -v dep="$resc" -v sup="$better" '
  /^  - url: / { cur = substr($0, 10); wrote = 0; print; next }
  /^    deprecated: / { if (cur == target) next; print; next }
  /^    superseded_by: / { if (cur == target) next; print; next }
  /^    status: / {
    if (cur == target && !wrote) {
      print "    deprecated: '"'"'" dep "'"'"'"
      if (sup != "") print "    superseded_by: " sup
      wrote = 1
    }
    print; next
  }
  { print }
' "$DATA" > "$DATA.tmp" && mv "$DATA.tmp" "$DATA"

echo "ทำเครื่องหมายแล้ว: $url"
echo "  เหตุผล: $reason"
[ -n "$better" ] && echo "  ใช้แทน: $better"
echo "รัน ./scripts/render.sh ต่อ — CATALOG.md จะแสดงเป็นขีดฆ่า + เหตุผล + ตัวแทน"

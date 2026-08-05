#!/usr/bin/env bash
# เขียน/แก้ note ของ entry ที่มีอยู่แล้วใน data/resources.yml
#
#   ./scripts/setnote.sh <url> "<note>"
#   ./scripts/setnote.sh --from-tsv <file>     # url \t note ทีละบรรทัด (แก้หลายอันรวดเดียว)
#
# ทำไมไม่ใช้ `yq -i`: yq เขียนไฟล์ใหม่ทั้งไฟล์ ซึ่งลบบรรทัดว่างระหว่าง entry ทิ้งหมด
# (ทดลองแล้ว 1599 → 1427 บรรทัด) ไฟล์นี้คนแก้ด้วยมือด้วย ความอ่านง่ายจึงเป็นส่วนหนึ่งของมัน
# ใช้ awk แก้เฉพาะบรรทัดแบบเดียวกับที่ linkcheck.sh --fix ทำกับ status:

set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
need yq

MAP="$(mktemp)"
trap 'rm -f "$MAP"' EXIT

if [ "${1:-}" = "--from-tsv" ]; then
  [ -f "${2:-}" ] || { echo "ไม่พบไฟล์: ${2:-}" >&2; exit 1; }
  cp "$2" "$MAP"
else
  [ $# -eq 2 ] || { echo "ใช้: $0 <url> \"<note>\"  |  $0 --from-tsv <file>" >&2; exit 1; }
  printf '%s\t%s\n' "$1" "$2" > "$MAP"
fi

# ทุก url ใน map ต้องมีอยู่จริง ไม่งั้นเงียบหายโดยไม่มีใครรู้
missing=0
while IFS=$'\t' read -r u _; do
  [ -z "$u" ] && continue
  if ! grep -qF "  - url: $u" "$DATA"; then
    echo "ไม่พบใน $DATA: $u" >&2; missing=1
  fi
done < "$MAP"
[ "$missing" = "1" ] && exit 1

# escape สำหรับ single-quoted scalar — ต้อง escape แค่ ' (double-quoted เคยทำไฟล์พังมาแล้ว)
awk -v mapfile="$MAP" '
  BEGIN {
    while ((getline line < mapfile) > 0) {
      i = index(line, "\t")
      if (i > 0) {
        u = substr(line, 1, i - 1)
        n = substr(line, i + 1)
        gsub(/'"'"'/, "'"'"''"'"'", n)      # ทำ '"'"' เป็น '"'"''"'"' ตามกฎ YAML single-quote
        note[u] = n
      }
    }
  }
  /^  - url: / { cur = substr($0, 10); done = 0; print; next }
  /^    note: / {
    if (cur != "" && cur in note) { print "    note: '"'"'" note[cur] "'"'"'"; done = 1; next }
    print; next
  }
  /^    status: / {
    if (cur != "" && !done && cur in note) print "    note: '"'"'" note[cur] "'"'"'"
    done = 1; print; next
  }
  { print }
' "$DATA" > "$DATA.tmp" && mv "$DATA.tmp" "$DATA"

n="$(grep -c . "$MAP")"
echo "เขียน note แล้ว $n รายการ — รัน ./scripts/render.sh ต่อ"

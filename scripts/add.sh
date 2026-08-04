#!/usr/bin/env bash
# เพิ่ม resource ใหม่เข้า data/resources.yml (ต่อท้ายไฟล์ — render.sh จัดกลุ่มให้เอง)
#
#   ./scripts/add.sh -u <url> -n <ชื่อ> -c <หมวด> [-s source] [-t "tag1,tag2"] [-m "โน้ต"]
#
# ตัวอย่าง:
#   ./scripts/add.sh -u https://example.com -n "Example" -c learning -s community -t "course,free" -m "ทำไมถึงเก็บ"
#
# กันซ้ำให้อัตโนมัติ (เรียก check ภายใน) และเช็ค HTTP status ให้ด้วย

set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
need yq

url=""; name=""; cat_=""; src="community"; tags=""; note=""
while getopts "u:n:c:s:t:m:" opt; do
  case $opt in
    u) url="$OPTARG" ;;
    n) name="$OPTARG" ;;
    c) cat_="$OPTARG" ;;
    s) src="$OPTARG" ;;
    t) tags="$OPTARG" ;;
    m) note="$OPTARG" ;;
    *) exit 1 ;;
  esac
done

[ -z "$url" ] || [ -z "$name" ] || [ -z "$cat_" ] && {
  echo "ต้องมี -u <url> -n <ชื่อ> -c <หมวด>" >&2; exit 1; }

# หมวดต้องมีจริง
if ! yq -e ".categories | has(\"$cat_\")" "$DATA" >/dev/null 2>&1; then
  echo "หมวด '$cat_' ไม่มีใน data/resources.yml — หมวดที่ใช้ได้:" >&2
  yq -r '.categories | keys | .[]' "$DATA" | sed 's/^/  - /' >&2
  exit 1
fi

# กันซ้ำ
n="$(norm "$url")"
if entries_tsv | cut -f1 | while read -r u; do [ "$(norm "$u")" = "$n" ] && echo dup; done | grep -q dup; then
  echo "มีอยู่แล้ว: $url" >&2; exit 1
fi

code="$(curl -sS -o /dev/null -w '%{http_code}' -L --max-time 12 "$url" 2>/dev/null || echo 000)"
case "$code" in
  2*) status=ok ;;
  403|401|429) status=blocked ;;   # กัน bot ไม่ใช่ตาย
  000|4*|5*) status=unverified ;;
  *) status=unverified ;;
esac

{
  echo ""
  echo "  - url: $url"
  echo "    name: \"$name\""
  echo "    category: $cat_"
  echo "    source: $src"
  if [ -n "$tags" ]; then
    echo "    tags: [$(printf '%s' "$tags" | sed 's/ *, */, /g')]"
  fi
  [ -n "$note" ] && echo "    note: \"$note\""
  echo "    status: $status"
  echo "    added: $(date +%F)"
} >> "$DATA"

echo "เพิ่มแล้ว: $name  [$cat_]  (HTTP $code → status: $status)"
echo "รัน ./scripts/render.sh เพื่ออัปเดต CATALOG.md"

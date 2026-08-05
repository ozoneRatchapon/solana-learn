#!/usr/bin/env bash
# ยิง HTTP เช็คทุกลิงก์ในแคตตาล็อก แล้วรายงานว่า status ใน YAML ตรงกับความจริงไหม
#   ./scripts/linkcheck.sh            # เช็คทั้งหมด (รายงานอย่างเดียว)
#   ./scripts/linkcheck.sh learning   # เช็คเฉพาะหมวด
#   ./scripts/linkcheck.sh --fix      # เขียน status กลับเข้า YAML ให้เลย
#
# --fix แก้เฉพาะบรรทัด status: (แทรก/แทนที่) ด้วย awk — comment ในไฟล์ไม่หาย

set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
need yq

fix=0
if [ "${1:-}" = "--fix" ]; then fix=1; shift; fi
filter="${1:-}"
# หมวดที่ไม่มีจริงต้องดังทันที ไม่ใช่เช็คเป็น 0 รายการแล้วรายงานเหมือนปกติ
# (พิมพ์ --only มาโดยไม่มีในสารบบ เคยได้ผลลัพธ์ SET ของ URL ว่างมาแล้ว)
if [ -n "$filter" ]; then
  if ! yq -e ".categories | has(\"$filter\")" "$DATA" >/dev/null 2>&1; then
    echo "หมวด '$filter' ไม่มีใน $DATA — หมวดที่ใช้ได้:" >&2
    yq -r '.categories | keys | .[]' "$DATA" | sed 's/^/  - /' >&2
    exit 1
  fi
fi
MAP="$(mktemp)"
trap 'rm -f "$MAP"' EXIT
if [ -n "$filter" ]; then
  sel=".resources[] | select(.category == \"$filter\")"
else
  sel=".resources[]"
fi

mismatch=0; checked=0
while IFS=$'\t' read -r url name declared; do
  # `... || echo 000` ต่อท้ายค่าที่ curl พิมพ์ไปแล้ว ไม่ได้แทนที่ — หน้าใหญ่ที่โดน --max-time
  # ตัดกลางคัน (rwa.xyz 4.6 MB, colosseum 2.9 MB) curl พิมพ์ "200" แล้ว exit 28 → ได้ "200000"
  # กรณีนั้นบังเอิญยัง match 2* เลยไม่พัง แต่ "404000" จะตกไป unverified แทน dead
  # การมอบหมายเกิดก่อน || เสมอ ดังนั้น $code มีค่าที่ curl พิมพ์อยู่แล้วตอน fallback ทำงาน
  code="$(curl -sS -o /dev/null -w '%{http_code}' -L --max-time 12 "$url" 2>/dev/null)" || code="${code:-000}"
  case "$code" in
    2*) actual=ok ;;
    403|401|429) actual=blocked ;;
    404|410) actual=dead ;;
    *) actual=unverified ;;
  esac
  checked=$((checked + 1))
  printf '%s\t%s\n' "$url" "$actual" >> "$MAP"

  if [ -z "$declared" ] || [ "$declared" = "null" ]; then
    printf '\033[36m  SET \033[0m %-3s %-10s %s\n         → ยังไม่มี status ใน YAML ควรใส่ "%s"\n' "$code" "$actual" "$name" "$actual"
    mismatch=$((mismatch + 1))
  elif [ "$declared" != "$actual" ]; then
    printf '\033[33mMISMATCH\033[0m %-3s %-10s %s\n         → YAML บอก "%s" แต่จริงคือ "%s"  %s\n' "$code" "$actual" "$name" "$declared" "$actual" "$url"
    mismatch=$((mismatch + 1))
  else
    printf '\033[32m   ok   \033[0m %-3s %-10s %s\n' "$code" "$actual" "$name"
  fi
done < <(yq -r "$sel | [.url, .name, (.status // \"\")] | @tsv" "$DATA")

echo
echo "เช็ค $checked ลิงก์ · ต้องแก้ status $mismatch รายการ"

if [ "$fix" = "1" ] && [ "$mismatch" -gt 0 ]; then
  awk -v mapfile="$MAP" '
    BEGIN {
      while ((getline line < mapfile) > 0) {
        i = index(line, "\t")
        st[substr(line, 1, i - 1)] = substr(line, i + 1)
      }
    }
    /^  - url: / { cur = substr($0, 10); seen = 0; print; next }
    /^    status: / {
      if (cur != "" && cur in st) { print "    status: " st[cur]; seen = 1; next }
      print; next
    }
    /^    added: / {
      if (cur != "" && !seen && cur in st) print "    status: " st[cur]
      seen = 1; print; next
    }
    { print }
  ' "$DATA" > "$DATA.tmp" && mv "$DATA.tmp" "$DATA"

  echo "เขียน status กลับเข้า $DATA แล้ว — รัน ./scripts/render.sh ต่อ"
fi

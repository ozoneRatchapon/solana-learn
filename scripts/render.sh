#!/usr/bin/env bash
# generate CATALOG.md จาก data/resources.yml — อย่าแก้ CATALOG.md ด้วยมือ
#   ./scripts/render.sh

set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
need yq

OUT="$REPO_ROOT/CATALOG.md"
SEP=$'\x1f'   # unit separator — ปลอดภัยกว่า tab เพราะ bash read ไม่ยุบ field ว่าง
total="$(yq -r '.resources | length' "$DATA")"

{
  echo "# Solana Resource Catalog"
  echo
  echo "> ไฟล์นี้ถูก generate จาก [data/resources.yml](data/resources.yml) — **อย่าแก้ตรงนี้**"
  echo "> แก้ที่ YAML แล้วรัน \`./scripts/render.sh\`"
  echo
  echo "รวม **$total** รายการ · อัปเดต $(date +%F)"
  echo
  echo "หมายเหตุสถานะ: \`blocked\` = เว็บกัน bot ตอน curl (ลิงก์ยังใช้ได้), \`unverified\` = เช็คอัตโนมัติไม่ผ่าน ต้องดูด้วยตา"
  echo

  # สารบัญ
  echo "## สารบัญ"
  echo
  yq -r '.categories | to_entries | .[] | [.key, .value] | @tsv' "$DATA" \
  | while IFS=$'\t' read -r key label; do
      n="$(yq -r "[.resources[] | select(.category == \"$key\")] | length" "$DATA")"
      [ "$n" = "0" ] && continue
      anchor="$(printf '%s' "$label" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9ก-๙ -]//g; s/ /-/g')"
      echo "- [$label](#$anchor) — $n"
    done
  echo

  # เนื้อหาแต่ละหมวด
  yq -r '.categories | to_entries | .[] | [.key, .value] | @tsv' "$DATA" \
  | while IFS=$'\t' read -r key label; do
      n="$(yq -r "[.resources[] | select(.category == \"$key\")] | length" "$DATA")"
      [ "$n" = "0" ] && continue
      echo "## $label"
      echo
      # ใช้ \x1f (unit separator) ไม่ใช่ tab — bash read ยุบ tab ที่ติดกันเป็นตัวเดียว
      # ทำให้ field ที่ว่าง (เช่น note) หายไปแล้ว field ถัดไปเลื่อนมาแทน
      yq -r "
        .resources[] | select(.category == \"$key\")
        | [ .name, .url, (.source // \"\"), ((.tags // []) | join(\", \")), (.note // \"\"), (.status // \"\") ]
        | join(\"$SEP\")
      " "$DATA" \
      | while IFS="$SEP" read -r name url source tags note status; do
          badge=""
          case "$source" in
            foundation) badge=" \`official\`" ;;
            anza)       badge=" \`anza\`" ;;
            vendor)     badge=" \`vendor\`" ;;
            thailand)   badge=" \`TH\`" ;;
          esac
          case "$status" in
            blocked)    badge="$badge \`blocked\`" ;;
            unverified) badge="$badge \`unverified\`" ;;
            dead)       badge="$badge \`DEAD\`" ;;
          esac
          echo "- [$name]($url)$badge"
          [ -n "$note" ] && echo "  $note"
          [ -n "$tags" ] && echo "  <sub>$tags</sub>"
        done
      echo
    done
} > "$OUT"

echo "เขียน $OUT แล้ว ($total รายการ)"

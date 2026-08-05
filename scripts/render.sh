#!/usr/bin/env bash
# generate CATALOG.md จาก data/resources.yml — อย่าแก้ CATALOG.md ด้วยมือ
#   ./scripts/render.sh

set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
need yq

OUT="$REPO_ROOT/CATALOG.md"
total="$(yq -r '.resources | length' "$DATA")"
last_added="$(yq -r '[.resources[].added] | sort | .[-1]' "$DATA")"

{
  echo "# Solana Resource Catalog"
  echo
  echo "> ไฟล์นี้ถูก generate จาก [data/resources.yml](data/resources.yml) — **อย่าแก้ตรงนี้**"
  echo "> แก้ที่ YAML แล้วรัน \`./scripts/render.sh\`"
  echo
  # ใช้วันที่ล่าสุดใน "ข้อมูล" ไม่ใช่ $(date) — ไม่งั้น render ทุกครั้งได้ diff
  # ทั้งที่เนื้อหาไม่เปลี่ยน ทำให้ git log อ่านไม่ออกว่าอะไรเปลี่ยนจริง
  # และ audit.sh เทียบ CATALOG กับ YAML ไม่ได้
  echo "รวม **$total** รายการ · ข้อมูลล่าสุด $last_added"
  echo
  echo "หมายเหตุสถานะ: \`blocked\` = เว็บกัน bot ตอน curl (ลิงก์ยังใช้ได้), \`unverified\` = เช็คอัตโนมัติไม่ผ่าน ต้องดูด้วยตา"
  echo

  # สารบัญ
  echo "## สารบัญ"
  echo
  yq -r '.categories | to_entries | .[] | [.key, .value] | @tsv' "$DATA" \
  | while IFS=$'\t' read -r key label; do
      n="$(yq -r "[.resources[] | select(.category == \"$key\")] | length" "$DATA")"
      if [ "$n" = "0" ]; then continue; fi
      # ห้ามใช้ range ที่คร่อมอักษรไทย (เช่น [^a-z0-9ก-๙ -]) — BSD sed รับ แต่ GNU sed
      # ตอบ "Invalid collation character" แล้วตายทันที (CI แดงครั้งแรกเพราะบรรทัดนี้)
      # เลี่ยงด้วยการ "ลบเครื่องหมายวรรคตอนที่ระบุ" แทน "เก็บเฉพาะอักษรที่ระบุ"
      # ไม่มี range = ไม่มี collation ให้ตีความ ได้ anchor เท่าเดิมทั้ง 18 หมวด (ตรวจแล้ว)
      anchor="$(printf '%s' "$label" | tr '[:upper:]' '[:lower:]' \
        | sed -e 's/[][!"#$%&'"'"'()*+,./:;<=>?@\^`{|}~]//g' -e 's/—//g' -e 's/ /-/g')"
      echo "- [$label](#$anchor) — $n"
    done
  echo

  # เนื้อหาแต่ละหมวด
  yq -r '.categories | to_entries | .[] | [.key, .value] | @tsv' "$DATA" \
  | while IFS=$'\t' read -r key label; do
      n="$(yq -r "[.resources[] | select(.category == \"$key\")] | length" "$DATA")"
      if [ "$n" = "0" ]; then continue; fi
      echo "## $label"
      echo
      # ใช้ \x1f (unit separator) ไม่ใช่ tab — bash read ยุบ tab ที่ติดกันเป็นตัวเดียว
      # ทำให้ field ที่ว่าง (เช่น note) หายไปแล้ว field ถัดไปเลื่อนมาแทน
      yq -r "
        .resources[] | select(.category == \"$key\")
        | [ .name, .url, (.source // \"\"), ((.tags // []) | join(\", \")), (.note // \"\"), (.status // \"\"), (.deprecated // \"\"), (.superseded_by // \"\") ]
        | join(\"$SEP\")
      " "$DATA" \
      | while IFS="$SEP" read -r name url source tags note status dep sup; do
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
          if [ -n "$dep" ]; then
            # ขีดฆ่าแทนที่จะลบทิ้ง — คนที่เจอลิงก์นี้จากที่อื่นต้องรู้ว่าเราดูแล้วและทำไมถึงไม่แนะนำ
            echo "- ~~[$name]($url)~~$badge \`เลิกใช้\`"
            echo "  $dep"
            if [ -n "$sup" ]; then echo "  **ใช้แทน:** $sup"; fi
          else
            echo "- [$name]($url)$badge"
          fi
          # ใช้ if/fi ไม่ใช่ `[ ... ] && echo` — ถ้าเงื่อนไขสุดท้ายของ iteration สุดท้าย
          # เป็นเท็จ while จะคืน exit 1 ทั้ง pipeline แล้ว set -e ฆ่า script
          # (กับดักข้อ 2 ใน CLAUDE.md — bash 3.2 บน macOS ไม่แสดงอาการ bash 5 บน CI แสดง)
          if [ -n "$note" ]; then echo "  $note"; fi
          if [ -n "$tags" ]; then echo "  <sub>$tags</sub>"; fi
        done
      echo
    done
} > "$OUT"

echo "เขียน $OUT แล้ว ($total รายการ)"

#!/usr/bin/env bash
# generate GRAPH.md จาก data/entities.yml — อย่าแก้ GRAPH.md ด้วยมือ
#   ./scripts/render-graph.sh
#
# mermaid render ได้เองบน GitHub เลยไม่ต้องพึ่งเครื่องมือนอก

set -uo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
need yq

ENTITIES="${ENTITIES:-$REPO_ROOT/data/entities.yml}"
OUT="${GRAPH_OUT:-$REPO_ROOT/GRAPH.md}"
SEP=$'\x1f'   # field ที่อาจว่าง — เหตุผลเดียวกับ render.sh

n_ent="$(yq -r '.entities | length' "$ENTITIES")"
n_rel="$(yq -r '.relations | length' "$ENTITIES")"

{
  echo "# Ecosystem Map"
  echo
  echo "> ไฟล์นี้ถูก generate จาก [data/entities.yml](data/entities.yml) — **อย่าแก้ตรงนี้**"
  echo "> แก้ YAML แล้วรัน \`./scripts/render-graph.sh\`"
  echo
  echo "**$n_ent** หน่วยงาน · **$n_rel** ความสัมพันธ์ · อัปเดต $(date +%F)"
  echo
  echo "ตอบคำถามที่ [CATALOG.md](CATALOG.md) ไม่ตอบ — ไม่ใช่ \"ของอยู่ที่ไหน\" แต่คือ **ใครทำ ใครดูแล ใครจ่ายเงิน ใครตรวจ**"
  echo
  echo "> **ไม่มีข้อมูลรายบุคคลในไฟล์นี้** และกันไว้ที่ schema ไม่ใช่ที่วินัยคนกรอก —"
  echo "> \`entity-check.sh\` จะไม่ผ่านถ้าเจอ \`kind\` นอกรายการปิด ซึ่งไม่มี \`person\` อยู่ในนั้น"
  echo
  echo "## แผนภาพ"
  echo
  echo '```mermaid'
  echo "graph LR"
  # ประกาศ node ก่อน เพื่อให้ชื่อที่แสดงเป็นชื่อจริงไม่ใช่ id
  yq -r ".entities[] | [.id, .name, .kind] | join(\"$SEP\")" "$ENTITIES" \
  | while IFS="$SEP" read -r id name kind; do
      case "$kind" in
        org)       printf '  %s["%s"]\n' "$id" "$name" ;;
        community) printf '  %s(("%s"))\n' "$id" "$name" ;;
        program)   printf '  %s{{"%s"}}\n' "$id" "$name" ;;
        *)         printf '  %s["%s"]\n' "$id" "$name" ;;
      esac
    done
  yq -r ".relations[] | [.from, .type, .to] | join(\"$SEP\")" "$ENTITIES" \
  | while IFS="$SEP" read -r from type to; do
      printf '  %s -->|%s| %s\n' "$from" "$type" "$to"
    done
  echo '```'
  echo
  echo "รูปทรง: สี่เหลี่ยม = องค์กร · วงกลม = ชุมชน · หกเหลี่ยม = โปรแกรม/client"
  echo

  # ตารางรายหมวด — ตรงนี้คือส่วนที่ใช้จริงเวลาจะติดต่อ
  yq -r '.kinds | to_entries | .[] | [.key, .value] | join("'"$SEP"'")' "$ENTITIES" \
  | while IFS="$SEP" read -r key label; do
      n="$(yq -r "[.entities[] | select(.kind == \"$key\")] | length" "$ENTITIES")"
      [ "$n" = "0" ] && continue
      echo "## $label ($n)"
      echo
      echo "| ชื่อ | ติดต่อเรื่องอะไรได้ | ยืนยันเมื่อ |"
      echo "|---|---|---|"
      yq -r "
        .entities[] | select(.kind == \"$key\")
        | [.name, .evidence, .reach, .confirmed] | join(\"$SEP\")
      " "$ENTITIES" \
      | while IFS="$SEP" read -r name evidence reach confirmed; do
          printf '| [%s](%s) | %s | %s |\n' "$name" "$evidence" "$reach" "$confirmed"
        done
      echo
    done

  echo "## ความสัมพันธ์ทั้งหมด"
  echo
  echo "| จาก | ความสัมพันธ์ | ถึง | หลักฐาน |"
  echo "|---|---|---|---|"
  yq -r ".relations[] | [.from, .type, .to, .evidence] | join(\"$SEP\")" "$ENTITIES" \
  | while IFS="$SEP" read -r from type to evidence; do
      label="$(yq -r ".relation_types.\"$type\" // \"$type\"" "$ENTITIES")"
      printf '| `%s` | %s | `%s` | [ที่มา](%s) |\n' "$from" "$label" "$to" "$evidence"
    done
  echo
  echo "---"
  echo
  echo "ทุก \`evidence\` ต้องเป็น URL ที่มีอยู่จริงใน [data/resources.yml](data/resources.yml)"
  echo "— \`entity-check.sh\` บังคับข้อนี้ ทำให้กราฟอ้างอะไรที่ไม่มีของรองรับไม่ได้"
} > "$OUT"

echo "เขียน $OUT แล้ว ($n_ent หน่วยงาน · $n_rel ความสัมพันธ์)"

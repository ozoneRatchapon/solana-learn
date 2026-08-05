#!/usr/bin/env bash
# generate RADAR.md จาก data/opportunities.yml — อย่าแก้ RADAR.md ด้วยมือ
#   ./scripts/render-radar.sh
#
# เรียงตามความเร่ง ไม่ใช่ตามหมวด — ของที่ปิดเร็วที่สุดต้องอยู่บนสุดเสมอ

set -uo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
need yq

OPPS="${OPPS:-$REPO_ROOT/data/opportunities.yml}"
OUT="${RADAR_OUT:-$REPO_ROOT/RADAR.md}"
TODAY="${TODAY_OVERRIDE:-$(date +%F)}"
SEP=$'\x1f'

days_left() {  # $1 = YYYY-MM-DD
  local a b
  a="$(date -j -f %Y-%m-%d "$1" +%s 2>/dev/null || date -d "$1" +%s)"
  b="$(date -j -f %Y-%m-%d "$TODAY" +%s 2>/dev/null || date -d "$TODAY" +%s)"
  echo $(( (a - b) / 86400 ))
}

n="$(yq -r '.opportunities | length' "$OPPS")"

{
  echo "# Radar — โอกาสที่เปิดอยู่"
  echo
  echo "> generate จาก [data/opportunities.yml](data/opportunities.yml) — **อย่าแก้ตรงนี้**"
  echo "> แก้ YAML แล้วรัน \`./scripts/render-radar.sh\`"
  echo
  echo "**$n รายการ** · อัปเดต $TODAY"
  echo
  echo "แยกจาก [CATALOG.md](CATALOG.md) เพราะเน่าคนละแบบ — แคตตาล็อกเน่าเมื่อ **ลิงก์** เปลี่ยน"
  echo "ไฟล์นี้เน่าเมื่อ **เวลา** ผ่านไป bounty ที่ปิดแล้วยังตอบ HTTP 200 อยู่ \`linkcheck\` จับไม่ได้"
  echo "\`radar-check.sh\` เลยเทียบวันที่แทน และเตือนล่วงหน้า 7 วัน"
  echo
  echo "ทุกรายการมีช่อง **verdict** — คำตัดสินว่าทำได้จริงไหมและรู้ได้ยังไง ไม่ใช่กำลังใจ"
  echo "ถ้าเขียน verdict ไม่ได้ แปลว่ายังไม่ได้คิดจริง รายการนั้นจะถูกทำเครื่องหมาย \`unproven\`"
  echo

  # ── มีเดดไลน์จริง เรียงตามวันที่เหลือน้อยสุด
  echo "## ⏳ มีเดดไลน์"
  echo
  dated="$(yq -r ".opportunities[] | select(.closes != \"rolling\") | [.closes, .id, .name, .url, .reward, .status] | join(\"$SEP\")" "$OPPS" | sort)"
  if [ -z "$dated" ]; then
    echo "_ตอนนี้ไม่มีรายการที่มีเดดไลน์_"
    echo
  else
    echo "| ปิด | เหลือ | อะไร | ได้อะไร |"
    echo "|---|---:|---|---|"
    while IFS="$SEP" read -r closes id name url reward status; do
      [ -z "$id" ] && continue
      d="$(days_left "$closes")"
      if [ "$d" -lt 0 ]; then left="**ปิดแล้ว**"
      elif [ "$d" -le 7 ]; then left="**$d วัน**"
      else left="$d วัน"; fi
      printf '| %s | %s | [%s](%s) | %s |\n' "$closes" "$left" "$name" "$url" "$reward"
    done <<<"$dated"
    echo
  fi

  # ── เปิดตลอด
  echo "## ♾️ เปิดตลอด — ทำเมื่อไหร่ก็ได้"
  echo
  echo "| อะไร | ได้อะไร | สถานะ |"
  echo "|---|---|---|"
  yq -r ".opportunities[] | select(.closes == \"rolling\") | [.name, .url, .reward, .status] | join(\"$SEP\")" "$OPPS" \
  | while IFS="$SEP" read -r name url reward status; do
      case "$status" in
        ready)    badge='✅ ลงมือได้' ;;
        unproven) badge='❓ ต้องพิสูจน์ก่อน' ;;
        watching) badge='👀 รอจังหวะ' ;;
        *)        badge="$status" ;;
      esac
      printf '| [%s](%s) | %s | %s |\n' "$name" "$url" "$reward" "$badge"
    done
  echo

  # ── รายละเอียดทีละอัน เรียง ready ก่อน
  echo "---"
  echo
  echo "## รายละเอียด"
  echo
  for st in ready unproven watching; do
    label="$(yq -r ".statuses.\"$st\"" "$OPPS")"
    cnt="$(yq -r "[.opportunities[] | select(.status == \"$st\")] | length" "$OPPS")"
    [ "$cnt" = "0" ] && continue
    echo "### $st — $label ($cnt)"
    echo
    yq -r "
      .opportunities[] | select(.status == \"$st\")
      | [.name, .url, .kind, .opens, .closes, .reward, .fit, .effort, (.verdict | sub(\"\n\"; \" \")), .checked]
      | join(\"$SEP\")
    " "$OPPS" \
    | while IFS="$SEP" read -r name url kind opens closes reward fit effort verdict checked; do
        printf '#### [%s](%s)\n\n' "$name" "$url"
        printf '`%s` · เปิด %s · ปิด %s · **%s**\n\n' "$kind" "$opens" "$closes" "$reward"
        printf -- '- **ใครเหมาะ** — %s\n' "$fit"
        printf -- '- **แรงที่ต้องใช้** — %s\n' "$effort"
        printf -- '- **verdict** — %s\n' "$verdict"
        printf -- '- _ยืนยันล่าสุด %s_\n\n' "$checked"
      done
  done

  echo "---"
  echo
  echo "ทุก \`url\` ต้องมีอยู่จริงใน [data/resources.yml](data/resources.yml) — \`radar-check.sh\` บังคับ"
  echo "ทำให้ radar อ้างโอกาสที่ไม่มีของรองรับในแคตตาล็อกไม่ได้"
} > "$OUT"

echo "เขียน $OUT แล้ว ($n รายการ)"

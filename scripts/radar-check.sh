#!/usr/bin/env bash
# ตรวจ data/opportunities.yml — เน้นเรื่องที่ linkcheck จับไม่ได้: เวลา
#
#   ./scripts/radar-check.sh
#   ./scripts/radar-check.sh --self-test
#
# bounty ที่ปิดไปแล้วยังตอบ HTTP 200 อยู่ ตัวที่จับได้คือการเทียบวันที่เท่านั้น
# ไฟล์นี้เลยเป็นตัวเดียวใน repo ที่ fail เพราะ "วันนี้เป็นวันอะไร" ไม่ใช่เพราะเนื้อไฟล์เปลี่ยน

set -uo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
need yq

OPPS="${OPPS:-$REPO_ROOT/data/opportunities.yml}"
TODAY="${TODAY_OVERRIDE:-$(date +%F)}"

fails=0; warns=0
ok()   { printf '  \033[32m✓\033[0m %s\n' "$1"; }
bad()  { printf '  \033[31m✗\033[0m %s\n' "$1"; fails=$((fails+1)); }
warn() { printf '  \033[33m!\033[0m %s\n' "$1"; warns=$((warns+1)); }

yq_or_die() {
  local out
  if ! out="$(yq -r "$1" "$OPPS" 2>&1)"; then
    printf '\033[31myq ล้มที่: %s\n%s\033[0m\n' "$1" "$out" >&2; exit 2
  fi
  printf '%s\n' "$out"
}

run_checks() {
  local n; n="$(yq_or_die '.opportunities | length')"
  printf '\n\033[1m1. โครงสร้าง (%s โอกาส · วันนี้ %s)\033[0m\n' "$n" "$TODAY"

  local f miss
  for f in id name url kind opens closes reward fit effort verdict status checked; do
    miss="$(yq_or_die "[.opportunities[] | select(has(\"$f\") | not)] | length")"
    if [ "$miss" = "0" ]; then ok "ทุกรายการมี $f"; else bad "$miss รายการไม่มี $f"; fi
  done

  # verdict สั้นเกินไป = ยังไม่ได้คิดจริง ตามที่หัวไฟล์กำหนด
  local shortv
  shortv="$(yq_or_die '[.opportunities[] | select((.verdict // "" | length) < 60) | .id] | join(", ")')"
  if [ -z "$shortv" ]; then ok "verdict ทุกอันยาวพอให้เป็นคำตัดสินจริง"
  else bad "verdict สั้นเกินไป (ต่ำกว่า 60 ตัวอักษร): $shortv"; fi

  printf '\n\033[1m2. รายการปิด\033[0m\n'
  local kinds statuses badk bads x
  kinds="$(yq_or_die '.kinds | keys | .[]')"
  statuses="$(yq_or_die '.statuses | keys | .[]')"
  badk=""; while IFS= read -r x; do [ -z "$x" ] && continue
    grep -qxF "$x" <<<"$kinds" || badk="$badk $x"; done <<<"$(yq_or_die '.opportunities[].kind')"
  [ -z "$badk" ] && ok "kind ทุกตัวประกาศไว้แล้ว" || bad "kind ที่ไม่ได้ประกาศ:$badk"
  bads=""; while IFS= read -r x; do [ -z "$x" ] && continue
    grep -qxF "$x" <<<"$statuses" || bads="$bads $x"; done <<<"$(yq_or_die '.opportunities[].status')"
  [ -z "$bads" ] && ok "status ทุกตัวประกาศไว้แล้ว" || bad "status ที่ไม่ได้ประกาศ:$bads"

  printf '\n\033[1m3. url ต้องอยู่ในแคตตาล็อกจริง\033[0m\n'
  local urls u missing=0
  urls="$(yq -r '.resources[].url' "$DATA" | while read -r x; do printf '%s\n' "$(norm "$x")"; done)"
  while IFS= read -r u; do
    [ -z "$u" ] && continue
    grep -qxF "$(norm "$u")" <<<"$urls" || { bad "url ไม่มีใน resources.yml: $u"; missing=$((missing+1)); }
  done <<<"$(yq_or_die '.opportunities[].url')"
  [ "$missing" = "0" ] && ok "ทุก url มีของจริงรองรับในแคตตาล็อก"

  printf '\n\033[1m4. เวลา — สิ่งที่ linkcheck จับไม่ได้\033[0m\n'
  local id closes expired=0 soon=0
  while IFS="$SEP" read -r id closes; do
    [ -z "$id" ] && continue
    [ "$closes" = "rolling" ] && continue
    if [[ ! "$closes" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
      bad "$id: closes ไม่ใช่ YYYY-MM-DD หรือ rolling ($closes)"; continue
    fi
    if [[ "$closes" < "$TODAY" ]]; then
      warn "$id ปิดไปแล้วเมื่อ $closes — ย้ายออกหรือเปลี่ยนเป็นรอบถัดไป"; expired=$((expired+1))
    else
      # เตือนล่วงหน้าเมื่อเหลือไม่เกิน 7 วัน
      local d; d="$(( ( $(date -j -f %Y-%m-%d "$closes" +%s 2>/dev/null || date -d "$closes" +%s) - $(date -j -f %Y-%m-%d "$TODAY" +%s 2>/dev/null || date -d "$TODAY" +%s) ) / 86400 ))"
      if [ "$d" -le 7 ]; then warn "$id เหลืออีก $d วัน (ปิด $closes)"; soon=$((soon+1)); fi
    fi
  done <<<"$(yq_or_die "[.opportunities[] | [.id, .closes] | join(\"$SEP\")] | .[]")"
  [ "$expired" = "0" ] && ok "ไม่มีรายการที่ปิดไปแล้วค้างอยู่"
  [ "$soon" = "0" ] && ok "ไม่มีรายการที่ใกล้ปิดใน 7 วัน"

  printf '\n'
  if [ "$fails" -gt 0 ]; then printf '\033[31mไม่ผ่าน %s ข้อ\033[0m (เตือน %s)\n' "$fails" "$warns"; return 1; fi
  printf '\033[32mผ่าน\033[0m — %s โอกาส (เตือน %s)\n' "$n" "$warns"
  return 0
}

if [ "${1:-}" = "--self-test" ]; then
  tmp="$(mktemp)"; trap 'rm -f "$tmp"' EXIT
  pass=0; total=0
  probe() {
    total=$((total+1)); cp "$OPPS" "$tmp"; printf '%s\n' "$2" >> "$tmp"
    if OPPS="$tmp" "$0" >/dev/null 2>&1; then printf '  \033[31m✗\033[0m ไม่จับ: %s\n' "$1"
    else printf '  \033[32m✓\033[0m จับได้: %s\n' "$1"; pass=$((pass+1)); fi
  }
  printf '\n\033[1mself-test\033[0m\n'
  probe "verdict สั้นเกินไป" '  - { id: lazy, name: Lazy, url: https://pay.sh/, kind: grant, opens: rolling, closes: rolling, reward: x, fit: x, effort: x, verdict: "น่าสนใจ", status: ready, checked: 2026-08-05 }'
  probe "status ที่ไม่ได้ประกาศ" '  - { id: bogus, name: Bogus, url: https://pay.sh/, kind: grant, opens: rolling, closes: rolling, reward: x, fit: x, effort: x, verdict: "ยาวพอแล้วนะครับ ทดสอบว่าตัวตรวจจับ status ที่ไม่ได้ประกาศไว้ได้จริงหรือเปล่า", status: maybe, checked: 2026-08-05 }'
  probe "url ที่ไม่มีในแคตตาล็อก" '  - { id: ghost, name: Ghost, url: https://example.invalid/x, kind: grant, opens: rolling, closes: rolling, reward: x, fit: x, effort: x, verdict: "ยาวพอแล้วนะครับ ทดสอบว่าตัวตรวจจับ url ที่ไม่มีในแคตตาล็อกได้จริงหรือเปล่า", status: ready, checked: 2026-08-05 }'
  printf '\nself-test: %s/%s\n' "$pass" "$total"
  [ "$pass" = "$total" ] || exit 1
  exit 0
fi

run_checks

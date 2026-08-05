#!/usr/bin/env bash
# ตรวจ data/recipes.yml
#   ./scripts/recipe-check.sh
#   ./scripts/recipe-check.sh --self-test
#
# สองข้อที่ตรวจแล้วมีค่าที่สุด:
#   1. ทุก url ใน uses ต้องมีในแคตตาล็อกจริง — สูตรอ้างของที่ไม่เคยตรวจไม่ได้
#   2. ต้องมี constraints อย่างน้อย 1 ข้อ — สูตรที่ไม่มีข้อจำกัดคือ tutorial ธรรมดา
#      ซึ่งมีเยอะแล้วบนเน็ต ข้อจำกัดคือส่วนที่ทำให้สูตรมีค่า

set -uo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
need yq

RECIPES="${RECIPES:-$REPO_ROOT/data/recipes.yml}"

fails=0
ok()  { printf '  \033[32m✓\033[0m %s\n' "$1"; }
bad() { printf '  \033[31m✗\033[0m %s\n' "$1"; fails=$((fails+1)); }

yq_or_die() {
  local out
  if ! out="$(yq -r "$1" "$RECIPES" 2>&1)"; then
    printf '\033[31myq ล้มที่: %s\n%s\033[0m\n' "$1" "$out" >&2; exit 2
  fi
  printf '%s\n' "$out"
}

run_checks() {
  local n; n="$(yq_or_die '.recipes | length')"
  printf '\n\033[1m1. โครงสร้าง (%s สูตร)\033[0m\n' "$n"

  local f miss
  for f in id problem constraints uses approach watch_out status checked; do
    miss="$(yq_or_die "[.recipes[] | select(has(\"$f\") | not)] | length")"
    [ "$miss" = "0" ] && ok "ทุกสูตรมี $f" || bad "$miss สูตรไม่มี $f"
  done

  local dupes; dupes="$(yq_or_die '.recipes[].id' | sort | uniq -d)"
  [ -z "$dupes" ] && ok "id ไม่ซ้ำ" || bad "id ซ้ำ: $dupes"

  printf '\n\033[1m2. ข้อจำกัดคือหัวใจ\033[0m\n'
  local noc; noc="$(yq_or_die '[.recipes[] | select((.constraints // [] | length) < 1) | .id] | join(", ")')"
  [ -z "$noc" ] && ok "ทุกสูตรระบุข้อจำกัดอย่างน้อย 1 ข้อ" || bad "ไม่มีข้อจำกัด: $noc"

  local thin; thin="$(yq_or_die '[.recipes[] | select((.approach // "" | length) < 80) | .id] | join(", ")')"
  [ -z "$thin" ] && ok "approach ทุกอันยาวพอให้อธิบายการประกอบได้" || bad "approach สั้นเกินไป: $thin"

  printf '\n\033[1m3. status ต้องซื่อสัตย์\033[0m\n'
  local sts bads x
  sts="$(yq_or_die '.statuses | keys | .[]')"
  bads=""; while IFS= read -r x; do [ -z "$x" ] && continue
    grep -qxF "$x" <<<"$sts" || bads="$bads $x"; done <<<"$(yq_or_die '.recipes[].status')"
  [ -z "$bads" ] && ok "status ทุกตัวประกาศไว้แล้ว" || bad "status ที่ไม่ได้ประกาศ:$bads"

  local nproven; nproven="$(yq_or_die '[.recipes[] | select(.status == "proven")] | length')"
  ok "proven $nproven · untested $(( n - nproven )) — untested ไม่ใช่ข้อเสีย ที่แย่คือใส่ proven ทั้งที่ยังไม่เคยทำ"

  printf '\n\033[1m4. uses ต้องอยู่ในแคตตาล็อกจริง\033[0m\n'
  local urls u missing=0
  urls="$(yq -r '.resources[].url' "$DATA" | while read -r x; do printf '%s\n' "$(norm "$x")"; done)"
  while IFS= read -r u; do
    [ -z "$u" ] && continue
    grep -qxF "$(norm "$u")" <<<"$urls" || { bad "uses ชี้ไป url ที่ไม่มีในแคตตาล็อก: $u"; missing=$((missing+1)); }
  done <<<"$(yq_or_die '[.recipes[].uses[]] | .[]')"
  [ "$missing" = "0" ] && ok "ทุก url ใน uses มีของจริงรองรับ"

  printf '\n'
  [ "$fails" -gt 0 ] && { printf '\033[31mไม่ผ่าน %s ข้อ\033[0m\n' "$fails"; return 1; }
  printf '\033[32mผ่าน\033[0m — %s สูตร\n' "$n"
  return 0
}

if [ "${1:-}" = "--self-test" ]; then
  tmp="$(mktemp)"; trap 'rm -f "$tmp"' EXIT
  pass=0; total=0
  probe() {
    total=$((total+1)); cp "$RECIPES" "$tmp"; printf '%s\n' "$2" >> "$tmp"
    if RECIPES="$tmp" "$0" >/dev/null 2>&1; then printf '  \033[31m✗\033[0m ไม่จับ: %s\n' "$1"
    else printf '  \033[32m✓\033[0m จับได้: %s\n' "$1"; pass=$((pass+1)); fi
  }
  printf '\n\033[1mself-test\033[0m\n'
  probe "สูตรที่ไม่มีข้อจำกัด" '  - { id: noconstraint, problem: x, constraints: [], uses: [https://pay.sh/], approach: "ยาวพอสมควรเพื่อให้ผ่านการตรวจความยาวของ approach ที่กำหนดไว้แปดสิบตัวอักษรขึ้นไปนะครับ", watch_out: x, status: untested, checked: 2026-08-05 }'
  probe "uses ชี้ไปของที่ไม่มีในแคตตาล็อก" '  - { id: ghostuse, problem: x, constraints: [a], uses: [https://example.invalid/x], approach: "ยาวพอสมควรเพื่อให้ผ่านการตรวจความยาวของ approach ที่กำหนดไว้แปดสิบตัวอักษรขึ้นไปนะครับ", watch_out: x, status: untested, checked: 2026-08-05 }'
  probe "status ที่ไม่ได้ประกาศ" '  - { id: badstatus, problem: x, constraints: [a], uses: [https://pay.sh/], approach: "ยาวพอสมควรเพื่อให้ผ่านการตรวจความยาวของ approach ที่กำหนดไว้แปดสิบตัวอักษรขึ้นไปนะครับ", watch_out: x, status: maybe, checked: 2026-08-05 }'
  printf '\nself-test: %s/%s\n' "$pass" "$total"
  [ "$pass" = "$total" ] || exit 1
  exit 0
fi

run_checks

#!/usr/bin/env bash
# ตรวจ data/entities.yml ก่อนเชื่ออะไรจากกราฟ
#
#   ./scripts/entity-check.sh
#   ./scripts/entity-check.sh --self-test    # พิสูจน์ว่าตัวตรวจจับของผิดได้จริง
#
# ตรวจ 4 ชั้น:
#   1. โครงสร้าง  — field ครบ, id ไม่ซ้ำ
#   2. รายการปิด  — kind กับ relation type ต้องประกาศไว้แล้ว (ที่ที่ kind: person ถูกกัน)
#   3. หลักฐาน    — ทุก evidence ต้องเป็น URL ที่มีอยู่จริงใน resources.yml
#   4. ความเป็นส่วนตัว — ตาข่ายชั้นสองสำหรับรูปแบบข้อมูลติดต่อส่วนบุคคล
#
# ชั้น 2 คือ guard ตัวจริง ไม่ใช่ชั้น 4 — regex กันข้อมูลส่วนตัวไม่ได้จริง
# (ทดลองแล้วเจาะแตกทุกแบบ) สิ่งที่กันได้คือการไม่มี kind: person ให้ใช้ตั้งแต่แรก
#
# บทเรียนจากรอบแรกของสคริปต์นี้: เขียน yq ด้วย index() ซึ่ง mikefarah yq ไม่รองรับ
# → yq พ่น error ลง stderr แล้วคืนสตริงว่าง → เงื่อนไข "ว่าง = ผ่าน" ทำให้รายงานว่าผ่านทั้งที่ไม่ได้ตรวจ
# ตรงกับที่ CLAUDE.md เตือนว่า **ตัวตรวจที่โกหกแย่กว่าไม่มีตัวตรวจ** จึงเปลี่ยนมาเทียบฝั่ง bash
# ที่อ่านออกด้วยตา และเพิ่ม --self-test ไว้พิสูจน์ว่ามันจับของผิดได้จริง

set -uo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
need yq

ENTITIES="${ENTITIES:-$REPO_ROOT/data/entities.yml}"

fails=0
ok()  { printf '  \033[32m✓\033[0m %s\n' "$1"; }
bad() { printf '  \033[31m✗\033[0m %s\n' "$1"; fails=$((fails+1)); }

# yq ที่ล้มต้องดังเสมอ ห้ามปล่อยให้คืนค่าว่างแล้วตีความว่าผ่าน
yq_or_die() {
  local out
  if ! out="$(yq -r "$1" "$ENTITIES" 2>&1)"; then
    printf '\033[31myq ล้มที่: %s\n%s\033[0m\n' "$1" "$out" >&2
    exit 2
  fi
  printf '%s\n' "$out"
}

run_checks() {
  local n_ent n_rel
  n_ent="$(yq_or_die '.entities | length')"
  n_rel="$(yq_or_die '.relations | length')"

  printf '\n\033[1m1. โครงสร้าง (%s entity · %s relation)\033[0m\n' "$n_ent" "$n_rel"

  local f miss
  for f in id name kind evidence reach confirmed; do
    miss="$(yq_or_die "[.entities[] | select(has(\"$f\") | not)] | length")"
    if [ "$miss" = "0" ]; then ok "ทุก entity มี $f"; else bad "$miss entity ไม่มี $f"; fi
  done

  local dupes
  dupes="$(yq_or_die '.entities[].id' | sort | uniq -d)"
  if [ -z "$dupes" ]; then ok "id ไม่ซ้ำ"; else bad "id ซ้ำ: $(echo "$dupes" | tr '\n' ' ')"; fi

  printf '\n\033[1m2. รายการปิด\033[0m\n'

  # เทียบฝั่ง bash — อ่านออกด้วยตาและไม่มีทางคืนค่าว่างเงียบๆ
  local kinds rtypes badkind badrel k t
  kinds="$(yq_or_die '.kinds | keys | .[]')"
  rtypes="$(yq_or_die '.relation_types | keys | .[]')"

  badkind=""
  while IFS= read -r k; do
    [ -z "$k" ] && continue
    grep -qxF "$k" <<<"$kinds" || badkind="$badkind $k"
  done <<<"$(yq_or_die '.entities[].kind')"
  if [ -z "$badkind" ]; then ok "kind ทุกตัวประกาศไว้แล้ว (ไม่มี person ตามที่ตั้งใจ)"
  else bad "kind ที่ไม่ได้ประกาศ:$badkind"; fi

  badrel=""
  while IFS= read -r t; do
    [ -z "$t" ] && continue
    grep -qxF "$t" <<<"$rtypes" || badrel="$badrel $t"
  done <<<"$(yq_or_die '.relations[].type')"
  if [ -z "$badrel" ]; then ok "relation type ทุกตัวประกาศไว้แล้ว"
  else bad "relation type ที่ไม่ได้ประกาศ:$badrel"; fi

  local ids dangling side
  ids="$(yq_or_die '.entities[].id')"
  dangling=""
  while IFS= read -r side; do
    [ -z "$side" ] && continue
    grep -qxF "$side" <<<"$ids" || dangling="$dangling $side"
  done <<<"$(yq_or_die '[.relations[].from] + [.relations[].to] | .[]')"
  if [ -z "$dangling" ]; then ok "relation ทุกเส้นชี้ไป entity ที่มีจริง"
  else bad "relation ชี้ไป id ที่ไม่มี:$dangling"; fi

  printf '\n\033[1m3. หลักฐานต้องอยู่ในแคตตาล็อกจริง\033[0m\n'

  # norm() ใช้ printf %s ไม่มีท้ายบรรทัด — ต้องเติมเอง ไม่งั้น 180 URL ต่อกันเป็นบรรทัดเดียว
  local urls ev missing=0
  urls="$(yq -r '.resources[].url' "$DATA" | while read -r u; do printf '%s\n' "$(norm "$u")"; done)"
  while IFS= read -r ev; do
    [ -z "$ev" ] && continue
    if ! grep -qxF "$(norm "$ev")" <<<"$urls"; then
      bad "evidence ไม่มีใน resources.yml: $ev"; missing=$((missing+1))
    fi
  done <<<"$(yq_or_die '[.entities[].evidence, .relations[].evidence] | .[]')"
  [ "$missing" = "0" ] && ok "ทุก evidence มีของจริงรองรับในแคตตาล็อก"

  printf '\n\033[1m4. ตาข่ายกันข้อมูลส่วนบุคคล (ชั้นสอง)\033[0m\n'

  # ตัดคอมเมนต์ออกก่อน ไม่งั้นตัวอย่างที่เขียนอธิบายไว้ในหัวไฟล์จะถูกจับเอง
  local body leak=0
  body="$(grep -v '^[[:space:]]*#' "$ENTITIES")"
  if grep -qEi '[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}' <<<"$body"; then bad "เจอรูปแบบอีเมล"; leak=1; fi
  if grep -qE '(\+?66|0)[ -]?[689][0-9][ -]?[0-9]{3}[ -]?[0-9]{4}' <<<"$body"; then bad "เจอรูปแบบเบอร์โทร"; leak=1; fi
  if grep -qEi '(t\.me/|line\.me/|discord(app)?\.com/users/|wa\.me/)' <<<"$body"; then bad "เจอลิงก์ช่องทางส่วนตัว (DM)"; leak=1; fi
  [ "$leak" = "0" ] && ok "ไม่เจอรูปแบบข้อมูลติดต่อส่วนบุคคล"

  printf '\n'
  if [ "$fails" -gt 0 ]; then
    printf '\033[31mไม่ผ่าน %s ข้อ\033[0m\n' "$fails"; return 1
  fi
  printf '\033[32mผ่าน\033[0m — %s entity · %s relation\n' "$n_ent" "$n_rel"
  return 0
}

# --self-test: ยัดของผิดลงสำเนาแล้วต้องจับได้ทุกกรณี
if [ "${1:-}" = "--self-test" ]; then
  tmp="$(mktemp)"; trap 'rm -f "$tmp"' EXIT
  pass=0; total=0
  probe() {
    total=$((total+1))
    cp "$ENTITIES" "$tmp"
    printf '%s\n' "$2" >> "$tmp"
    if ENTITIES="$tmp" "$0" >/dev/null 2>&1; then
      printf '  \033[31m✗\033[0m ไม่จับ: %s\n' "$1"
    else
      printf '  \033[32m✓\033[0m จับได้: %s\n' "$1"; pass=$((pass+1))
    fi
  }
  printf '\n\033[1mself-test — ตัวตรวจต้องไม่ผ่านเมื่อเจอของพวกนี้\033[0m\n'
  probe "kind: person" '  - { id: someone, name: Someone, kind: person, evidence: https://pay.sh/, reach: x, confirmed: 2026-08-05 }'
  probe "relation type ที่ไม่ได้ประกาศ" 'x_extra_relations: []
relations:
  - { from: anza, type: gossips-with, to: agave, evidence: https://pay.sh/ }'
  probe "evidence ที่ไม่มีในแคตตาล็อก" '  - { id: ghost, name: Ghost, kind: org, evidence: https://example.invalid/nope, reach: x, confirmed: 2026-08-05 }'
  printf '\nself-test: %s/%s\n' "$pass" "$total"
  [ "$pass" = "$total" ] || exit 1
  exit 0
fi

run_checks

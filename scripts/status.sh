#!/usr/bin/env bash
# บอกสถานะทั้ง repo ในคำสั่งเดียว — คำสั่งแรกที่ควรรันเมื่อเข้ามาใหม่
#
#   ./scripts/status.sh          # สถานะ + แผนที่คำสั่ง
#   ./scripts/status.sh --map    # เอาแค่แผนที่คำสั่ง
#
# ทำไมต้องมี:
# AI ที่เข้ามาใหม่จะไล่ ls, grep, อ่านสคริปต์ทีละตัวเพื่อหาว่ามีอะไรบ้างและตอนนี้เป็นยังไง
# ซึ่งกินโทเคนหลักพันและได้ภาพที่ไม่ครบอยู่ดี ตัวนี้ตอบทีเดียวจบ
# **และที่สำคัญกว่าคือกันไม่ให้แก้ไฟล์ที่ generate มา** เพราะแผนที่บอกชัดว่าไฟล์ไหนมาจากไหน

set -uo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
need yq

b() { printf '\033[1m%s\033[0m\n' "$1"; }
dim() { printf '\033[2m%s\033[0m\n' "$1"; }

show_map() {
  b 'แผนที่คำสั่ง — ไฟล์ .md ทุกไฟล์ generate มา ห้ามแก้ด้วยมือ'
  cat <<'MAP'

  ข้อมูล (แก้ที่นี่เท่านั้น)          ผลที่ generate ออกมา
  ─────────────────────────────────  ────────────────────────────
  data/resources.yml                 CATALOG.md      ← render.sh
  data/entities.yml                  GRAPH.md        ← render-graph.sh
  data/opportunities.yml             RADAR.md        ← render-radar.sh
  data/recipes.yml                   RECIPES.md      ← render-recipes.sh
  data/rejected.yml                  (โผล่ใน CATALOG)
  (ยิง npm/crates สด)                VERSIONS.md     ← render-versions.sh
  ทุกไฟล์ข้างบน                       web/index.html  ← render-web.sh
                                     web/dist/*      ← render-agent.sh

  เพิ่ม/แก้ข้อมูล
    check.sh <url>...       ซ้ำไหม — ตอบ [มีแล้ว]/[เคยไม่เอา]/[ใกล้เคียง]/[ใหม่]
    probe.sh <url>...       เชื่อข้อมูลที่ดึงมาได้แค่ไหน — รันก่อนเขียนโน้ตเสมอ
    add.sh -u -n -c -s -t -m   เพิ่ม entry (-m บังคับ ขั้นต่ำ 20 ตัวอักษร)
    reject.sh -u -r [-b]    ตัดสินใจไม่เก็บ ก็ต้องบันทึก
    deprecate.sh -u -r [-b] ยังเปิดได้แต่ไม่ควรใช้แล้ว (คนละฟิลด์กับ status)
    setnote.sh <url> "..."  แก้โน้ตของ entry เดิม (--from-tsv ทีละชุดได้)

  ตรวจ
    audit.sh                4 ชั้น · CI รันตัวนี้ทุก push · ต้องผ่านก่อน commit
    linkcheck.sh [--fix]    HTTP code (blocked = เว็บกัน bot ไม่ใช่ลิงก์เสีย)
    ghcheck.sh              repo ย้าย org / archived — linkcheck มองไม่เห็น
    entity-check.sh         กราฟ + กฎ evidence   (--self-test ได้)
    radar-check.sh          โอกาสหมดอายุ + kind ที่ประกาศไว้
    recipe-check.sh         สูตรอ้าง url ที่มีจริงไหม
    gate_slcat.sh           bash กับ rust ต้องเห็นข้อมูลตรงกัน

  ออกสู่สาธารณะ
    deploy.sh --go          build + deploy + ตรวจไบต์ทุกไฟล์ที่เสิร์ฟจริง
    web.sh                  ดูเว็บในเครื่องก่อน deploy

  ทดสอบโดยไม่แตะไฟล์จริง:  DATA=/tmp/copy.yml ./scripts/add.sh ...
MAP
}

[ "${1:-}" = "--map" ] && { show_map; exit 0; }

today="$(date +%F)"
printf '\n'
b "solana-learn — $today"
dim "$(git -C "$REPO_ROOT" log -1 --format='%h %s' 2>/dev/null | cut -c1-72)"
printf '\n'

# ── ตัวเลข ──
n_res="$(yq -r '.resources | length' "$DATA")"
n_cat="$(yq -r '.categories | length' "$DATA")"
n_dep="$(yq -r '[.resources[] | select(has("deprecated"))] | length' "$DATA")"
n_rej="$(yq -r '(.rejected // []) | length' "$REPO_ROOT/data/rejected.yml" 2>/dev/null || echo 0)"
n_ent="$(yq -r '.entities | length' "$REPO_ROOT/data/entities.yml")"
n_opp="$(yq -r '.opportunities | length' "$REPO_ROOT/data/opportunities.yml")"
n_rec="$(yq -r '.recipes | length' "$REPO_ROOT/data/recipes.yml")"
n_prov="$(yq -r '[.recipes[] | select(.status == "proven")] | length' "$REPO_ROOT/data/recipes.yml")"
b 'ข้อมูล'
printf '  %s resource · %s หมวด · %s deprecated · %s ปฏิเสธไว้\n' "$n_res" "$n_cat" "$n_dep" "$n_rej"
printf '  %s entity · %s โอกาส · %s สูตร (\033[1mproven %s\033[0m)\n\n' "$n_ent" "$n_opp" "$n_rec" "$n_prov"

# ── ตัวตรวจ ── รันเฉพาะตัวที่ไม่ต้องยิงเน็ต จะได้ไม่ช้า
b 'ตัวตรวจที่ไม่ต้องต่อเน็ต'
for c in audit entity-check radar-check recipe-check; do
  if "$REPO_ROOT/scripts/$c.sh" >/dev/null 2>&1; then
    printf '  \033[32m✓\033[0m %s\n' "$c"
  else
    printf '  \033[31m✗\033[0m %s  ← รันดูว่าพังตรงไหน\n' "$c"
  fi
done
dim '  (linkcheck / ghcheck ต้องยิงเน็ต รันแยกเมื่อจะตรวจ)'
printf '\n'

# ── เดดไลน์ ── ตัวเลข "เหลืออีกกี่วัน" คำนวณสดเสมอ ห้าม generate แช่ไว้
b 'ใกล้ปิด 14 วันข้างหน้า'
yq -r '.opportunities[] | select(.closes != "rolling") | [.closes, .status, .name] | @tsv' \
  "$REPO_ROOT/data/opportunities.yml" \
| sort | while IFS=$'\t' read -r closes st name; do
    [ "$closes" \< "$today" ] && continue
    d=$(( ( $(date -j -f %Y-%m-%d "$closes" +%s 2>/dev/null || date -d "$closes" +%s) \
          - $(date -j -f %Y-%m-%d "$today"  +%s 2>/dev/null || date -d "$today"  +%s) ) / 86400 ))
    [ "$d" -gt 14 ] && continue
    if [ "$d" -le 2 ]; then col='31'; elif [ "$d" -le 7 ]; then col='33'; else col='2'; fi
    printf '  \033[%sm%2s วัน\033[0m  %s  \033[2m[%s]\033[0m\n' "$col" "$d" "${name:0:52}" "$st"
  done
printf '\n'

# ── git ──
b 'git'
dirty="$(git -C "$REPO_ROOT" status --porcelain | wc -l | tr -d ' ')"
ahead="$(git -C "$REPO_ROOT" rev-list --count @{u}..HEAD 2>/dev/null || echo '?')"
if [ "$dirty" = "0" ] && [ "$ahead" = "0" ]; then
  printf '  \033[32m✓\033[0m สะอาด และ push แล้ว\n'
else
  [ "$dirty" != "0" ] && printf '  \033[33m!\033[0m แก้ค้างไว้ %s ไฟล์\n' "$dirty"
  [ "$ahead" != "0" ] && printf '  \033[33m!\033[0m ยังไม่ push %s commit\n' "$ahead"
fi
printf '\n'
show_map

#!/usr/bin/env bash
# ตรวจว่า repo ยังพูดความจริงอยู่ไหม — รันมือหรือให้ CI รันก็ได้
#
#   ./scripts/audit.sh          # ตรวจทั้งหมด, exit 1 ถ้าเจอปัญหา
#   ./scripts/audit.sh --quiet  # พิมพ์เฉพาะที่ผิด
#
# ตรวจ 4 ชั้น:
#   1. ข้อมูล      — ฟิลด์ที่ต้องมี, หมวดมีจริง, URL ไม่ซ้ำหลัง normalize
#   2. คุณภาพ      — สัดส่วน entry ที่มี note (เตือน ไม่ fail — ดู NOTE_FLOOR)
#   3. คำอ้าง      — ตัวเลขใน README/OPPORTUNITIES ตรงกับ YAML ไหม
#   4. ของ generate — CATALOG.md ตรงกับที่ render ออกมาไหม
#
# ทำไมต้องมี: เอกสารเคยค้างที่ "127 รายการ" ตอนของจริงเป็น 180 อยู่ 4 จุด
# ความน่าเชื่อถือของ OPPORTUNITIES.md ตั้งอยู่บนตัวเลขนั้นทั้งหมด — ถ้าตัวเลขผิด
# ข้อสรุปที่อ้างจากมันก็เชื่อไม่ได้ไปด้วย เลยต้องให้เครื่องตรวจ ไม่ใช่ให้คนจำ

set -uo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
need yq

QUIET=0
case "${1:-}" in
  --quiet) QUIET=1 ;;
  --list-nonote)
    # รายชื่อ entry ที่ยังไม่มี note เรียงตามหมวด — ใช้ไล่เติมทีละหมวด
    # ที่นี่ใช้ @tsv ได้ปลอดภัย เพราะ category/name/url ไม่มีทางว่าง
    yq -r '.resources[] | select(.note == null) | [.category, .name, .url] | @tsv' "$DATA" \
      | sort | awk -F'\t' '{ if ($1 != c) { c=$1; printf "\n\033[1m%s\033[0m\n", c } printf "  %-44s %s\n", $2, $3 }' 
    echo
    yq -r '[.resources[] | select(.note == null)] | length' "$DATA" | sed 's/$/ รายการ — เขียน note แล้วใส่กลับด้วย yq หรือแก้ YAML ตรงๆ/'
    exit 0 ;;
esac

# สัดส่วน note ขั้นต่ำที่ยอมรับได้ — ตั้งใจให้ต่ำกว่าของจริงเล็กน้อย แล้วค่อยๆ ขยับขึ้น
# เมื่อไล่เติม note ได้ (ห้ามลดลง — ตัวเลขนี้เป็นเพดานล่างที่ขยับขึ้นอย่างเดียว)
NOTE_FLOOR="${NOTE_FLOOR:-64}"

fails=0
warns=0
ok()   { [ "$QUIET" = "1" ] || printf '  \033[32m✓\033[0m %s\n' "$1"; }
bad()  { printf '  \033[31m✗\033[0m %s\n' "$1"; fails=$((fails+1)); }
warn() { printf '  \033[33m!\033[0m %s\n' "$1"; warns=$((warns+1)); }
head_() { [ "$QUIET" = "1" ] || printf '\n\033[1m%s\033[0m\n' "$1"; }

total="$(yq -r '.resources | length' "$DATA")"
cats_used="$(yq -r '.resources[].category' "$DATA" | sort -u | wc -l | tr -d ' ')"
dead="$(yq -r '[.resources[] | select(.status == "dead")] | length' "$DATA")"

# ── 1. ข้อมูล ───────────────────────────────────────────────────────────────
head_ "1. ข้อมูล ($total รายการ)"

for f in url name category source status added; do
  n="$(yq -r "[.resources[] | select(.$f == null)] | length" "$DATA")"
  if [ "$n" = "0" ]; then ok "ทุก entry มี $f"; else bad "$n entry ไม่มี $f"; fi
done

orphan="$(comm -23 <(yq -r '.resources[].category' "$DATA" | sort -u) \
                   <(yq -r '.categories | keys | .[]' "$DATA" | sort -u))"
if [ -z "$orphan" ]; then ok "ทุก category มีประกาศใน categories:"
else bad "category ที่ไม่ได้ประกาศ: $(printf '%s' "$orphan" | tr '\n' ' ')"; fi

dup="$(yq -r '.resources[].url' "$DATA" \
      | sed -E 's#^[a-zA-Z]+://##; s#^www\.##; s#[?#].*$##; s#/+$##' \
      | tr '[:upper:]' '[:lower:]' | sort | uniq -d)"
if [ -z "$dup" ]; then ok "ไม่มี URL ซ้ำหลัง normalize"
else bad "URL ซ้ำ: $(printf '%s' "$dup" | tr '\n' ' ')"; fi

# mikefarah yq ไม่มี index()|not แบบ jq — เทียบตรงๆ อ่านง่ายกว่าและพังยากกว่า
badsrc="$(yq -r '[.resources[] | select(
    .source != "foundation" and .source != "anza" and .source != "community"
    and .source != "vendor" and .source != "thailand")] | length' "$DATA")"
if [ "$badsrc" = "0" ]; then ok "source อยู่ในชุดที่กำหนดทั้งหมด"
else bad "$badsrc entry มี source นอกชุดที่กำหนด"; fi

# ── 1b. ทะเบียนที่ปฏิเสธ ───────────────────────────────────────────────────
nrej="$(yq -r '(.rejected // []) | length' "$REJECTED" 2>/dev/null || echo 0)"
head_ "1b. ทะเบียนที่ปฏิเสธ ($nrej รายการ)"

if [ "$nrej" = "0" ]; then
  ok "ยังไม่มีรายการที่ปฏิเสธ (ไฟล์พร้อมใช้)"
else
  for f in url reason checked; do
    n="$(yq -r "[(.rejected // [])[] | select(.$f == null)] | length" "$REJECTED")"
    if [ "$n" = "0" ]; then ok "ทุกรายการมี $f"; else bad "$n รายการที่ปฏิเสธไม่มี $f"; fi
  done

  # เหตุผลสั้นเกินไปก็เท่ากับไม่ได้บันทึก — เกณฑ์เดียวกับ note
  thin="$(yq -r "[(.rejected // [])[] | select((.reason // \"\") | length < 20)] | length" "$REJECTED")"
  if [ "$thin" = "0" ]; then ok "ทุกเหตุผลยาวพอให้อ่านรู้เรื่อง"
  else bad "$thin รายการมีเหตุผลสั้นกว่า 20 ตัวอักษร — เขียนให้คนอ่านแล้วไม่ต้องตรวจซ้ำ"; fi

  # URL ห้ามอยู่ทั้งสองฝั่ง — เก็บและปฏิเสธพร้อมกันไม่ได้
  both="$(comm -12 \
    <(yq -r '.resources[].url' "$DATA" | sed -E 's#^[a-zA-Z]+://##; s#^www\.##; s#[?#].*$##; s#/+$##' | tr 'A-Z' 'a-z' | sort -u) \
    <(yq -r '(.rejected // [])[].url' "$REJECTED" | sed -E 's#^[a-zA-Z]+://##; s#^www\.##; s#[?#].*$##; s#/+$##' | tr 'A-Z' 'a-z' | sort -u))"
  if [ -z "$both" ]; then ok "ไม่มี URL ที่อยู่ทั้งในแคตตาล็อกและทะเบียนปฏิเสธ"
  else bad "URL อยู่ทั้งสองฝั่ง: $(printf '%s' "$both" | tr '\n' ' ')"; fi
fi

# ── 1c. เลิกใช้แล้ว ────────────────────────────────────────────────────────
ndep="$(yq -r '[.resources[] | select(.deprecated != null)] | length' "$DATA")"
head_ "1c. รายการที่เลิกใช้ ($ndep รายการ)"

if [ "$ndep" = "0" ]; then
  warn "ยังไม่มี entry ไหนถูกทำเครื่องหมายว่าเลิกใช้ — ในปีที่ Anchor ขึ้น 1.0 และ web3.js ย้ายไป Kit เป็นไปได้ยากที่จะไม่มีเลย"
else
  thin="$(yq -r '[.resources[] | select(.deprecated != null and ((.deprecated | length) < 20))] | length' "$DATA")"
  if [ "$thin" = "0" ]; then ok "ทุกเหตุผลยาวพอให้อ่านรู้เรื่อง"
  else bad "$thin รายการมีเหตุผลเลิกใช้สั้นกว่า 20 ตัวอักษร"; fi

  nosup="$(yq -r '[.resources[] | select(.deprecated != null and .superseded_by == null)] | length' "$DATA")"
  if [ "$nosup" = "0" ]; then ok "ทุกรายการบอกว่าใช้อะไรแทน"
  else warn "$nosup รายการเลิกใช้แต่ไม่ได้บอกตัวแทน — บอกได้จะช่วยคนอ่านมากกว่า"; fi

  # superseded_by ที่ชี้ไปหา entry ที่เลิกใช้เหมือนกัน = ส่งคนไปเจอทางตันต่อ
  loop="$(yq -r '[.resources[] | select(.deprecated != null) | .superseded_by // ""] | .[]' "$DATA" | while read -r u; do
    if [ -n "$u" ]; then
      if yq -e "[.resources[] | select(.url == \"$u\" and .deprecated != null)] | length > 0" "$DATA" >/dev/null 2>&1; then echo "$u"; fi
    fi
  done)"
  if [ -z "$loop" ]; then ok "ไม่มีตัวแทนที่ตัวเองก็เลิกใช้แล้ว"
  else bad "superseded_by ชี้ไปหาของที่เลิกใช้เหมือนกัน: $(printf '%s' "$loop" | tr '\n' ' ')"; fi
fi

# ── 2. คุณภาพ ──────────────────────────────────────────────────────────────
head_ "2. คุณภาพเนื้อหา"

nonote="$(yq -r '[.resources[] | select(.note == null)] | length' "$DATA")"
withnote=$((total - nonote))
pct=$((withnote * 100 / total))

if [ "$pct" -ge "$NOTE_FLOOR" ]; then
  ok "มี note $withnote/$total ($pct%) — เพดานล่าง $NOTE_FLOOR%"
else
  bad "มี note แค่ $pct% (ต่ำกว่าเพดานล่าง $NOTE_FLOOR%) — $nonote entry ไม่มีเหตุผลกำกับ"
fi

if [ "$nonote" -gt 0 ]; then
  warn "$nonote entry ยังไม่มี note — ดูรายชื่อ: ./scripts/audit.sh --list-nonote"
  worst="$(for c in $(yq -r '.categories|keys|.[]' "$DATA"); do
    t="$(yq -r "[.resources[]|select(.category==\"$c\")]|length" "$DATA")"
    if [ "$t" != "0" ]; then
      n="$(yq -r "[.resources[]|select(.category==\"$c\" and .note==null)]|length" "$DATA")"
      if [ "$n" != "0" ]; then printf '%s %s %s\n' "$((n*100/t))" "$c" "$n/$t"; fi
    fi
  done | sort -rn | head -3 | awk '{printf "%s(%s %s%%) ", $2, $3, $1}')"
  [ -n "$worst" ] && warn "หมวดที่ขาดหนักสุด: $worst"
fi

# ── 3. คำอ้างในเอกสาร ──────────────────────────────────────────────────────
head_ "3. คำอ้างในเอกสาร"

# README = เอกสารสถานะปัจจุบัน → ตัวเลขต้องตรงเป๊ะ
# OPPORTUNITIES = เอกสารวิเคราะห์ ณ เวลาหนึ่ง → ตัวเลขควร "แช่" ไว้ตามวันที่วิเคราะห์
#   การไล่แก้ 127→180 ในนั้นคือการอ้างว่าวิเคราะห์บนข้อมูล 180 ซึ่งไม่จริง
#   สิ่งที่ควรทำคือเตือนให้กลับไปอ่านใหม่เมื่อของจริงโตไปไกลจากตอนวิเคราะห์
claim_mismatch=0
while IFS= read -r line; do
  [ -z "$line" ] && continue
  ln="${line%%:*}"; num="${line##*:}"
  if [ "$num" != "$total" ]; then
    bad "README.md:$ln อ้าง '$num รายการ' แต่จริง $total"; claim_mismatch=1
  fi
done < <(grep -nEo '[0-9]+ ?รายการ' "$REPO_ROOT/README.md" | sed -E 's/([0-9]+):([0-9]+) ?รายการ/\1:\2/')

while IFS= read -r line; do
  [ -z "$line" ] && continue
  ln="${line%%:*}"; num="${line##*:}"
  if [ "$num" != "$cats_used" ]; then
    bad "README.md:$ln อ้าง '$num หมวด' แต่จริง $cats_used"; claim_mismatch=1
  fi
done < <(grep -nEo '[0-9]+ ?หมวด' "$REPO_ROOT/README.md" | sed -E 's/([0-9]+):([0-9]+) ?หมวด/\1:\2/')
[ "$claim_mismatch" = "0" ] && ok "README ตรงกับ YAML ($total รายการ / $cats_used หมวด)"

# OPPORTUNITIES: เตือนเมื่อแคตตาล็อกโตเกิน DRIFT_PCT% จากตอนวิเคราะห์
DRIFT_PCT="${DRIFT_PCT:-25}"
snap="$(grep -oE 'วิเคราะห์จากการรวบรวม [0-9]+ รายการ' "$REPO_ROOT/OPPORTUNITIES.md" 2>/dev/null | grep -oE '[0-9]+' | head -1)"
if [ -n "$snap" ]; then
  growth=$(( (total - snap) * 100 / snap ))
  if [ "$growth" -ge "$DRIFT_PCT" ]; then
    warn "OPPORTUNITIES วิเคราะห์บน $snap รายการ ตอนนี้ $total (+$growth%) — ควรกลับไปอ่านว่าข้อสรุปยังจริงอยู่ไหม ไม่ใช่แค่แก้ตัวเลข"
  else
    ok "OPPORTUNITIES วิเคราะห์บน $snap รายการ ตอนนี้ $total (+$growth%) — ยังไม่ห่างพอต้องทบทวน"
  fi
else
  warn "OPPORTUNITIES ไม่ได้ระบุว่าวิเคราะห์บนกี่รายการ — ระบุไว้จะตรวจ drift ได้"
fi

if grep -q "ลิงก์ตาย 0" "$REPO_ROOT/README.md" 2>/dev/null; then
  if [ "$dead" = "0" ]; then ok "README อ้าง 'ลิงก์ตาย 0' — ตรง"
  else bad "README อ้าง 'ลิงก์ตาย 0' แต่มี $dead รายการ status=dead"; fi
fi

# ── 4. ของ generate ────────────────────────────────────────────────────────
head_ "4. CATALOG.md ตรงกับ YAML"

tmp="$(mktemp)"; trap 'rm -f "$tmp"' EXIT
cp "$REPO_ROOT/CATALOG.md" "$tmp"
if "$REPO_ROOT/scripts/render.sh" >/dev/null 2>&1; then
  if diff -q "$tmp" "$REPO_ROOT/CATALOG.md" >/dev/null; then
    ok "CATALOG.md เป็นผลของ render.sh ล่าสุด"
  else
    bad "CATALOG.md ไม่ตรงกับ YAML — ลืมรัน ./scripts/render.sh (ไฟล์ถูก render ใหม่ให้แล้ว)"
  fi
else
  bad "render.sh รันไม่ผ่าน"
  cp "$tmp" "$REPO_ROOT/CATALOG.md"
fi

# ── สรุป ────────────────────────────────────────────────────────────────────
echo
if [ "$fails" = "0" ]; then
  printf '\033[32mผ่าน\033[0m — %s รายการ · %s หมวด · ลิงก์ตาย %s · note %s%% · ปฏิเสธไว้ %s · เลิกใช้ %s' \
    "$total" "$cats_used" "$dead" "$pct" "$nrej" "$ndep"
  [ "$warns" != "0" ] && printf '  (เตือน %s)' "$warns"
  echo
  exit 0
else
  printf '\033[31mไม่ผ่าน %s ข้อ\033[0m (เตือน %s)\n' "$fails" "$warns"
  exit 1
fi

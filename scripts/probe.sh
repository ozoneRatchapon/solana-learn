#!/usr/bin/env bash
# สำรวจ URL แล้วบอกว่า "ข้อมูลที่ได้เชื่อได้แค่ไหน" ไม่ใช่แค่ดึงเนื้อมา
#
#   ./scripts/probe.sh <url> [url...]
#
# ทำไมต้องมี:
# วันที่ 5 ส.ค. 2026 สรุปผิดจากการดึงหน้าเว็บ 5 ครั้งในวันเดียว และทุกครั้ง
# **ล้มเหลวแบบเงียบ** — curl คืน 200 แล้วเราตีความว่าได้ข้อมูลครบ:
#   · หน้าแท็ก energy-use-reports ตอบ 200 แต่ไม่มีโพสต์ที่เกี่ยวข้องเลย → เพิ่มเข้าแคตตาล็อกผิด
#   · build.magicblock.app ดูเหมือนไม่มีอีเวนต์ → ปฏิเสธทิ้งทั้งที่มีแฮกกาธอนเปิดอยู่
#   · ccaf.io ส่ง gzip มา curl ไม่ decompress → เห็นเป็นหน้าว่าง
#   · world.xyz กัน bot + render ฝั่ง client → เห็นแต่โครง
#   · อ้างตัวเลข Cambridge จากข่าว ไม่ได้เปิดต้นทาง → ตัวเลขนั้นไม่มีในต้นทาง
#
# ตัวนี้ไม่ได้ทำให้ดึงข้อมูลเก่งขึ้น แต่ทำให้ **รู้ตัวว่าดึงได้ไม่ครบ** ซึ่งสำคัญกว่า
# เป้าหมายคือไม่ให้เขียนโน้ตจากข้อมูลที่ไม่รู้ว่าขาด

set -uo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

UA_BROWSER='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0 Safari/537.36'
TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT

c_ok()   { printf '  \033[32m✓\033[0m %s\n' "$1"; }
c_warn() { printf '  \033[33m!\033[0m %s\n' "$1"; }
c_bad()  { printf '  \033[31m✗\033[0m %s\n' "$1"; }
c_dim()  { printf '    \033[2m%s\033[0m\n' "$1"; }

# ดึงข้อความที่มนุษย์อ่านได้ออกจาก HTML
text_of() {
  python3 - "$1" <<'PY' 2>/dev/null || echo ""
import io,re,html,sys
try: t=io.open(sys.argv[1],encoding='utf-8',errors='replace').read()
except Exception: sys.exit()
t=re.sub(r'<script.*?</script>','',t,flags=re.S)
t=re.sub(r'<style.*?</style>','',t,flags=re.S)
t=re.sub(r'<[^>]+>',' ',t)
print(html.unescape(re.sub(r'\s+',' ',t)).strip())
PY
}

probe_one() {
  local url="$1" host base
  host="$(host_of "$url")"
  base="https://$host"

  printf '\n\033[1m%s\033[0m\n' "$url"

  # ── 1. ตอบอะไรกลับมา ──────────────────────────────────────────────
  local code eff ctype raw
  raw="$TMP/raw.html"
  read -r code eff ctype < <(
    curl -s --compressed -A "$UA_BROWSER" -L --max-time 25 \
      -o "$raw" -w '%{http_code} %{url_effective} %{content_type}\n' "$url" 2>/dev/null
  ) || { c_bad "ยิงไม่ได้เลย"; return 1; }

  local bytes; bytes="$(wc -c < "$raw" | tr -d ' ')"
  c_ok "http=$code · $bytes bytes · ${ctype:-ไม่ระบุ}"

  if [ "$(norm "$eff")" != "$(norm "$url")" ]; then
    c_warn "redirect ไปที่อื่น — ปลายทางจริงคือ $eff"
    c_dim "ถ้าจะเก็บเข้าแคตตาล็อก ใช้ปลายทาง ไม่ใช่ต้นทาง"
  fi
  case "$ctype" in
    *charset*) : ;;
    text/html*) c_warn "content-type ไม่ระบุ charset — ภาษาไทยอาจเพี้ยนถ้าไฟล์ไม่ประกาศเอง" ;;
  esac

  # ── 2. กัน bot ไหม ────────────────────────────────────────────────
  local nocode
  nocode="$(curl -s --compressed -o /dev/null -w '%{http_code}' -L --max-time 20 "$url" 2>/dev/null)"
  if [ "$nocode" != "$code" ]; then
    c_warn "ผลต่างกันเมื่อไม่ใส่ User-Agent เบราว์เซอร์ ($nocode vs $code) — เว็บกรอง bot"
    c_dim "status ในแคตตาล็อกอาจขึ้น blocked ทั้งที่ลิงก์ใช้ได้ปกติ"
  fi

  # ── 3. เนื้อจริงมีแค่ไหน — จุดที่พลาดบ่อยที่สุด ────────────────────
  local text tlen ratio
  text="$(text_of "$raw")"; tlen="${#text}"
  ratio=$(( bytes > 0 ? tlen * 100 / bytes : 0 ))
  if [ "$tlen" -lt 400 ]; then
    c_bad "ข้อความที่อ่านได้มีแค่ $tlen ตัวอักษร ($ratio% ของไฟล์) — **เนื้อหาไม่ได้อยู่ใน HTML**"
    c_dim "แทบแน่นอนว่า render ฝั่ง client · สิ่งที่เห็นตอนนี้ไม่ใช่สิ่งที่คนเห็นในเบราว์เซอร์"
    c_dim "ห้ามสรุปว่าหน้านี้มีหรือไม่มีอะไร จนกว่าจะเปิดเบราว์เซอร์หรือหาแหล่งข้อมูลจริง"
  elif [ "$ratio" -lt 3 ]; then
    c_warn "ข้อความ $tlen ตัวอักษร แต่เป็นแค่ $ratio% ของไฟล์ — ส่วนใหญ่เป็นสคริปต์"
    c_dim "อาจมีเนื้อบางส่วนที่โหลดทีหลัง ตรวจซ้ำก่อนสรุปว่าครบ"
  else
    c_ok "ข้อความที่อ่านได้ $tlen ตัวอักษร ($ratio% ของไฟล์)"
  fi

  # ── 4. มีทางที่ดีกว่าไหม ──────────────────────────────────────────
  local found=""
  for alt in "${url%/}.md" "$base/llms.txt" "$base/skill.md" "$base/index.md"; do
    local ac asz
    read -r ac asz < <(curl -s --compressed -A "$UA_BROWSER" -o "$TMP/alt" \
        -w '%{http_code} %{size_download}\n' -L --max-time 15 "$alt" 2>/dev/null) || continue
    if [ "$ac" = "200" ] && [ "${asz:-0}" -gt 200 ]; then
      # ต้องต่างจากหน้าหลักจริง ไม่ใช่ SPA fallback ที่คืน index เดิม
      if ! cmp -s "$TMP/alt" "$raw"; then found="$found $alt"; fi
    fi
  done
  if [ -n "$found" ]; then
    c_ok "มีชั้นที่เครื่องอ่านได้ — ใช้ตัวนี้แทนการ scrape HTML:"
    for f in $found; do c_dim "$f"; done
  fi

  # ── 5. สรุปว่าเชื่อได้แค่ไหน ──────────────────────────────────────
  printf '  \033[1mสรุป\033[0m '
  if [ "$tlen" -lt 400 ] && [ -z "$found" ]; then
    printf '\033[31mเชื่อไม่ได้\033[0m — ยังไม่รู้ว่าหน้านี้มีอะไร ห้ามเขียนโน้ตจากรอบนี้\n'
    c_dim "ทำต่อ: เปิดเบราว์เซอร์ · เดาซับโดเมน docs./api./app. · grep JS chunk หา endpoint"
    c_dim "ถ้ายังไม่ได้ ให้ถามเจ้าของว่าเห็นอะไร แล้วบันทึกว่าข้อมูลมาจากการเห็นด้วยตา"
  elif [ -n "$found" ]; then
    printf '\033[32mเชื่อได้ถ้าใช้ชั้นที่เครื่องอ่านได้\033[0m — อย่าอ่านจาก HTML\n'
  elif [ "$ratio" -lt 3 ]; then
    printf '\033[33mเชื่อได้บางส่วน\033[0m — ตรวจซ้ำว่าที่ต้องการอยู่ในส่วนที่ได้มาจริง\n'
  else
    printf '\033[32mเชื่อได้\033[0m — เนื้อหาอยู่ใน HTML จริง\n'
  fi
}

[ $# -gt 0 ] || { sed -n '2,25p' "$0" | sed 's/^# \{0,1\}//'; exit 1; }
for u in "$@"; do probe_one "$u"; done

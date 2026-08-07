#!/usr/bin/env bash
# ตรวจ repo GitHub ในแคตตาล็อกด้วยสิ่งที่ HTTP code มองไม่เห็น
#
#   ./scripts/ghcheck.sh              # รายงาน
#   ./scripts/ghcheck.sh --self-test  # พิสูจน์ว่าจับของผิดได้จริง และไม่ได้จับมั่ว
#
# ทำไมต้องแยกจาก linkcheck:
# `linkcheck.sh` อ่านแค่ HTTP code — repo ที่ย้าย org แล้วจะได้ 301 → 200
# เหมือน repo ปกติทุกประการ และ repo ที่ถูก archive ก็ยังคืน 200 อยู่ดี
# ทั้งสองแบบคือ "status: ok แต่ของไม่เหมือนเดิม" ซึ่ง CLAUDE.md เตือนไว้แล้ว
# ว่าเจอมา 4 แบบ ตัวนี้จับได้ 2 แบบในนั้นแบบอัตโนมัติ
#
# **ทำไม 301 ถึงเป็นปัญหาทั้งที่ยังเข้าได้:** GitHub เลิก redirect ทันที
# ที่มีใครสร้าง repo ชื่อเดิมขึ้นมาที่ path เดิม ลิงก์ของเราจะชี้ไปของคนอื่น
# **โดยยังคืน 200 เหมือนเดิม** — เป็นการพังเงียบที่ตรวจย้อนหลังยากที่สุด
#
# ตัวนี้ไม่แก้ไฟล์ให้ **โดยตั้งใจ** — การย้าย org เป็นเรื่องที่คนต้องตัดสินใจ
# (เช่น anchor ย้ายไป otter-sec แต่ anchor-lang.com ยังลิงก์ path เดิมอยู่)
# และ CLAUDE.md ห้ามให้เครื่องเขียน YAML ทับนอกเหนือจากฟิลด์ status

set -uo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
need yq
need gh

STALE_DAYS="${STALE_DAYS:-365}"

fails=0
# ใช้ %b ไม่ใช่ %s เพราะข้อความมี \033[1m ฝังอยู่เพื่อเน้นชื่อ repo
# %s จะพิมพ์ escape ออกมาดิบๆ (เจอตอนรันจริงครั้งแรก)
ok()   { printf '  \033[32m✓\033[0m %b\n' "$1"; }
warn() { printf '  \033[33m!\033[0m %b\n' "$1"; }
bad()  { printf '  \033[31m✗\033[0m %b\n' "$1"; fails=$((fails+1)); }

# ดึง OWNER/REPO ที่ไม่ซ้ำออกจาก url ของแคตตาล็อก
# ตัด /orgs/... ทิ้งเพราะเป็นหน้ารายชื่อ ไม่ใช่ repo
repos_of() {
  yq -r '.resources[].url' "$DATA" \
    | grep -oE 'github\.com/[A-Za-z0-9._-]+/[A-Za-z0-9._-]+' \
    | sed 's#^github\.com/##' \
    | grep -v '^orgs/' \
    | sort -fu
}

# repo ที่คนตัดสินใจแล้วว่าเลิกใช้ — ต้องไม่เตือนซ้ำ
# **สัญญาณเตือนที่ไม่มีวันดับ คือสัญญาณที่คนเลิกอ่าน** ตัวตรวจที่แดงค้างจึงเท่ากับไม่มีตัวตรวจ
deprecated_repos() {
  yq -r '.resources[] | select(has("deprecated")) | .url' "$DATA" \
    | grep -oE 'github\.com/[A-Za-z0-9._-]+/[A-Za-z0-9._-]+' \
    | sed 's#^github\.com/##' | tr 'A-Z' 'a-z' | sort -u
}

run_checks() {
  local total=0 renamed=0 archived=0 stale=0 err=0 handled=0
  local cutoff dep
  dep="$(deprecated_repos)"
  # วันที่เก่ากว่านี้ = น่าสงสัยว่าไม่มีคนดูแล — BSD date กับ GNU date คนละ flag
  cutoff="$(date -u -v-"${STALE_DAYS}"d +%Y-%m-%d 2>/dev/null \
            || date -u -d "${STALE_DAYS} days ago" +%Y-%m-%d)"

  printf '\n\033[1mตรวจ repo GitHub — สิ่งที่ linkcheck มองไม่เห็น\033[0m\n'
  printf '\033[2mเทียบกับ %s · เก่ากว่า %s วันถือว่าน่าสงสัย\033[0m\n\n' "$cutoff" "$STALE_DAYS"

  while read -r r; do
    [ -z "$r" ] && continue
    total=$((total+1))
    local out
    # gh ที่ล้มต้องดัง ห้ามปล่อยให้คืนค่าว่างแล้วนับว่าผ่าน
    if ! out="$(gh api "repos/$r" \
        --jq '[.full_name, (.archived|tostring), .pushed_at[0:10], (.license.spdx_id // "none")] | @tsv' 2>&1)"; then
      bad "$r — ยิง GitHub API ไม่ได้: $(printf '%s' "$out" | head -1)"
      err=$((err+1)); continue
    fi
    local full arch pushed lic
    IFS=$'\t' read -r full arch pushed lic <<< "$out"
    if [ -z "$full" ]; then
      bad "$r — API ตอบแต่ไม่มี full_name (อย่าเดาว่าปกติ)"
      err=$((err+1)); continue
    fi

    # 1. ย้าย org หรือเปลี่ยนชื่อ — เทียบแบบไม่สนตัวพิมพ์
    if [ "$(printf '%s' "$full" | tr 'A-Z' 'a-z')" != "$(printf '%s' "$r" | tr 'A-Z' 'a-z')" ]; then
      bad "$r → \033[1m$full\033[0m  (301 อยู่ ยังเข้าได้ แต่ path เดิมถูกยึดคืนได้ทุกเมื่อ)"
      renamed=$((renamed+1))
    fi

    # 2. archived — ยังคืน 200 แต่ไม่มีใครรับ PR แล้ว
    local lower; lower="$(printf '%s' "$r" | tr 'A-Z' 'a-z')"
    if [ "$arch" = "true" ]; then
      if printf '%s\n' "$dep" | grep -qx "$lower"; then
        ok "$full — archived แต่ทำ deprecated ไว้แล้ว ไม่ต้องทำอะไรต่อ"
        handled=$((handled+1))
      else
        bad "$full — \033[1marchived\033[0m (แตะล่าสุด $pushed) อ่านได้แต่ส่ง PR ไม่ได้"
        archived=$((archived+1))
      fi
    elif [ "$pushed" \< "$cutoff" ]; then
      warn "$full — ไม่ถูกแตะตั้งแต่ $pushed"
      stale=$((stale+1))
    fi
  done < <(repos_of)

  printf '\n\033[1mสรุป\033[0m %s repo · ย้าย %s · archived ที่ยังไม่จัดการ %s · จัดการแล้ว %s · เงียบนาน %s · ยิงไม่ได้ %s\n' \
    "$total" "$renamed" "$archived" "$handled" "$stale" "$err"

  if [ "$total" -eq 0 ]; then
    bad "ไม่เจอ repo สักตัวใน $DATA — ตัวตรวจที่ไม่ได้ตรวจอะไรเลยต้องถือว่าล้ม"
  fi

  if [ "$fails" -eq 0 ]; then
    printf '\n\033[32mผ่าน\033[0m — ไม่มี repo ไหนย้ายที่หรือถูก archive\n'
    return 0
  fi
  printf '\n\033[31mต้องตัดสินใจ %s รายการ\033[0m — ตัวนี้ไม่แก้ให้เอง\n' "$fails"
  printf '\033[2mย้าย org: เปลี่ยน url ใน resources.yml เป็นชื่อใหม่ แล้วเขียนในโน้ตว่าเคยอยู่ที่ไหน\n'
  printf 'archived: ใช้ ./scripts/deprecate.sh ไม่ใช่ลบทิ้ง — ของยังอ่านได้ แค่ไม่ควรพึ่งพา\033[0m\n'
  return 1
}

# --self-test: ต้องจับของผิดได้ **และ** ต้องไม่จับของที่ถูก
# ข้อหลังสำคัญเท่ากัน — ตัวตรวจที่ตอบ "ผิด" ทุกครั้งก็ไร้ค่าพอกับตัวที่ตอบ "ผ่าน" ทุกครั้ง
if [ "${1:-}" = "--self-test" ]; then
  tmp="$(mktemp)"; trap 'rm -f "$tmp"' EXIT
  pass=0; total=0

  probe() { # ชื่อ, ควรล้มไหม(yes/no), url...
    local label="$1" expect="$2"; shift 2
    total=$((total+1))
    { echo "resources:"; for u in "$@"; do
        printf "  - { url: '%s', name: x, category: learning, source: community, tags: [], note: 'self-test fixture', status: ok, added: 2026-08-08 }\n" "$u"
      done; } > "$tmp"
    if DATA="$tmp" "$0" >/dev/null 2>&1; then got=no; else got=yes; fi
    if [ "$got" = "$expect" ]; then
      printf '  \033[32m✓\033[0m %s\n' "$label"; pass=$((pass+1))
    else
      printf '  \033[31m✗\033[0m %s (คาดว่าล้ม=%s แต่ได้=%s)\n' "$label" "$expect" "$got"
    fi
  }

  printf '\n\033[1mself-test — ต้องจับของผิด และต้องปล่อยของถูก\033[0m\n'
  probe "จับ repo ที่ย้าย org ได้ (coral-xyz/anchor → otter-sec)" yes \
        "https://github.com/coral-xyz/anchor"
  probe "จับ repo ที่ archived ได้ (developer-content)" yes \
        "https://github.com/solana-foundation/developer-content"
  probe "จับ repo ที่ไม่มีอยู่จริงได้ ไม่ใช่เงียบผ่าน" yes \
        "https://github.com/ozoneRatchapon/repo-that-should-never-exist-xyzzy"
  probe "ไม่จับ repo ที่ปกติดี (anza-xyz/agave)" no \
        "https://github.com/anza-xyz/agave"
  probe "ล้มเมื่อไม่มี repo ให้ตรวจเลย" yes \
        "https://example.com/not-github"

  # archived ที่ทำ deprecated ไว้แล้วต้องเงียบ — สัญญาณที่แดงค้างคือสัญญาณที่คนเลิกอ่าน
  total=$((total+1))
  { echo "resources:"
    printf "  - { url: 'https://github.com/solana-foundation/developer-content', name: x, category: official, source: foundation, tags: [], note: 'self-test fixture', deprecated: 'archived แล้ว', status: ok, added: 2026-08-08 }\n"
  } > "$tmp"
  if DATA="$tmp" "$0" >/dev/null 2>&1; then
    printf '  \033[32m✓\033[0m เงียบเมื่อ archived แต่ทำ deprecated ไว้แล้ว\n'; pass=$((pass+1))
  else
    printf '  \033[31m✗\033[0m ยังเตือนซ้ำทั้งที่ทำ deprecated ไว้แล้ว\n'
  fi

  printf '\nself-test: %s/%s\n' "$pass" "$total"
  [ "$pass" = "$total" ] || exit 1
  exit 0
fi

run_checks

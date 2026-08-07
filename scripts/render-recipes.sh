#!/usr/bin/env bash
# generate RECIPES.md จาก data/recipes.yml — อย่าแก้ RECIPES.md ด้วยมือ
#   ./scripts/render-recipes.sh

set -uo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
need yq

RECIPES="${RECIPES:-$REPO_ROOT/data/recipes.yml}"
OUT="${RECIPES_OUT:-$REPO_ROOT/RECIPES.md}"
SEP=$'\x1f'

# ลิงก์กลับไปหาเธรดของแต่ละสูตรบน GitHub — สร้างจาก id ไม่ใช่เลข issue
# เพราะเลข issue รู้ได้ต่อเมื่อสร้างแล้ว การ hardcode ไว้จะพังทันทีที่เพิ่มสูตรใหม่
GH="${GH_REPO_URL:-https://github.com/ozoneRatchapon/solana-learn}"
vote_url()   { printf '%s/issues?q=is%%3Aissue+label%%3Arecipe+in%%3Atitle+%s' "$GH" "$1"; }
report_url() { printf '%s/issues/new?template=recipe-report.yml&recipe-id=%s' "$GH" "$1"; }

n="$(yq -r '.recipes | length' "$RECIPES")"

# แผนที่ url(normalize) -> name สร้างครั้งเดียว แทนที่จะยิง yq ต่อ url
NAMEMAP="$(mktemp)"; trap 'rm -f "$NAMEMAP"' EXIT
yq -r ".resources[] | [.url, .name] | join(\"$SEP\")" "$DATA" \
| while IFS="$SEP" read -r u nm; do printf '%s%s%s\n' "$(norm "$u")" "$SEP" "$nm"; done > "$NAMEMAP"

{
  echo "# สูตร — โจทย์นี้หยิบอะไรมาต่อกัน"
  echo
  echo "> generate จาก [data/recipes.yml](data/recipes.yml) — **อย่าแก้ตรงนี้**"
  echo "> แก้ YAML แล้วรัน \`./scripts/render-recipes.sh\`"
  echo
  echo "**$n สูตร** · อัปเดต $(date +%F)"
  echo
  echo "[CATALOG.md](CATALOG.md) บอกว่ามีอะไรบ้าง ไฟล์นี้บอกว่า **โจทย์นี้ต้องหยิบอันไหนมาต่อกัน**"
  echo "ซึ่งเป็นความรู้ที่ปกติอยู่ในหัวคนที่เคยทำแล้วหายไปพร้อมกับคนนั้น"
  echo
  echo "**ส่วนที่ทำให้สูตรมีค่าคือ \`ข้อจำกัด\` ไม่ใช่ขั้นตอน** — ทางแก้ที่ดีที่สุดในสุญญากาศ"
  echo "มักใช้ไม่ได้กับของจริงเพราะติดข้อจำกัดที่ไม่มีใครเขียนไว้ สูตรที่ไม่ระบุข้อจำกัด"
  echo "ก็คือ tutorial ธรรมดา ซึ่งมีเยอะแล้วบนเน็ต"
  echo
  echo "## สารบัญ"
  echo
  yq -r ".recipes[] | [.id, .problem, .status] | join(\"$SEP\")" "$RECIPES" \
  | while IFS="$SEP" read -r id problem status; do
      case "$status" in
        proven) badge='✅' ;;
        *)      badge='🧪' ;;
      esac
      anchor="$(printf '%s' "$id" | tr '[:upper:]' '[:lower:]')"
      printf -- '- %s [%s](#%s)\n' "$badge" "$problem" "$anchor"
    done
  echo
  echo "✅ เคยทำจริงแล้ว · 🧪 ประกอบจากของที่ตรวจแล้ว แต่ยังไม่เคยรันทั้งชุด"
  echo
  echo "## ยังไม่มีสูตรไหนเป็น ✅ เลย — และคุณช่วยได้"
  echo
  echo "ทุกสูตรที่นี่ประกอบจากของที่ตรวจมาแล้วทีละชิ้น **แต่ยังไม่เคยมีใครรันทั้งชุดตั้งแต่ต้นจนจบ**"
  echo "เราจึงไม่เติม ✅ ให้ตัวเอง เพราะกฎในไฟล์ข้อมูลเขียนไว้ว่า *\"สูตรที่โกหกแย่กว่าไม่มีสูตร\"*"
  echo
  echo "- **[กด 👍 ในเธรดของสูตร]($GH/issues?q=is%3Aissue+label%3Arecipe)** ว่าอยากให้พิสูจน์อันไหนก่อน"
  echo "  — ไม่ต้องมีกระเป๋า ไม่ต้องเซ็นอะไร เวลามีจำกัด เสียงตรงนี้บอกว่าควรเริ่มที่ไหน"
  echo "- **ลองแล้วมารายงาน** ไม่ว่าผ่านหรือพัง — **รายงานว่าพังมีค่าเท่ากับรายงานว่าผ่าน**"
  echo "  เพราะจุดที่พังคือสิ่งที่ควรไปอยู่ในช่อง \`จุดที่จะพลาด\` ของสูตรนั้น"
  echo
  echo "---"
  echo

  yq -r '.recipes[].id' "$RECIPES" | while read -r id; do
    [ -z "$id" ] && continue
    problem="$(yq -r ".recipes[] | select(.id == \"$id\") | .problem" "$RECIPES")"
    status="$(yq -r ".recipes[] | select(.id == \"$id\") | .status" "$RECIPES")"
    approach="$(yq -r ".recipes[] | select(.id == \"$id\") | .approach" "$RECIPES")"
    watch="$(yq -r ".recipes[] | select(.id == \"$id\") | .watch_out" "$RECIPES")"
    checked="$(yq -r ".recipes[] | select(.id == \"$id\") | .checked" "$RECIPES")"
    case "$status" in
      proven) badge='✅ เคยทำจริงแล้ว' ;;
      *)      badge='🧪 ยังไม่เคยรันทั้งชุด' ;;
    esac

    printf '<a id="%s"></a>\n\n' "$id"
    printf '## %s\n\n' "$problem"
    printf '`%s` · ยืนยันล่าสุด %s\n\n' "$badge" "$checked"

    echo "**ข้อจำกัดที่ทำให้ทางแก้ทั่วไปใช้ไม่ได้**"
    echo
    yq -r ".recipes[] | select(.id == \"$id\") | .constraints[]" "$RECIPES" \
      | while read -r c; do [ -n "$c" ] && printf -- '- %s\n' "$c"; done
    echo
    echo "**หยิบอะไรมาใช้**"
    echo
    # เทียบชื่อด้วย URL ที่ normalize แล้ว — แคตตาล็อกเก็บ github.com/LiteSVM/litesvm (ตัวใหญ่)
    # ส่วนสูตรอาจเขียนตัวเล็ก การเทียบตรงๆ จะไม่เจอชื่อแล้วโชว์ URL ดิบแทน
    yq -r ".recipes[] | select(.id == \"$id\") | .uses[]" "$RECIPES" \
      | while read -r u; do
          [ -z "$u" ] && continue
          nm="$(grep -F "$(norm "$u")$SEP" "$NAMEMAP" | head -1 | cut -d"$SEP" -f2)"
          [ -z "$nm" ] && nm="$u"
          printf -- '- [%s](%s)\n' "$nm" "$u"
        done
    echo
    printf '**ประกอบยังไง** — %s\n\n' "$approach"
    printf '**จุดที่จะพลาด** — %s\n\n' "$watch"
    if [ "$status" = "proven" ]; then
      printf 'เคยทำแล้วเจอต่างจากนี้? [รายงานผล](%s) · [เธรดของสูตรนี้](%s)\n\n' \
        "$(report_url "$id")" "$(vote_url "$id")"
    else
      printf '🧪 **ยังไม่มีใครรันทั้งชุด** — [รายงานผลถ้าลองแล้ว](%s) · [กด 👍 ให้พิสูจน์อันนี้ก่อน](%s)\n\n' \
        "$(report_url "$id")" "$(vote_url "$id")"
    fi
    echo "---"
    echo
  done

  echo "ทุก URL ใน \`หยิบอะไรมาใช้\` ต้องมีอยู่จริงใน [data/resources.yml](data/resources.yml)"
  echo "— \`recipe-check.sh\` บังคับ ทำให้สูตรอ้างของที่ไม่เคยตรวจไม่ได้"
} > "$OUT"

echo "เขียน $OUT แล้ว ($n สูตร)"

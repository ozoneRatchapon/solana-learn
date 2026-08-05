#!/usr/bin/env bash
# generate web/index.html จาก YAML ทั้งหมด — อย่าแก้ web/index.html ด้วยมือ
#   ./scripts/render-web.sh
#
# หน้าเว็บเป็น "ชั้นนำเสนอ" ไม่ใช่ source of truth — ถ้าปล่อยให้เป็น จะกลับไปเจอปัญหาเดิม
# ที่ตัวเลขในเอกสารกับของจริงไม่ตรงกัน ทุกอย่างในหน้านี้จึงมาจาก YAML รอบเดียวตอน build
#
# แก้ template ที่ web/template.html แล้วรันตัวนี้ใหม่

set -uo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
need yq
command -v python3 >/dev/null 2>&1 || { echo "ต้องมี python3" >&2; exit 1; }

TPL="${TPL:-$REPO_ROOT/web/template.html}"
OUT="${WEB_OUT:-$REPO_ROOT/web/index.html}"
ENTITIES="$REPO_ROOT/data/entities.yml"
OPPS="$REPO_ROOT/data/opportunities.yml"
RECIPES="$REPO_ROOT/data/recipes.yml"
REJ="$REPO_ROOT/data/rejected.yml"

[ -f "$TPL" ] || { echo "ไม่มี template ที่ $TPL" >&2; exit 1; }

TMP="$(mktemp)"; trap 'rm -f "$TMP"' EXIT

# yq -o=json ต่อไฟล์ แล้วให้ python ประกอบ — เลี่ยงการ escape ด้วย sed ซึ่งพังกับข้อความไทย
{
  echo '{'
  printf '"resources": %s,\n'     "$(yq -o=json -I=0 '.resources' "$DATA")"
  printf '"categories": %s,\n'    "$(yq -o=json -I=0 '.categories' "$DATA")"
  printf '"entities": %s,\n'      "$(yq -o=json -I=0 '.entities' "$ENTITIES")"
  printf '"relations": %s,\n'     "$(yq -o=json -I=0 '.relations' "$ENTITIES")"
  printf '"opportunities": %s,\n' "$(yq -o=json -I=0 '.opportunities' "$OPPS")"
  printf '"recipes": %s,\n'       "$(yq -o=json -I=0 '.recipes' "$RECIPES")"
  printf '"rejected": %s\n'       "$(yq -o=json -I=0 '(.rejected // [])' "$REJ")"
  echo '}'
} > "$TMP"

python3 - "$TPL" "$TMP" "$OUT" "$(date +%F)" <<'PY'
import json, sys, io

tpl_path, data_path, out_path, today = sys.argv[1:5]

with io.open(data_path, encoding="utf-8") as f:
    data = json.load(f)

data["meta"] = {
    "generated": today,
    "categories": len({r["category"] for r in data["resources"]}),
}

marker = "/*__DATA__*/{}"
with io.open(tpl_path, encoding="utf-8") as f:
    tpl = f.read()
if marker not in tpl:
    sys.exit("template ไม่มีตัวยึด /*__DATA__*/{} — เติมกลับก่อน")

# </script> ในข้อมูลจะปิด block ก่อนเวลา ต้อง escape
blob = json.dumps(data, ensure_ascii=False, separators=(",", ":")).replace("</", "<\\/")
with io.open(out_path, "w", encoding="utf-8") as f:
    f.write(tpl.replace(marker, blob))

print(f"เขียน {out_path} แล้ว "
      f"({len(data['resources'])} resource · {len(data['entities'])} entity · "
      f"{len(data['opportunities'])} opportunity · {len(data['recipes'])} recipe · "
      f"{len(data['rejected'])} rejected)")
PY

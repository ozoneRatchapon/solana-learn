#!/usr/bin/env bash
# สร้างชั้นที่ agent อ่านได้ ลง web/dist/ — เรียกจาก deploy.sh
#
#   ./scripts/render-agent.sh
#
# ทำไมต้องมี:
# หน้าเว็บ 217 KB แต่ agent ที่ดึงไปได้ข้อความอ่านรู้เรื่องแค่ ~880 ตัวอักษร
# ที่เหลือติดอยู่ใน <script> ต้อง regex แกะเอง ซึ่งเปราะและไม่มีใครอยากทำ
#
# ในแคตตาล็อกของเราเองมี 3 รายการที่ถูกชมว่าทำเรื่องนี้ดี — solana.com (llms.txt +
# เติม .md ท้าย URL), pay.sh (index.md + llms.txt), solana-state (/api/report/markdown)
# เราเขียนโน้ตชมเขาไว้แล้วไม่ทำเอง ตัวนี้แก้ข้อนั้น
#
# ทุกไฟล์เป็น static — ไม่มีโค้ดฝั่งเซิร์ฟเวอร์ ไม่มีค่าใช้จ่ายเพิ่ม

set -uo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
need yq

DIST="${DIST:-$REPO_ROOT/web/dist}"
BASE="${SITE_BASE:-https://solana-learn.solana-thailand.workers.dev}"
TODAY="$(date +%F)"
mkdir -p "$DIST"

# ── เอกสารที่ generate ไว้แล้ว ใช้ซ้ำได้เลย ──────────────────────────
cp "$REPO_ROOT/CATALOG.md"      "$DIST/catalog.md"
cp "$REPO_ROOT/RADAR.md"        "$DIST/radar.md"
cp "$REPO_ROOT/RECIPES.md"      "$DIST/recipes.md"
cp "$REPO_ROOT/GRAPH.md"        "$DIST/graph.md"
cp "$REPO_ROOT/OPPORTUNITIES.md" "$DIST/opportunities.md"
cp "$REPO_ROOT/SKILL.md"        "$DIST/skill.md"

# ── ข้อมูลดิบ ────────────────────────────────────────────────────────
python3 - "$REPO_ROOT" "$DIST" "$TODAY" <<'PY'
import io, json, subprocess, sys
root, dist, today = sys.argv[1:4]

def y(path, expr):
    out = subprocess.run(["yq", "-o=json", "-I=0", expr, f"{root}/{path}"],
                         capture_output=True, text=True)
    if out.returncode != 0:
        sys.exit(f"yq ล้มที่ {path} :: {expr}\n{out.stderr}")
    return json.loads(out.stdout)

data = {
    "generated": today,
    "source": "https://github.com/ozoneRatchapon/solana-learn",
    "license": "MIT",
    "language": "th",
    "note": "โน้ตทุกรายการเป็นภาษาไทยโดยตั้งใจ — เป็นเนื้อหาสำหรับชุมชนไทย ไม่ใช่แค่ metadata",
    "categories":    y("data/resources.yml", ".categories"),
    "resources":     y("data/resources.yml", ".resources"),
    "entities":      y("data/entities.yml", ".entities"),
    "relations":     y("data/entities.yml", ".relations"),
    "opportunities": y("data/opportunities.yml", ".opportunities"),
    "recipes":       y("data/recipes.yml", ".recipes"),
    "rejected":      y("data/rejected.yml", "(.rejected // [])"),
}
with io.open(f"{dist}/data.json", "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, separators=(",", ":"))
print(f"  data.json      {len(data['resources'])} resource · {len(data['entities'])} entity")
PY

# ── สรุปสั้นสำหรับ agent ─────────────────────────────────────────────
{
  echo "# solana-learn — สรุปสถานะ"
  echo
  echo "> แคตตาล็อก resource Solana ภาษาไทย ทุกรายการมีเหตุผลกำกับว่าใช้ตอนไหน"
  echo "> สร้างเมื่อ $TODAY · ที่มา https://github.com/ozoneRatchapon/solana-learn · MIT"
  echo
  echo "**หมายเหตุเรื่องวันที่:** ไฟล์นี้ระบุ *วันปิด* ไม่ใช่ *เหลืออีกกี่วัน* โดยตั้งใจ"
  echo "เพราะตัวเลขวันที่เหลือจะค้างทันทีที่ generate เสร็จ ให้คำนวณจากวันที่ปัจจุบันเอง"
  echo
  echo "## ตัวเลข"
  echo
  printf -- '- resource %s รายการ · %s หมวด\n' \
    "$(yq -r '.resources | length' "$DATA")" \
    "$(yq -r '[.resources[].category] | unique | length' "$DATA")"
  printf -- '- หน่วยงานในระบบนิเวศ %s · ความสัมพันธ์ %s\n' \
    "$(yq -r '.entities | length' "$REPO_ROOT/data/entities.yml")" \
    "$(yq -r '.relations | length' "$REPO_ROOT/data/entities.yml")"
  printf -- '- โอกาสที่เปิดอยู่ %s · สูตร %s · รายการที่พิจารณาแล้วไม่เก็บ %s\n' \
    "$(yq -r '.opportunities | length' "$REPO_ROOT/data/opportunities.yml")" \
    "$(yq -r '.recipes | length' "$REPO_ROOT/data/recipes.yml")" \
    "$(yq -r '(.rejected // []) | length' "$REPO_ROOT/data/rejected.yml")"
  echo
  echo "## ของที่มีเดดไลน์"
  echo
  echo "| ปิด | อะไร | ได้อะไร | ลิงก์ |"
  echo "|---|---|---|---|"
  yq -r '.opportunities[] | select(.closes != "rolling")
         | [.closes, .name, .reward, .url] | join("")' "$REPO_ROOT/data/opportunities.yml" \
  | sort | while IFS=$'\x1f' read -r c n r u; do
      printf '| %s | %s | %s | %s |\n' "$c" "$n" "$r" "$u"
    done
  echo
  echo "## โอกาสที่ประเมินแล้วว่าลงมือได้"
  echo
  yq -r '.opportunities[] | select(.status == "ready")
         | "### " + .name + "\n\n" + .reward + "\n\n" + .verdict + "\n\n" + .url + "\n"' \
    "$REPO_ROOT/data/opportunities.yml"
  echo "## สูตร — โจทย์ที่มีทางแก้ประกอบไว้แล้ว"
  echo
  yq -r '.recipes[] | "- **" + .problem + "**  \n  ข้อจำกัด: " + (.constraints | join(" · "))' \
    "$REPO_ROOT/data/recipes.yml"
  echo
  echo "รายละเอียดเต็ม: $BASE/recipes.md"
} > "$DIST/report.md"
echo "  report.md      $(wc -c < "$DIST/report.md" | tr -d ' ') bytes"

# ── llms.txt ตามธรรมเนียมที่ solana.com กับ pay.sh ใช้ ───────────────
cat > "$DIST/llms.txt" <<EOF
# solana-learn

> แคตตาล็อก resource Solana ภาษาไทย ดูแลโดยชุมชน Solana Thailand
> ทุกรายการมีโน้ตอธิบายว่า **หยิบมาใช้ตอนไหน และต่างจากตัวข้างๆ ยังไง** ซึ่งเป็นเหตุผลที่โน้ตเป็นภาษาไทย
> เก็บทั้งของที่เอาและของที่พิจารณาแล้วไม่เอาพร้อมเหตุผล · ตรวจด้วยเครื่องทุก push · MIT

## เริ่มที่ไหน

- ต้องการภาพรวมสั้นที่สุด: $BASE/report.md
- ต้องการข้อมูลทั้งหมดเป็น JSON: $BASE/data.json
- ต้องการอ่านเป็นเอกสาร: ไฟล์ .md ด้านล่าง

## ไฟล์

- [skill.md]($BASE/skill.md): วิธีใช้ที่นี่สำหรับ agent + ความหมายของแต่ละ field ที่ตีความผิดง่าย — อ่านก่อนสรุปอะไร
- [report.md]($BASE/report.md): สรุปสถานะ ตัวเลข เดดไลน์ และโอกาสที่ลงมือได้ — เล็กที่สุด อ่านตัวนี้ก่อน
- [data.json]($BASE/data.json): ข้อมูลดิบทั้งหมดในไฟล์เดียว resource, entity, opportunity, recipe, rejected
- [catalog.md]($BASE/catalog.md): แคตตาล็อกเต็มจัดกลุ่มตามหมวด พร้อมโน้ตทุกรายการ
- [radar.md]($BASE/radar.md): โอกาสที่เปิดอยู่ แต่ละอันมี verdict ว่าทำได้จริงไหมและรู้ได้ยังไง
- [recipes.md]($BASE/recipes.md): โจทย์ที่เจอจริง + ข้อจำกัด → หยิบ resource ตัวไหนมาต่อกัน
- [graph.md]($BASE/graph.md): ใครทำ ใครดูแล ใครจ่ายเงิน ใครตรวจ — ไม่มีข้อมูลรายบุคคลโดยตั้งใจ
- [opportunities.md]($BASE/opportunities.md): เอกสารวิเคราะห์ว่าสร้างอะไรได้จากของที่มี

## สิ่งที่ควรรู้ก่อนใช้ข้อมูลนี้

- **วันที่**: ไฟล์ทุกตัวระบุวันปิดเป็นวันที่จริง ไม่ใช่ "เหลืออีกกี่วัน" ให้คำนวณจากวันปัจจุบันเอง
- **status ในแคตตาล็อก**: \`blocked\` แปลว่าเว็บกัน bot ตอน curl ลิงก์ยังใช้ได้ปกติ ไม่ใช่ลิงก์ตาย
- **deprecated เป็นคนละเรื่องกับ status**: status คือลิงก์ยังเปิดได้ไหม deprecated คือยังควรใช้ไหม
- **field \`note\`**: บอกว่าใช้ตอนไหน/ต่างจากตัวอื่นยังไง ไม่ใช่คำอธิบายว่ามันคืออะไร
- **field \`verdict\` ใน opportunity**: คำตัดสินว่าทำได้จริงไหม ไม่ใช่คำเชิญชวน — \`unproven\` แปลว่ายังตอบไม่ได้ และระบุไว้ว่าต้องพิสูจน์อะไรก่อน
- **rejected.yml**: ของที่ดูแล้วไม่เก็บ พร้อมเหตุผล ใช้กันการเสนอซ้ำ
- ตัวเลขทั้งหมดถูกตรวจโดย CI ว่าตรงกับข้อมูลจริง — เอกสารที่อ้างตัวเลขไม่ตรงจะทำให้ build ไม่ผ่าน

## ที่มา

- repo: https://github.com/ozoneRatchapon/solana-learn
- เสนอ resource หรือแจ้งของที่เปลี่ยนไป: https://github.com/ozoneRatchapon/solana-learn/issues/new/choose
EOF
echo "  llms.txt       $(wc -c < "$DIST/llms.txt" | tr -d ' ') bytes"
echo "  เอกสาร .md     catalog / radar / recipes / graph / opportunities"

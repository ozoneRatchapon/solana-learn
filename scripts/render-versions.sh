#!/usr/bin/env bash
# generate VERSIONS.md — ตารางความเข้ากันได้ที่ดึงของจริงทุกครั้ง ไม่ใช่ตัวเลขที่พิมพ์ทิ้งไว้
#   ./scripts/render-versions.sh
#
# นี่คือ OPPORTUNITIES 1.2 ฉบับ re-scope
#
# **ไม่ทำซ้ำสิ่งที่ Foundation ทำแล้ว** — compatibility-matrix.md ของเขาครอบ
# Anchor × Solana CLI × Platform Tools × GLIBC ไว้ครบและละเอียดกว่าที่เราจะทำได้
# ไฟล์นี้ทำเฉพาะสองแกนที่ของเขาไม่มี:
#   1. Anchor × client library ฝั่ง TypeScript (web3.js v1 / Kit / v3)
#   2. ยืนยันบน macOS — ของเขาอิง Debian
#
# ตัวเลข npm ดึงสดทุกครั้งที่รัน ตัวเลข toolchain อ่านจากเครื่องที่รัน
# จึงไม่มีทางค้างแบบเงียบๆ ซึ่งเป็นปัญหาของตารางเวอร์ชันทุกอันบนเน็ต

set -uo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

OUT="${VERSIONS_OUT:-$REPO_ROOT/VERSIONS.md}"
TODAY="$(date +%F)"

npmv() { npm view "$1" version 2>/dev/null || echo "?"; }
npmdep() {  # $1=pkg  $2=dep
  npm view "$1" dependencies --json 2>/dev/null \
    | python3 -c "import json,sys;d=json.load(sys.stdin);print(d.get('$2','—'))" 2>/dev/null || echo "?"
}
local_v() { command -v "$1" >/dev/null 2>&1 && ($2 2>/dev/null | head -1) || echo "ไม่ได้ติดตั้ง"; }

echo "▸ ดึงข้อมูล npm สด..." >&2
ANCHOR_NEW="$(npmv @anchor-lang/core)"
ANCHOR_OLD="$(npmv @coral-xyz/anchor)"
W3_LATEST="$(npmv @solana/web3.js)"
KIT="$(npmv @solana/kit)"
CODAMA="$(npmv codama)"
SPL="$(npmv @solana/spl-token)"
W3_RC="$(npm view @solana/web3.js dist-tags --json 2>/dev/null | python3 -c "import json,sys;print(json.load(sys.stdin).get('rc','—'))" 2>/dev/null || echo '?')"
NEW_DEP_W3="$(npmdep @anchor-lang/core @solana/web3.js)"
NEW_DEP_KIT="$(npmdep @anchor-lang/core @solana/kit)"
OLD_DEP_W3="$(npmdep @coral-xyz/anchor @solana/web3.js)"

{
  echo "# อันไหนใช้ด้วยกันได้ปี 2026"
  echo
  echo "> generate จาก [scripts/render-versions.sh](scripts/render-versions.sh) — **อย่าแก้ตรงนี้**"
  echo "> ตัวเลข npm ดึงสดทุกครั้งที่รัน ตัวเลข toolchain อ่านจากเครื่องที่รัน"
  echo
  echo "ตรวจเมื่อ **$TODAY** · เครื่อง **$(uname -s) $(uname -r)** ($(uname -m))"
  echo
  echo "**ไม่ทำซ้ำของ Foundation** — [compatibility-matrix.md](https://github.com/solana-foundation/solana-dev-skill/blob/main/skills/solana-dev/references/compatibility-matrix.md)"
  echo "ครอบ Anchor × Solana CLI × Platform Tools × GLIBC ไว้ครบและละเอียดกว่า **ใช้ของเขาเป็นหลักสำหรับแกนพวกนั้น**"
  echo "หน้านี้ทำเฉพาะสองแกนที่ของเขาไม่มี: **client library ฝั่ง TypeScript** และ **การยืนยันบน macOS**"
  echo
  echo "---"
  echo
  echo "## ข้อที่คนเข้าใจผิดมากที่สุด"
  echo
  echo "> **Anchor 1.x ไม่ได้ใช้ Kit** — client TypeScript ของ Anchor ยังพึ่ง web3.js v1 อยู่"
  echo
  echo "\`@anchor-lang/core@$ANCHOR_NEW\` ประกาศ dependency ว่า:"
  echo
  echo "| dependency | ค่าที่ประกาศจริง |"
  echo "|---|---|"
  echo "| \`@solana/web3.js\` | \`$NEW_DEP_W3\` |"
  echo "| \`@solana/kit\` | \`$NEW_DEP_KIT\` |"
  echo
  echo "แปลว่า **ถ้าใช้ client ของ Anchor อยู่ ก็อยู่บน web3.js v1 ไม่ว่าจะอัป Anchor ไปเวอร์ชันไหน**"
  echo "อยากอยู่บน Kit จริงต้องเลิกใช้ client ของ Anchor แล้ว generate client เองด้วย Codama"
  echo
  echo "นี่คือเหตุผลที่ tutorial จำนวนมาก \"ดูเก่า\" แต่ยังรันผ่าน และที่ \"อัป Anchor เป็น 1.0 แล้ว\""
  echo "ไม่ได้แปลว่าโค้ดทันสมัยแล้ว"
  echo
  echo "## ของจริงบน npm วันนี้"
  echo
  echo "| แพ็กเกจ | เวอร์ชัน | หมายเหตุ |"
  echo "|---|---|---|"
  echo "| \`@anchor-lang/core\` | **$ANCHOR_NEW** | ชื่อใหม่ของ client Anchor ตั้งแต่ 1.0 |"
  echo "| \`@coral-xyz/anchor\` | $ANCHOR_OLD | ชื่อเดิม หยุดที่ 0.32.x — เจอในโค้ดเก่าเกือบทั้งหมด |"
  echo "| \`@solana/web3.js\` | **$W3_LATEST** | tag \`latest\` ยังเป็น v1 · v3 อยู่ที่ \`rc\` = \`$W3_RC\` **ยังไม่ GA** |"
  echo "| \`@solana/kit\` | **$KIT** | เลขเวอร์ชันไปไกลกว่าที่หลายคนจำว่า \"web3.js 2.0\" มาก |"
  echo "| \`codama\` | $CODAMA | ทางเดียวที่จะได้ client ที่เป็น Kit จริง |"
  echo "| \`@solana/spl-token\` | $SPL | |"
  echo
  echo "## เลือกยังไง"
  echo
  echo "| ถ้าคุณ… | ใช้ | อยู่บน |"
  echo "|---|---|---|"
  echo "| เขียนโปรแกรมด้วย Anchor แล้วเรียกจาก TS | \`@anchor-lang/core\` | **web3.js v1** |"
  echo "| อยากได้ bundle เล็ก tree-shakable จริง | Codama generate client | **Kit $KIT** |"
  echo "| ดูแลโค้ดเก่า | \`@coral-xyz/anchor\` $ANCHOR_OLD | web3.js v1 |"
  echo "| อยากรอ v3 | ยังรอไม่ได้ | \`rc\` เท่านั้น |"
  echo
  echo "## ยืนยันบนเครื่องนี้"
  echo
  echo "ของ Foundation อิง Debian หน้านี้ยืนยันบน macOS"
  echo
  echo "| เครื่องมือ | เวอร์ชันที่ตรวจได้ |"
  echo "|---|---|"
  printf '| `anchor` | %s |\n' "$(local_v anchor 'anchor --version')"
  printf '| `solana` | %s |\n' "$(local_v solana 'solana --version')"
  printf '| `rustc` | %s |\n' "$(local_v rustc 'rustc --version')"
  printf '| `cargo` | %s |\n' "$(local_v cargo 'cargo --version')"
  printf '| `node` | %s |\n' "$(local_v node 'node --version')"
  printf '| `npm` | %s |\n' "$(local_v npm 'npm --version')"
  printf '| `avm` | %s |\n' "$(local_v avm 'avm --version')"
  echo
  echo "\`avm\` ทำให้สลับสาย Anchor ได้โดยไม่ต้องถอนของเดิม — **อย่าอัป \`anchor-cli\` ทับ**"
  echo "เพราะจะทดสอบสายเก่าไม่ได้อีก ซึ่งเป็นสิ่งที่ต้องทำเวลาตรวจว่า tutorial ยังใช้ได้ไหม"
  echo
  echo "## เช็คโค้ดที่มีอยู่ใน 3 คำสั่ง"
  echo
  echo '```bash'
  echo '# อยู่บน Anchor ยุคไหน'
  echo 'grep -r "@coral-xyz/anchor" --include=package.json .   # เจอ = ก่อน 1.0'
  echo 'grep -r "@anchor-lang/core" --include=package.json .   # เจอ = 1.0 ขึ้นไป'
  echo
  echo '# อยู่บน client ตัวไหน'
  echo 'grep -rE "new Connection|new PublicKey" --include=*.ts .  # เจอ = web3.js v1'
  echo 'grep -r "@solana/kit" --include=package.json .            # เจอ = Kit'
  echo
  echo '# เทสด้วยอะไร'
  echo 'grep -r "solana-test-validator" .   # เจอ = เขียนก่อนยุค LiteSVM/Surfpool'
  echo '```'
  echo
  echo "---"
  echo
  echo "## สิ่งที่หน้านี้ยังไม่ได้ยืนยัน"
  echo
  echo "เขียนไว้เพื่อไม่ให้เข้าใจว่าตรวจครบแล้ว:"
  echo
  echo "- **ยังไม่ได้ build จริง** ตัวเลขทั้งหมดมาจาก metadata ของ npm กับคำสั่ง \`--version\`"
  echo "  ไม่ได้แปลว่าเอาไปประกอบกันแล้วคอมไพล์ผ่าน"
  echo "- **ยังไม่ได้ทดสอบสาย Anchor เก่ากับ AVM** ว่าสายไหนคู่กับ Solana CLI ตัวไหนได้บ้าง"
  echo "- **ไม่ครอบฝั่ง Rust client** — \`solana-sdk\`, \`solana-client\` ยังไม่ได้ตรวจ"
  echo
  echo "รันซ้ำเมื่อไหร่ก็ได้ด้วย \`./scripts/render-versions.sh\` ตัวเลขจะอัปเดตเอง"
} > "$OUT"

echo "เขียน $OUT แล้ว (ตรวจ $TODAY)"

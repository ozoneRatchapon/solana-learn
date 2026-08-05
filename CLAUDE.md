# CLAUDE.md

บริบทสำหรับ Claude Code ที่ทำงานใน repo นี้

## repo นี้คืออะไร

คลังรวม resource Solana ไว้ที่เดียว + เอกสารวิเคราะห์โอกาส
**ไม่ใช่** คอร์ส ไม่ใช่ tutorial ไม่ใช่ workspace โค้ด — อย่าเผลอสร้าง Anchor workspace หรือ interactive learning ในนี้

เจ้าของ: [@ozoneRatchapon](https://github.com/ozoneRatchapon) — King Crab (Community Operator) ของ Solana Thailand Genesis
งานที่นี่จึงมองผ่านเลนส์ DevRel/ชุมชนไทยเสมอ ไม่ใช่มุมนักพัฒนาเดี่ยว

## กฎเหล็ก

**`data/resources.yml` คือ source of truth เดียว**
`CATALOG.md` เป็นไฟล์ generate — **ห้ามแก้ด้วยมือเด็ดขาด** แก้ YAML แล้วรัน `./scripts/render.sh`
ถ้าเห็นตัวเองกำลังจะ Edit `CATALOG.md` แปลว่าเดินผิดทางแล้ว

## workflow ที่ใช้บ่อยที่สุด

เจ้าของจะโยน URL มาให้เช็คว่ามีหรือยังเรื่อยๆ ลำดับคือ:

```bash
./scripts/check.sh <url> [url...]      # 1. ซ้ำไหม (pbpaste | ./scripts/check.sh ก็ได้)
./scripts/add.sh -u <url> -n "<ชื่อ>" -c <หมวด> -s <source> -t "tag1,tag2" -m "<โน้ต>"
./scripts/render.sh                     # 3. อัปเดต CATALOG.md

# แก้ note ของ entry ที่มีอยู่แล้ว (ทีละอันหรือทีละชุด)
./scripts/setnote.sh <url> "<note>"
./scripts/setnote.sh --from-tsv <file>  # url \t note ต่อบรรทัด
```

`check.sh` ตอบ 4 แบบ — `[มีแล้ว]` / `[เคยไม่เอา]` (เคยปฏิเสธ บอกเหตุผลเดิม) / `[ใกล้เคียง]` (โดเมนเดียวกันคนละหน้า ให้คนตัดสิน) / `[ใหม่]`

**เจอลิงก์แล้วตัดสินใจไม่เก็บ ต้องบันทึกด้วย** ไม่ใช่ปล่อยผ่านเฉยๆ:

```bash
./scripts/reject.sh -u <url> -r "<เหตุผล>" [-b <url ที่ดีกว่า>]
```

ไม่งั้นเดือนหน้าเจอลิงก์เดิมก็ต้องไล่ตรวจใหม่ตั้งแต่ต้น — การตัดสินใจว่า "ไม่เอา"
มีต้นทุนเท่ากับ "เอา" ต้องเก็บทั้งสองฝั่ง

หลายอันพร้อมกันได้ ไม่ต้องถามทีละตัว: เช็คทั้งชุด → เพิ่มเฉพาะที่ใหม่ → render → commit รวดเดียว

### เช็คลิงก์เน่า

```bash
./scripts/linkcheck.sh          # รายงาน
./scripts/linkcheck.sh --fix    # เขียน status กลับเข้า YAML (ใช้ awk แก้เฉพาะบรรทัด status: comment ไม่หาย)
```

`blocked` = 401/403/429 เว็บกัน bot ตอน curl **ลิงก์ยังใช้ได้ปกติ** อย่าไปลบทิ้ง (Solscan, Dune, DefiLlama, Birdeye, Jito อยู่กลุ่มนี้)

## ตรวจก่อน commit

```bash
./scripts/audit.sh
```

ตรวจ 4 ชั้น: ข้อมูลครบ · สัดส่วน note (เพดานล่าง `NOTE_FLOOR` — **ขยับขึ้นได้อย่างเดียว**) ·
ตัวเลขใน README ตรงกับ YAML · CATALOG.md เป็นผลของ render ล่าสุด — CI รันตัวนี้ทุก push

**README กับ OPPORTUNITIES ถูกตรวจคนละแบบโดยตั้งใจ** — README พูดถึงปัจจุบัน ตัวเลขต้องตรงเป๊ะ
ส่วน OPPORTUNITIES เป็นการวิเคราะห์ ณ วันหนึ่ง ตัวเลขแช่ไว้ การไล่แก้ `127`→`180` คือการอ้างว่า
วิเคราะห์บนข้อมูลที่ไม่เคยวิเคราะห์ audit จะเตือนให้กลับไปอ่านข้อสรุปใหม่แทน

## กับดักที่เคยเจอมาแล้ว

- **`IFS=$'\t' read` ยุบ field ว่าง** เพราะ tab เป็น IFS whitespace → `render.sh` เลยใช้ `\x1f` (ตัวแปร `$SEP`) ถ้าจะเขียน script ใหม่ที่อ่าน field ซึ่งอาจว่าง ให้ใช้ `$SEP` อย่าใช้ tab
- **`set -e` + `cmd | while ...; do [ cond ] && ...; done` ใน `$(...)`** — รอบสุดท้ายที่เงื่อนไขเป็นเท็จทำให้ทั้ง pipeline คืน exit 1 แล้ว script ตายเงียบๆ ใช้ `if/fi` แทน `&&`
- **ไม่มี PyYAML ในเครื่อง** ใช้ `yq` (mikefarah v4) กับ `jq` เท่านั้น
- **`add.sh` เคยทำ `resources.yml` พังทั้งไฟล์** เพราะเขียน note ลง double-quoted scalar โดยไม่ escape — พอ note มี `"` (เช่นตัวอย่างคำสั่ง jq) YAML ก็เจ๊ง แก้แล้วโดยเปลี่ยนไปใช้ single-quoted + `yesc()` ถ้าจะเขียน script ที่ append YAML เพิ่ม ใช้ท่าเดียวกัน (single-quote ต้อง escape แค่ `'` → `''`)
- ทดสอบ script ที่เขียนลง YAML ได้โดยไม่แตะไฟล์จริง: `DATA=/tmp/copy.yml ./scripts/add.sh ...` (`REJECTED=` ก็ override ได้เหมือนกัน)
- **`yq -i` เขียนไฟล์ใหม่ทั้งไฟล์ → บรรทัดว่างระหว่าง entry หายหมด** (ลองแล้ว 1599 → 1427 บรรทัด) comment หัวไฟล์รอด แต่ไฟล์อ่านยากขึ้นมาก และ `resources.yml` เป็นไฟล์ที่คนแก้ด้วยมือด้วย **อย่าใช้ `yq -i` กับไฟล์ข้อมูล** ให้ใช้ awk แก้เฉพาะบรรทัดแบบที่ `linkcheck.sh --fix` และ `setnote.sh` ทำ
- **`sed -i` ต่างกันระหว่าง BSD (macOS) กับ GNU** — macOS ต้องมี argument ต่อท้าย `-i` `reject.sh` เลยใช้ `awk` + `mv` แทน เขียน script ใหม่ที่แก้ไฟล์ในที่ ให้ใช้ท่าเดียวกัน
- **เว็บที่ render ฝั่ง client จะได้หน้าเปล่า** ไม่ใช่ลิงก์เสีย — curl ได้ HTTP 200 แต่ไม่มีเนื้อ (`governance.solana.com` เป็นเคสตัวอย่าง) อย่าเขียนโน้ตจากหน้าเปล่าเด็ดขาด ทางออกคืออ่านต้นทางจริง:

  ```bash
  # เนื้อ proposal อยู่บนเชน ไม่ได้อยู่ใน HTML — owner: govYkyQ3ePtGULAtY6V75qjWE8UH4vCUVQ1W4HdCAZU
  curl -s https://api.mainnet-beta.solana.com -X POST -H 'Content-Type: application/json' \
    -d '{"jsonrpc":"2.0","id":1,"method":"getAccountInfo","params":["<PROPOSAL_ID>",{"encoding":"base64"}]}' \
    | jq -r '.result.value.data[0]' | base64 -d | strings -n 4 | head
  ```

  ได้ชื่อ SGP + ลิงก์ markdown ที่ pin commit SHA ไว้ แล้วค่อย curl ตัว markdown มาอ่าน
  ท่าทั่วไปเวลาเจอ SPA: `grep -o '/_next/static/chunks/[a-f0-9]*\.js' page.html` → โหลด chunk มา grep หา endpoint ที่มันยิง

## ภาษา — ใช้คนละภาษาตามชั้นของงาน

| ชั้น | ภาษา |
|---|---|
| commit message, branch, PR, โค้ดคอมเมนต์, ชื่อไฟล์ | **อังกฤษ** |
| กระบวนการคิด / บันทึกระหว่างทำงาน | **อังกฤษ** |
| `note:` ใน `resources.yml`, `CATALOG.md`, `OPPORTUNITIES.md`, `README.md` | **ไทย** |
| สรุปตอบเจ้าของ | **ไทย** |

เหตุผล: ของที่เป็นชั้น engineering ให้คนนอก/เครื่องมืออ่านรู้เรื่อง ส่วนของที่เป็นเนื้อหาสำหรับชุมชนไทยคือตัวผลิตภัณฑ์ ต้องเป็นไทย

## สไตล์เนื้อหา

- เขียนภาษาไทย ศัพท์เทคนิคคงภาษาอังกฤษ (PDA, CPI, rent, tree-shakable)
- ทุก entry ต้องมีเหตุผลว่าทำไมถึงเก็บ — โน้ตแบบ "ดีมาก" ไม่มีค่า เขียนว่าใช้ตอนไหน/ต่างจากตัวอื่นยังไง
  `add.sh` บังคับ `-m` แล้ว (ขั้นต่ำ 20 ตัวอักษร) และ `audit.sh` มี `NOTE_FLOOR` เป็นเพดานล่าง **ที่ขยับขึ้นได้อย่างเดียว**
  เกณฑ์ตัดสินว่าโน้ตใช้ได้ไหม: **มันบอกอะไรที่การค้น Google 10 วินาทีไม่บอกหรือเปล่า** ถ้าไม่ ก็ยังไม่ใช่โน้ต
- **หน้า landing ของโปรโตคอลมักไม่มีข้อมูลสำหรับนักพัฒนาเลย** — `jup.ag` / `raydium.io` / `orca.so` เป็นหน้าการตลาด
  ยิงอ่านแล้วแทบไม่ได้อะไร ของจริงอยู่ที่ `developers.jup.ag` / `docs.raydium.io` / `docs.orca.so` ซึ่งเป็นคนละโดเมน
  เวลาเขียนโน้ตให้ entry สาย DeFi/infra **ต้องไปอ่าน docs ไม่ใช่หน้าแรก**
- อย่าเติม resource จากความจำ **ต้องยิงเช็คลิงก์จริงก่อนเสมอ** — ตอนสร้าง repo นี้ curated list ของ Foundation เองยังมี 404 อยู่ 2 ตัว
- `source: foundation`/`anza` เชื่อถือได้มากกว่า `community`/`vendor` เวลาข้อมูลขัดกันให้ยึดฝั่งแรก

## ข้อเท็จจริงเรื่องเวอร์ชัน (2026-08-04)

toolchain ในเครื่องเจ้าของ: `anchor-cli 1.0.2` · `solana-cli 3.1.10 (Agave)` · `rustc 1.97.1` · `node v24.16.0`

- Anchor **1.0** แล้ว — tutorial บนเน็ตเกือบทั้งหมดยังเป็น 0.3x
- `@solana/web3.js` v1 อยู่ maintenance → ใช้ `@solana/kit` หรือ web3.js **v3**
- เลี่ยง `solana-test-validator` ใช้ LiteSVM / Mollusk / Surfpool

ก่อนแนะนำอะไรที่อิงเวอร์ชัน ให้เช็คของจริงในเครื่องก่อน อย่าเชื่อความจำ

## ทิศทางงาน

[OPPORTUNITIES.md](OPPORTUNITIES.md) จัดโอกาสเป็น 3 tier — Tier 3 คือ **สมมติฐานที่ยังไม่ได้พิสูจน์** ระบุไว้ชัดแล้วว่าต้องตรวจอะไรก่อน อย่าเสนอให้ลงแรงหนักตรงนั้นเหมือนมันเป็นแผนที่ตัดสินใจแล้ว

ชิ้นที่คุ้มที่สุดตอนนี้คือ **1.2 ตารางความเข้ากันได้ของเวอร์ชัน** (Anchor × web3.js/Kit × ตัวอย่างที่รันผ่านจริง)

## repo ข้างเคียง

`../solana-thailand-genesis` (ชุมชน/quest/treasury) · `../solana-thailand-devrel-helper` (SOP อีเวนต์ — แนวคิด one-YAML-source-of-truth มาจากที่นั่น) · `../solana-starter`, `../spl_nft_q2_26` (โค้ดฝึกมือเดิม ยังเป็น web3.js v1)

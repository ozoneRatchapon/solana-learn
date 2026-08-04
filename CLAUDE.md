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
```

`check.sh` ตอบ 3 แบบ — `[มีแล้ว]` / `[ใกล้เคียง]` (โดเมนเดียวกันคนละหน้า ให้คนตัดสิน) / `[ใหม่]`

หลายอันพร้อมกันได้ ไม่ต้องถามทีละตัว: เช็คทั้งชุด → เพิ่มเฉพาะที่ใหม่ → render → commit รวดเดียว

### เช็คลิงก์เน่า

```bash
./scripts/linkcheck.sh          # รายงาน
./scripts/linkcheck.sh --fix    # เขียน status กลับเข้า YAML (ใช้ awk แก้เฉพาะบรรทัด status: comment ไม่หาย)
```

`blocked` = 401/403/429 เว็บกัน bot ตอน curl **ลิงก์ยังใช้ได้ปกติ** อย่าไปลบทิ้ง (Solscan, Dune, DefiLlama, Birdeye, Jito อยู่กลุ่มนี้)

## กับดักที่เคยเจอมาแล้ว

- **`IFS=$'\t' read` ยุบ field ว่าง** เพราะ tab เป็น IFS whitespace → `render.sh` เลยใช้ `\x1f` (ตัวแปร `$SEP`) ถ้าจะเขียน script ใหม่ที่อ่าน field ซึ่งอาจว่าง ให้ใช้ `$SEP` อย่าใช้ tab
- **`set -e` + `cmd | while ...; do [ cond ] && ...; done` ใน `$(...)`** — รอบสุดท้ายที่เงื่อนไขเป็นเท็จทำให้ทั้ง pipeline คืน exit 1 แล้ว script ตายเงียบๆ ใช้ `if/fi` แทน `&&`
- **ไม่มี PyYAML ในเครื่อง** ใช้ `yq` (mikefarah v4) กับ `jq` เท่านั้น

## สไตล์เนื้อหา

- เขียนภาษาไทย ศัพท์เทคนิคคงภาษาอังกฤษ (PDA, CPI, rent, tree-shakable)
- ทุก entry ต้องมีเหตุผลว่าทำไมถึงเก็บ — โน้ตแบบ "ดีมาก" ไม่มีค่า เขียนว่าใช้ตอนไหน/ต่างจากตัวอื่นยังไง
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

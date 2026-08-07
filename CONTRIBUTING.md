# ร่วมพัฒนา

<!-- english -->
**In English:** the fastest way to help is to open an issue suggesting a resource —
you do not need to run anything locally. If you want to send a PR, the one rule
that matters is that `data/resources.yml` is the single source of truth and every
other file is generated from it. Never edit `CATALOG.md` or `GRAPH.md` by hand.
Run `./scripts/audit.sh` before pushing; CI runs it too. Notes are written in Thai
on purpose (see below) but issues and PR descriptions in English are fine.
<!-- /english -->

---

## ช่วยได้เร็วที่สุด: เปิด issue

ไม่ต้องติดตั้งอะไรเลย — [เสนอ resource](../../issues/new?template=suggest-resource.yml)
หรือ [แจ้งของที่เปลี่ยนไป](../../issues/new?template=broken-or-moved.yml)

ฟอร์มถามตรงกับสิ่งที่ต้องใส่ในแคตตาล็อกพอดี เจ้าของ repo เอาไปรัน `add.sh` ต่อได้เลย

## ช่วยได้มากที่สุด: บอกว่าสูตรใช้ได้จริงไหม

[RECIPES.md](RECIPES.md) มี 6 สูตร และ **ยังไม่มีอันไหนเป็น `proven` เลยสักอัน** —
ทุกอันประกอบจากของที่ตรวจมาแล้วทีละชิ้น แต่ไม่มีใครรันทั้งชุดตั้งแต่ต้นจนจบ

[รายงานผลการใช้สูตร](../../issues/new?template=recipe-report.yml) คือทางเดียวที่มันจะเปลี่ยนเป็น ✅
**และรายงานว่าพังมีค่าเท่ากับรายงานว่าผ่าน** เพราะจุดที่พังคือสิ่งที่ควรไปอยู่ในช่อง `จุดที่จะพลาด`

ยังไม่ได้ลอง แต่อยากบอกว่าอันไหนน่าสนใจก่อน — [กด 👍 ในเธรดของสูตร](../../issues?q=is%3Aissue+label%3Arecipe)
ก็ช่วยได้ ไม่ต้องมีกระเป๋า ไม่ต้องเซ็นอะไร

## ถ้าจะส่ง PR — กฎเดียวที่สำคัญที่สุด

**`data/resources.yml` คือ source of truth เดียว** ไฟล์ .md ทุกไฟล์ generate จากมัน

```
✗ แก้ CATALOG.md      ← ถูกเขียนทับทันทีที่มีคนรัน render
✗ แก้ GRAPH.md        ← เหมือนกัน
✓ แก้ data/resources.yml แล้วรัน ./scripts/render.sh
```

## ขั้นตอน

```bash
# 1) มีในแคตตาล็อกหรือยัง (ตอบ 4 แบบ รวม "เคยพิจารณาแล้วไม่เอา")
./scripts/check.sh <url>

# 2) เพิ่ม — -m บังคับ ไม่มีโน้ตเพิ่มไม่ได้
./scripts/add.sh -u <url> -n "<ชื่อ>" -c <หมวด> -s <source> -t "tag1,tag2" -m "<โน้ต>"

# 3) generate ใหม่
./scripts/render.sh

# 4) ตรวจก่อน push — CI รันตัวเดียวกัน
./scripts/audit.sh
```

ต้องมี [`yq` (mikefarah v4)](https://github.com/mikefarah/yq) กับ `jq` เท่านั้น

## โน้ตคือหัวใจ ไม่ใช่ของแถม

entry ที่มีแค่ชื่อกับลิงก์ไม่ได้ให้อะไรเกินกว่าการค้น Google 10 วินาที
ซึ่งเป็นสิ่งเดียวที่ทำให้แคตตาล็อกนี้ต่างจาก awesome-list ทั่วไป — `add.sh` เลยบังคับ `-m`

**เขียนว่าหยิบมาใช้ตอนไหน / ต่างจากตัวข้างๆ ยังไง** ไม่ใช่ว่ามันคืออะไร

```
✗ "เอกสาร RPC ของ Solana"
✓ "...เรื่องระดับ commitment เป็นจุดที่คนพลาดบ่อยสุดเวลาทำระบบจ่ายเงิน
   เพราะเลือกผิดแล้วนับว่าเงินเข้าทั้งที่ยังไม่ final"
```

**ห้ามเขียนโน้ตจากความจำ ต้องเปิดหน้าจริงก่อนเสมอ** — รอบล่าสุดที่ไล่เติมโน้ต 59 รายการ
วิธีนี้ทำให้เจอของที่เปลี่ยนไปแล้ว 3 ตัวที่ `linkcheck` จับไม่ได้ (เว็บ rebrand, repo archived,
สินค้าย้ายที่) เพราะ **HTTP 200 ไม่ได้แปลว่าของยังอยู่**

## ตัดสินใจว่า "ไม่เอา" ก็ต้องบันทึก

```bash
./scripts/reject.sh -u <url> -r "<เหตุผล>" [-b <url ที่ดีกว่า>]
```

ไม่งั้นอีกสองเดือนเจอลิงก์เดิม `check.sh` ก็ตอบ `[ใหม่]` เหมือนไม่เคยดู แล้วต้องไล่ตรวจใหม่ทั้งหมด
**การตัดสินใจว่าไม่เอามีต้นทุนเท่ากับการตัดสินใจว่าเอา** แต่ awesome-list ทั่วโลกเก็บไว้แค่ฝั่งเดียว

## ecosystem map — มีกฎเพิ่มอีกข้อ

[`data/entities.yml`](data/entities.yml) ตอบคนละคำถามกับแคตตาล็อก: **ใครทำ ใครดูแล ใครจ่ายเงิน ใครตรวจ**

- ทุก `evidence` ต้องเป็น URL ที่มีอยู่จริงใน `resources.yml` — กราฟอ้างของที่ไม่มีรองรับไม่ได้
- **ไม่มี `kind: person`** และกันไว้ที่ schema ไม่ใช่ที่วินัยคนกรอก repo นี้เป็น public
  ข้อมูลรายบุคคล ช่องทางติดต่อส่วนตัว บันทึกการคุย และการประเมินตัวบุคคล **ห้ามใส่**
- `./scripts/entity-check.sh` ตรวจให้ และ `--self-test` พิสูจน์ว่าตัวตรวจเองยังจับของผิดได้จริง

## ภาษา

| ชั้น | ภาษา |
|---|---|
| commit, branch, PR title, โค้ดคอมเมนต์ | อังกฤษ |
| `note:` ในแคตตาล็อก, CATALOG, OPPORTUNITIES, README | ไทย |
| issue / PR description | ไทยหรืออังกฤษก็ได้ |

โน้ตเป็นไทยเพราะมันคือตัวผลิตภัณฑ์สำหรับชุมชนไทย ไม่ใช่ของแถม
ส่วนชั้น engineering เป็นอังกฤษเพื่อให้คนนอกกับเครื่องมืออ่านรู้เรื่อง

## ก่อนเปิด PR

- [ ] `./scripts/audit.sh` ผ่าน
- [ ] `./scripts/entity-check.sh` ผ่าน (ถ้าแตะ `entities.yml`)
- [ ] รัน `render.sh` / `render-graph.sh` แล้ว commit ไฟล์ที่ generate มาด้วย
- [ ] ไม่ได้แก้ `CATALOG.md` หรือ `GRAPH.md` ด้วยมือ

รายละเอียดกฎภายในและกับดักที่เคยเจอ อยู่ใน [CLAUDE.md](CLAUDE.md) — เขียนไว้สำหรับ agent
แต่คนอ่านก็ได้ประโยชน์เท่ากัน

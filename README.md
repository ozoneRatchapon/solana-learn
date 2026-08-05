# solana-learn

<!-- english -->
**In English:** a curated Solana resource catalogue, maintained in Thai for the
Solana Thailand community. Every entry carries a note explaining *when you would
reach for it and how it differs from its neighbours* — that note is the point of
the repo, and it is why the entries are in Thai. Decisions to **reject** a
resource are recorded too, with reasons, so the same link is not re-evaluated
every few months. A separate [ecosystem map](GRAPH.md) records who builds,
maintains, funds and audits what.

Everything is generated from YAML and checked in CI: link health, note coverage,
whether the docs still match the data. Scripts and structure are MIT licensed and
reusable for any language or ecosystem — see [CONTRIBUTING.md](CONTRIBUTING.md).
Issues and PRs in English are welcome.
<!-- /english -->

---

> คลังรวม resource Solana ทั้งหมดไว้ที่เดียว + วิเคราะห์ว่าจากของที่มีอยู่ เราสร้างอะไรได้บ้าง

ไม่ใช่คอร์ส ไม่ใช่ tutorial — เป็น **แคตตาล็อกที่ค้นได้ กันซ้ำได้ และเช็คลิงก์เน่าเองได้**
พร้อมเอกสารวิเคราะห์ว่าช่องว่างในระบบนิเวศอยู่ตรงไหน

| ไฟล์ | คืออะไร |
|---|---|
| [data/resources.yml](data/resources.yml) | **source of truth** — แก้ที่นี่ที่เดียว |
| [CATALOG.md](CATALOG.md) | รายการทั้งหมดจัดกลุ่มแล้ว (generate ห้ามแก้มือ) |
| [OPPORTUNITIES.md](OPPORTUNITIES.md) | วิเคราะห์: สร้างอะไรได้บ้างจาก resource ที่มี |
| [data/rejected.yml](data/rejected.yml) | ทะเบียน "ดูแล้วไม่เอา" + เหตุผล |
| [RADAR.md](RADAR.md) | โอกาสที่เปิดอยู่ + เดดไลน์ + verdict ว่าทำได้จริงไหม (generate) |
| [GRAPH.md](GRAPH.md) | ecosystem map — ใครทำ ใครดูแล ใครจ่ายเงิน ใครตรวจ (generate) |
| [RECIPES.md](RECIPES.md) | โจทย์ที่เจอจริง → หยิบอะไรมาต่อกัน + ข้อจำกัด (generate) |
| [web/index.html](web/index.html) | แผงควบคุมหน้าเดียว ค้นได้ทั้งแคตตาล็อก (generate) |
| [scripts/](scripts/) | check / add / reject / setnote / deprecate / render / linkcheck / audit |
| [CLAUDE.md](CLAUDE.md) | บริบทสำหรับ Claude Code — กฎเหล็ก, workflow, กับดักที่เคยเจอ |

ตอนนี้: **191 รายการ · 19 หมวด · ลิงก์ตาย 0**

> ตัวเลขบรรทัดบนถูกตรวจโดย `./scripts/audit.sh` — ถ้าไม่ตรงกับ YAML แล้ว CI จะไม่ผ่าน

---

## Workflow หลัก — เจอเว็บใหม่แล้วทำยังไง

```bash
# 1) มีในแคตตาล็อกหรือยัง
./scripts/check.sh https://some-solana-site.com/page

# 2) ถ้ายังไม่มี — เพิ่ม (เช็ค HTTP + กันซ้ำให้อัตโนมัติ)
./scripts/add.sh -u https://some-solana-site.com/page \
                 -n "ชื่อที่อ่านรู้เรื่อง" \
                 -c learning \
                 -s community \
                 -t "course,free" \
                 -m "ทำไมถึงเก็บอันนี้"

# 3) อัปเดต CATALOG.md
./scripts/render.sh
```

เช็คหลายอันพร้อมกันได้:

```bash
./scripts/check.sh url1 url2 url3
pbpaste | ./scripts/check.sh          # copy ลิสต์ลิงก์มาแปะแล้ว pipe เข้า
```

ผลลัพธ์มี 4 แบบ:

| | หมายถึง |
|---|---|
| `[มีแล้ว]` | ตรงเป๊ะ — บอกชื่อ + หมวด |
| `[เคยไม่เอา]` | เคยพิจารณาแล้วปฏิเสธ — บอกเหตุผลที่บันทึกไว้ + ตัวที่ใช้แทน |
| `[ใกล้เคียง]` | โดเมนเดียวกันคนละหน้า — ให้คนตัดสิน |
| `[ใหม่]` | ยังไม่เคยดู |

## ตัดสินใจว่า "ไม่เอา" ก็ต้องบันทึก

```bash
./scripts/reject.sh -u <url> -r "<เหตุผล>" [-b <url ที่ดีกว่า>]
```

เดิมพอตรวจลิงก์แล้วตัดสินใจไม่เก็บ ความรู้นั้นหายไปทันที — อีกสองเดือนเจอลิงก์เดิม
`check.sh` ก็ตอบ `[ใหม่]` เหมือนไม่เคยดู แล้วต้องไล่ตรวจใหม่ตั้งแต่ต้น
การตัดสินใจว่า "ไม่เอา" มีต้นทุนเท่ากับ "เอา" แต่เดิมเก็บไว้แค่ฝั่งเดียว

## ตรวจว่า repo ยังพูดความจริง

```bash
./scripts/audit.sh          # ข้อมูล · คุณภาพ · คำอ้างในเอกสาร · CATALOG ตรงกับ YAML
```

CI รันตัวนี้ทุก push — ตัวเลขใน README ที่ไม่ตรงกับ YAML ทำให้ build แดง

## หน้าเว็บ — ดูเองก่อน ไม่ต้องฝากใครโฮสต์

```bash
./scripts/web.sh            # render แล้วเปิดในเบราว์เซอร์เลย
./scripts/web.sh --serve    # เสิร์ฟ localhost:8765 (เปิดจากมือถือในวงแลนเดียวกันได้)
./scripts/web.sh --no-open  # render อย่างเดียว
```

`web/index.html` เป็น**ไฟล์เดียวจบ** ไม่มี dependency ภายนอกสักตัว — คัดลอกไปไหนก็เปิดได้
AirDrop / แนบอีเมล / ใส่ USB ก็ยังทำงานเหมือนเดิม และเปิดได้แม้ไม่มีเน็ต

**ขึ้นเว็บแล้วที่ https://solana-learn.solana-thailand.workers.dev**

ชั้นที่ AI agent อ่านได้ (static ทั้งหมด ไม่มีค่าใช้จ่ายเพิ่ม):

| path | คืออะไร |
|---|---|
| [`/llms.txt`](https://solana-learn.solana-thailand.workers.dev/llms.txt) | ดัชนีตามธรรมเนียมที่ solana.com กับ pay.sh ใช้ — เริ่มที่นี่ |
| [`/report.md`](https://solana-learn.solana-thailand.workers.dev/report.md) | สรุปสั้น ~11 KB ตัวเลข เดดไลน์ โอกาสที่ลงมือได้ |
| [`/data.json`](https://solana-learn.solana-thailand.workers.dev/data.json) | ข้อมูลดิบทั้งหมดไฟล์เดียว |
| `/catalog.md` `/radar.md` `/recipes.md` `/graph.md` | เอกสารเต็มแต่ละชั้น |

ทุกไฟล์เปิด CORS และระบุ charset — และ path ที่ไม่มีจริงตอบ **404** ไม่ใช่ 200 พร้อม HTML

```bash
./scripts/deploy.sh          # ตรวจ 4 ชั้น + render + dry-run
./scripts/deploy.sh --go     # ขึ้นจริง
```

ตั้งค่าอยู่ใน [wrangler.jsonc](wrangler.jsonc) ซึ่งอยู่ใน git — ต่างจาก Pages ที่เก็บไว้ในแดชบอร์ด
ที่ไม่มีตัวตรวจตัวไหนใน repo นี้มองเห็น · deploy จะไม่ยอมขึ้นถ้า audit / radar / recipe / entity
ตัวใดตัวหนึ่งไม่ผ่าน

การนับถอยหลังบนหน้าเว็บคำนวณจาก**วันที่ของเครื่องคนเปิด** ไม่ใช่วันที่ deploy
เปิดพรุ่งนี้ตัวเลขก็ยังถูกโดยไม่ต้อง deploy ใหม่ ส่วนป้ายมุมขวาบนบอกว่าข้อมูลเก่ากี่วัน
และเปลี่ยนเป็นสีเตือนเมื่อเกิน 30 วัน

## เช็คลิงก์เน่า

```bash
./scripts/linkcheck.sh              # รายงานอย่างเดียว
./scripts/linkcheck.sh learning     # เฉพาะหมวด
./scripts/linkcheck.sh --fix        # เขียน status กลับเข้า YAML ให้เลย
```

สถานะที่เป็นไปได้:

| status | หมายถึง |
|---|---|
| `ok` | 2xx |
| `blocked` | 401/403/429 — เว็บกัน bot ตอน curl **ลิงก์ยังใช้ได้ปกติ** (เช่น Solscan, Dune, DefiLlama) |
| `unverified` | ยิงไม่ผ่าน/timeout — ต้องเปิดดูด้วยตา |
| `dead` | 404/410 — ต้องหา URL ใหม่หรือถอดออก |

## "ลิงก์ยังเปิดได้" กับ "ยังควรใช้" เป็นคนละเรื่อง

`status` ตอบเรื่องแรก — เครื่องยิง HTTP เช็คเอง
`deprecated` ตอบเรื่องที่สอง — คนตัดสิน เครื่องตัดสินแทนไม่ได้

tutorial Anchor 0.29 คือ `status: ok` (ลิงก์เปิดได้) **และ** `deprecated` พร้อมกัน
ถ้ายัดรวมเป็น `status: deprecated` แล้ว `linkcheck --fix` รอบหน้าจะเขียนทับเป็น `ok`
เพราะมันได้ HTTP 200 — คำตัดสินของคนหายไปเงียบๆ

```bash
./scripts/deprecate.sh -u <url> -r "<เหตุผล>" [-b <url ที่ใช้แทน>]
./scripts/deprecate.sh -u <url> --undo
```

CATALOG.md จะแสดงเป็น ~~ขีดฆ่า~~ + เหตุผล + ตัวแทน — **ไม่ลบทิ้ง** เพราะคนที่เจอลิงก์นี้
จากที่อื่นต้องรู้ว่าเราดูแล้วและใช้อะไรแทน การลบเฉยๆ ทำให้เขาไปเสียเวลากับมันอยู่ดี

นี่คือรูปที่บำรุงรักษาได้ของ **"อันไหนยังใช้ได้ปี 2026"** (OPPORTUNITIES §1.2) —
ข้อมูลอยู่กับ entry ไม่ใช่ตารางแยกที่ต้องไล่อัปเดตเอง

---

## Schema ของ 1 entry

```yaml
- url: https://learn.blueshift.gg/        # unique หลัง normalize (ตัด scheme/www/trailing slash)
  name: Blueshift                          # ชื่อที่มนุษย์อ่านรู้เรื่อง
  category: learning                       # ต้องตรงกับ key ใน categories
  source: community                        # foundation | anza | community | vendor | thailand
  tags: [course, free, anchor]
  note: ทำไมถึงเก็บ / ใช้ตอนไหน
  status: ok
  added: 2026-08-04
```

`source` สำคัญกว่าที่คิด — เวลาข้อมูลขัดกัน ให้เชื่อ `foundation`/`anza` ก่อนเสมอ

## 19 หมวด

`official` · `learning` · `framework` · `client-sdk` · `testing` · `codegen` ·
`tokens-nft` · `payments` · `security` · `ai-agent` · `infra-rpc` ·
`data-analytics` · `defi` · `mobile` · `protocol` · `governance` · `green` · `funding` · `thailand`

จะเพิ่มหมวดใหม่ — เพิ่ม key ใน `categories:` ของ [data/resources.yml](data/resources.yml) แล้ว `render.sh` จัดให้เอง

---

## เริ่มอ่านจากตรงไหนดี

ถ้าไม่รู้จะเริ่มตรงไหน ลำดับนี้ใช้ได้จริงในปี 2026:

1. [solana.com/docs](https://solana.com/docs) — docs ถูก rebuild ปี 2026 code sample ผ่าน CI ทุกตัว เชื่อได้
2. [Blueshift](https://learn.blueshift.gg/) — ฟรี มี challenge ให้ทำจริง Foundation แนะนำเอง
3. [solana-dev-skill](https://github.com/solana-foundation/solana-dev-skill) + [MCP](https://mcp.solana.com/) — ต่อเข้า Claude Code แล้วให้มันดึง doc ที่ถูกต้องมาเอง
4. [Anchor v0.32 → v1 migration](https://github.com/solana-foundation/solana-dev-skill/blob/main/skills/solana-dev/references/anchor/migrating-v0.32-to-v1.md) — **ต้องอ่าน** เพราะ tutorial เก่าเกือบทั้งหมดยังเป็น 0.3x

## กับดักเวอร์ชันปี 2026

เรื่องที่ทำให้ tutorial เก่าใช้ไม่ได้ และเป็นสาเหตุอันดับหนึ่งที่คนใหม่ติด:

- **Anchor 1.0** ออกแล้ว — เนื้อหาส่วนใหญ่บนเน็ตยังเป็น 0.30/0.31/0.32
- **`@solana/web3.js` v1 อยู่ maintenance** (แก้เฉพาะ security) → ของใหม่ใช้ [`@solana/kit`](https://www.solanakit.com/) หรือ [web3.js v3](https://github.com/solana-foundation/solana-web3.js/tree/v3.x) ที่หน้าตาเหมือน v1 แต่ไส้ในเป็น Kit
- **`solana-test-validator` ช้า** → ใช้ [LiteSVM](https://github.com/LiteSVM/litesvm) / [Mollusk](https://github.com/anza-xyz/mollusk) / [Surfpool](https://github.com/solana-foundation/surfpool) แทน
- **curated list ของ Foundation เองก็มีลิงก์ตาย** — ตอนสร้าง repo นี้เจอ 404 สองตัว (`/docs/clients/kit`, `/docs/programs/codama-generating-clients`) เลยเป็นเหตุผลว่าทำไมต้องมี `linkcheck.sh`

---

## Related repos

- [solana-thailand-genesis](../solana-thailand-genesis) — ชุมชน + quest + treasury
- [solana-thailand-devrel-helper](../solana-thailand-devrel-helper) — SOP งานอีเวนต์ (แนวคิด one-YAML-source-of-truth มาจากตรงนั้น)
- [solana-starter](../solana-starter), [spl_nft_q2_26](../spl_nft_q2_26) — โค้ดฝึกมือของเดิม

## ต้องมีอะไรบ้าง

`bash` · [`yq`](https://github.com/mikefarah/yq) v4 (`brew install yq`) · `curl`

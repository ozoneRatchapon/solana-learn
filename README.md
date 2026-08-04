# solana-learn

> คลังรวม resource Solana ทั้งหมดไว้ที่เดียว + วิเคราะห์ว่าจากของที่มีอยู่ เราสร้างอะไรได้บ้าง

ไม่ใช่คอร์ส ไม่ใช่ tutorial — เป็น **แคตตาล็อกที่ค้นได้ กันซ้ำได้ และเช็คลิงก์เน่าเองได้**
พร้อมเอกสารวิเคราะห์ว่าช่องว่างในระบบนิเวศอยู่ตรงไหน

| ไฟล์ | คืออะไร |
|---|---|
| [data/resources.yml](data/resources.yml) | **source of truth** — แก้ที่นี่ที่เดียว |
| [CATALOG.md](CATALOG.md) | รายการทั้งหมดจัดกลุ่มแล้ว (generate ห้ามแก้มือ) |
| [OPPORTUNITIES.md](OPPORTUNITIES.md) | วิเคราะห์: สร้างอะไรได้บ้างจาก resource ที่มี |
| [scripts/](scripts/) | check / add / render / linkcheck |
| [CLAUDE.md](CLAUDE.md) | บริบทสำหรับ Claude Code — กฎเหล็ก, workflow, กับดักที่เคยเจอ |

ตอนนี้: **127 รายการ · 17 หมวด · ลิงก์ตาย 0**

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

ผลลัพธ์มี 3 แบบ — `[มีแล้ว]` ตรงเป๊ะ, `[ใกล้เคียง]` โดเมนเดียวกันคนละหน้า (ให้คนตัดสิน), `[ใหม่]` ยังไม่มี

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

## 17 หมวด

`official` · `learning` · `framework` · `client-sdk` · `testing` · `codegen` ·
`tokens-nft` · `payments` · `security` · `ai-agent` · `infra-rpc` ·
`data-analytics` · `defi` · `mobile` · `protocol` · `funding` · `thailand`

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

# สร้างอะไรได้บ้างจาก resource ที่มี

วิเคราะห์จากการรวบรวม 180 รายการใน [CATALOG.md](CATALOG.md) เมื่อ 2026-08-05
**ตัวเลขในเอกสารนี้แช่ไว้ที่วันวิเคราะห์โดยตั้งใจ** — ข้อสรุปตั้งอยู่บนข้อมูลชุดนั้น ถ้าแคตตาล็อกโตไปมาก `audit.sh` จะเตือนให้กลับมาอ่านใหม่ ไม่ใช่ให้ไล่แก้ตัวเลข
ยึดโยงกับตำแหน่งจริงของเรา: **Solana Thailand Genesis (Community Operator)** + **DevRel Helper** + **Superteam TH**

> ฉบับก่อนวิเคราะห์บน 127 รายการ (2026-08-04) ฉบับนี้เขียนใหม่หลังโตเป็น 180 และหลังตรวจข้อสรุปเดิมทีละข้อ
> **มีสองข้อที่พังจริงและถูกแก้แล้ว** ระบุไว้ในที่ของมัน ไม่ได้ลบเงียบๆ

---

## ข้อสังเกตที่ได้จากการรวบรวมจริง

ไม่ใช่ความเห็น — เป็นสิ่งที่เจอตอนไล่เก็บและยิงเช็คลิงก์

**1. ลิงก์เน่าเกิดขึ้นแม้แต่ในลิสต์ทางการ — และรอบนี้หนักกว่าเดิม**

ฉบับก่อนพบ 404 สองตัวใน curated list ของ Foundation รอบนี้เจอของที่แย่กว่า 404 เพราะ**ตอบ 200 แต่ของหายไปแล้ว**:

| เคส | เกิดอะไร |
|---|---|
| Kora | `docs.kora.network` ตายที่ TLS และโดเมน `kora.network` กลายเป็น parked domain ประกาศขาย (apex ตอบ 200 เนื้อ 114 byte) |
| Flipside Crypto | redirect ไป `edisyl.com` บริษัท rebrand ไปทำ enterprise software หน้าเว็บไม่มีคำว่า Solana เลย |
| developer-content | `archived: true` ตั้งแต่ ม.ค. 2025 แต่โน้ตเดิมเขียนว่า "PR เข้าตรงนี้ได้ ช่องทางหลักถ้าจะ contribute" |
| SPA ทั่วไป | `governance.solana.com`, `world.xyz`, Ashby, Colosseum FAQ — curl ได้ 200 แต่ไม่มีเนื้อ |

**`status: ok` ไม่ได้แปลว่ายังมีของ** — `linkcheck.sh` ตาม redirect แล้วรายงานเขียว มันจับสี่แบบนี้ไม่ได้เลยสักแบบ
นี่คือเหตุผลที่ลิสต์ที่มีคนเปิดอ่านจริงมีค่ากว่าลิสต์ที่มีแค่ CI ยิง HTTP

**2. ปัญหาใหญ่สุดยังเป็น "ไม่รู้ว่าอันไหนยังใช้ได้" แต่ข้อสรุปเดิมผิดครึ่งหนึ่ง**

สองคลื่นเดิมยังจริง (Anchor 0.3x → 1.0 · web3.js v1 → Kit/v3) แต่ฉบับก่อนเขียนว่า **"ไม่มีใครทำ" ซึ่งไม่จริง**
Foundation มี [compatibility-matrix.md](https://github.com/solana-foundation/solana-dev-skill/blob/main/skills/solana-dev/references/compatibility-matrix.md) ขนาด 15 KB ครอบ Anchor 0.29→1.1.x, Solana CLI, Platform Tools, GLIBC รายดิสโทร อยู่แล้ว
น่าอายกว่านั้นคือไฟล์นั้น**ไม่เคยอยู่ในแคตตาล็อกจนกระทั่งวันนี้** ทั้งที่เป็นวัตถุดิบหลักของงานที่ตั้งเป็นธง

ปี 2026 ยังเพิ่มแกนที่สามด้วย — **Agave 4.2** เปิด feature บน mainnet **17 ส.ค. 2026**: rent ลด 90% (SIMD-0437), tx ขยาย 1,232→4,096 byte (SIMD-0296), slot 400→200ms (SIMD-0525)

**3. Agent Skills ยังเป็นหน้าต่างที่เปิดอยู่ และรอบนี้มีวัตถุดิบเพิ่มเยอะ**

ของใหม่ที่ทำให้ต้นทุนถูกลงมาก: [llms.txt](https://solana.com/llms.txt) เป็นดัชนี 514 หน้า และ**เติม `.md` ท้าย URL ไหนก็ได้จะได้ markdown ดิบ** · [MCP ทางการ](https://mcp.solana.com/) 5 tool ไม่ต้องใช้ API key · [pay.sh](https://pay.sh/) ให้ agent จ่ายค่า API เองได้ · [solana-state](https://solana-state.vercel.app/) มี `/api/report/markdown` สรุปเครือข่าย 4.6 KB รีเฟรชทุก 30 นาที

รูปแบบ "หน้าเว็บเสิร์ฟ markdown ให้ agent" โผล่สามที่ในวันเดียว — กำลังกลายเป็นมาตรฐานจริง ไม่ใช่ของแถม

> ตัวเลข "skill ทางการ 11 ตัว community 30+" จากฉบับก่อน **ยังไม่ได้ตรวจซ้ำ** `solana.com/skills` เป็น client-side render นับจาก curl ไม่ได้ อย่าเอาไปอ้างจนกว่าจะเปิดดูด้วยตา

**4. ยังไม่มีภาษาไทยในแคตตาล็อกแม้แต่รายการเดียว — และช่องทางที่เคยเสนอไว้ตายแล้ว**

ฉบับก่อนบอกให้ PR เข้า `developer-content` — **repo นั้น archived ตั้งแต่ ม.ค. 2025 เปิด PR ไม่ได้**
เส้นทาง i18n ที่ยังมีชีวิตคือ `.lingo` ใน [solana-com](https://github.com/solana-foundation/solana-com) และ **upstream ใช้เครื่องแปลอยู่แล้ว** การเปิด locale ใหม่จึงเป็นการตัดสินใจเชิงงบประมาณของ Foundation ไม่ใช่ PR ที่ merge ได้ด้วยความถูกต้องทางเทคนิค

ยืนยันแล้ว: `solana.com/th` = 404 · `/vi` = 200 · `llms-th.txt` = 404 · `llms-vi.txt` = 200
ถ้อยคำที่ปลอดภัยคือ **"SEA มี locale แค่บางภาษา ไทยยังไม่มี"** ห้ามพูดว่าชาติเดียวที่ไม่มี

**5. เครื่องมือทดสอบรุ่นใหม่ยังแก้ปัญหาเวิร์กช็อปได้เหมือนเดิม**

[LiteSVM](https://github.com/LiteSVM/litesvm) / [Mollusk](https://github.com/anza-xyz/mollusk) / [Surfpool](https://github.com/solana-foundation/surfpool) — ไม่ต้องรอ airdrop ไม่ต้องพึ่ง devnet
ข้อนี้ไม่มีอะไรเปลี่ยน และยังเป็นข้อที่ให้ผลตอบแทนต่อแรงสูงที่สุดในงานอีเวนต์

**6. น้ำหนักของ repo ย้ายไปแล้ว — เอกสารฉบับก่อนบรรยาย repo ที่ไม่มีอยู่จริงอีกต่อไป**

`payments` เป็นหมวดใหญ่ที่สุด (20) และ `governance` เป็นหมวดใหม่ทั้งหมด (8)
ส่วนสายที่ฉบับก่อนตั้งอยู่บนนั้น — `learning` 13 · `framework` 12 · `testing` 5 — **ไม่ได้ของใหม่เลยในรอบนี้**

เรื่องที่ต่อกันเป็นเส้นเดียวและใหญ่กว่าที่คิดตอนแรกคือ **"เริ่มใช้ Solana โดยไม่ต้องมี SOL ก่อน"**:
[Kora](https://solana.com/docs/tools/kora) จ่ายค่าแก๊สแทน · [fee abstraction](https://solana.com/docs/payments/send-payments/payment-processing/fee-abstraction) · [x402/pay.sh](https://pay.sh/) จ่ายต่อครั้งไม่ต้องสมัคร · Agave 4.2 ลด rent 90% · [subscriptions](https://github.com/solana-foundation/subscriptions) audit แล้วขึ้น mainnet แล้ว
นี่คือกำแพงแรกที่เจอทุกอีเวนต์ และตอนนี้มีคำตอบครบทั้งกอง

**7. การตัดสินใจว่า "ไม่เอา" ถูกบันทึกแล้ว — และนี่คือจุดต่างจริงจาก awesome-list**

`data/rejected.yml` มี 17 รายการพร้อมเหตุผล `check.sh` ตอบ `[เคยไม่เอา]` ได้แล้ว
awesome-list ทั่วโลกบันทึกแค่ฝั่ง "เอา" — ฝั่ง "ดูแล้วไม่เอาเพราะอะไร" หายไปกับตัวคนเสมอ ทั้งที่มีต้นทุนเท่ากัน

**8. CI มีจริงแล้ว (ฉบับก่อนเขียนเกินจริง)**

บรรทัดที่ว่า "ของเรามี CI เช็ค" ตอนเขียนฉบับแรก **ยังไม่มี `.github/` เลยสักไฟล์** ตอนนี้มีจริง: `audit.yml` + `linkcheck.yml` รันทุก push เขียวทั้งคู่วันนี้
บทเรียน: อย่าเขียนสิ่งที่ยังไม่ได้ทำด้วยรูปปัจจุบันกาล เพราะเอกสารนี้คือสิ่งที่ใช้ตัดสินใจ

---

## Tier 1 — ทำได้เลย ใช้ของที่มีอยู่แล้ว ผลตอบแทนชัด

### 1.1 ดันต่อสาธารณะ — ครึ่งที่ขาดคือ distribution ไม่ใช่ CI

CI เสร็จแล้ว แต่ **CI ไม่ใช่ช่องทางเผยแพร่** ทำเสร็จก็ยังไม่มีใครเห็นอยู่ดี (repo public, ดาว 0, ยังไม่เคยประกาศที่ไหน)

ช่องที่ต้นทุนเกือบศูนย์และไม่ต้องรออนุมัติใคร: [ฟอร์มส่งอีเวนต์เข้าปฏิทินนักพัฒนาโลก](https://docs.google.com/forms/d/e/1FAIpQLSfTosHwpQg2Uvf7tgySMSIEzyJGxaRaNNSL9HhTl_GgNFQvWg/viewform) ของ Foundation — กรอก 4 ช่องบังคับก็ส่งได้ งาน Genesis/Superteam TH ที่จัดอยู่แล้วส่งเข้าไปได้ทันที
เพิ่ม: [forum.solana.com](https://forum.solana.com/c/gov/11) · [MagicBlock Builders](https://build.magicblock.app/builders) (แต่ต้องผูก Telegram + กระเป๋า บอกคนในชุมชนก่อน)

**metric ที่ควรดู ไม่ใช่ดาว** — มีคนไทยส่ง PR เพิ่ม resource เข้ามาไหม และมีใครอ้างหน้าตารางเวอร์ชันตอนตอบคำถามในกลุ่มไหม

### 1.2 ตารางความเข้ากันได้ — re-scope ไม่ใช่ทำใหม่ทั้งตาราง

**ตัดทิ้ง:** แกน Anchor / CLI / Platform Tools / GLIBC — Foundation ทำแล้วและละเอียดกว่า **cite เขา อย่าเขียนแข่ง**

**เหลือสามส่วนที่ upstream ไม่มี:**
1. **TL;DR ภาษาไทย** + ลิงก์ต้นทาง (งานไม่กี่ชั่วโมง)
2. **แกน Anchor × [`@solana/kit`](https://github.com/anza-xyz/kit) / web3.js v3** — matrix ของ Foundation ไม่มีเลย และเป็นแกนที่คนเรียนไทยชนบ่อยสุด
3. **บล็อก verified-on-macOS** จากเครื่องจริง — ของ Foundation อิง Debian

**ระวังเรื่องเวอร์ชัน:** อย่าอัป `anchor-cli` จาก 1.0.2 ขึ้น เพราะจะเทสสาย 1.0 ไม่ได้อีก ใช้ AVM สลับสายแทน
และ TS package เปลี่ยนชื่อ `@coral-xyz/anchor` → `@anchor-lang/core` ตั้งแต่ 1.0.x — ท่าเช็ค `grep -r "@coral-xyz" --include=package.json .`

### 1.3 แปลงโค้ดเดิมเป็น Quest ของ Genesis

[solana-starter](../solana-starter) + [spl_nft_q2_26](../spl_nft_q2_26) ครอบ SPL init/mint/transfer/metadata, NFT mint, vault deposit/withdraw — พอเป็น quest 6–8 ข้อ
**ของใหม่ที่ทำให้ข้อนี้ดีขึ้น:** [เช็คลิสต์ 14 ข้อก่อนขึ้น mainnet](https://solana.com/docs/payments/production-readiness) เอาไปเป็น acceptance criteria ของ quest ระดับสูงได้ตรงๆ โดยไม่ต้องคิดเอง

---

## Tier 2 — leverage สูง แต่ต้องลงแรง

### 2.1 Agent Skill สาย education/community

ยังไม่มีใครทำ skill ที่ตรวจว่าโค้ดในบทเรียนยังรันได้กับ toolchain ปัจจุบัน / แปลง event YAML → workshop → quest → acceptance criteria / onboard คนไทยตามระดับ
เส้นทางเผยแพร่: PR เข้า [awesome-solana-ai](https://github.com/solana-foundation/awesome-solana-ai) → ขึ้น [solana.com/skills](https://solana.com/skills)
**ถูกลงกว่าเดิมมาก** เพราะ llms.txt + MCP + `.md` suffix ทำให้ไม่ต้อง scrape อะไรเลย

### 2.2 ดันภาษาไทยเข้า upstream — เปลี่ยนวิธี ไม่ใช่เปลี่ยนเป้า

~~ทางเลือกเบา: PR เข้า developer-content~~ **ตายแล้ว repo archived**

ท่าที่ถูกและต้นทุนเกือบศูนย์: **เปิด issue ที่ [solana-com](https://github.com/solana-foundation/solana-com) ถามเกณฑ์การเพิ่ม target locale** พร้อมตัวเลขความต้องการฝั่งไทยจาก Genesis แล้วเสนอตัวเป็นคนตรวจคุณภาพภาษาไทย — ได้คำตอบก่อนลงแรง
ผลพลอยได้ที่สำคัญกว่าตัวงาน: การมีชื่ออยู่ในบทสนทนาของ Foundation = credential ที่ใช้ต่อยอดได้จริง

### 2.3 Workshop kit ที่ไม่ต้องพึ่ง devnet

Surfpool fork mainnet + cheatcode / LiteSVM รันในเครื่อง → 40 คนในห้องไม่ชนกัน
**เนื้อหาใหม่ที่ควรพ่วง:** ชุด "มี USDC แต่ไม่มี SOL" จากข้อสังเกต #6 — เป็นเรื่องที่ผู้เข้าร่วมเจอจริงตั้งแต่นาทีแรกทุกครั้ง

---

## Tier 3 — น่าสน แต่ยังเป็นการเดา ต้องพิสูจน์ก่อน

| ไอเดีย | สมมติฐานที่ต้องพิสูจน์ก่อน |
|---|---|
| **Genesis stake vault ด้วย ZK Compression** ([Light Protocol](https://www.lightprotocol.com/)) | เดิมถามว่าสมาชิกมากพอให้ rent เป็นปัญหาหรือยัง — **Agave 4.2 ลด rent 90% ข้อนี้จึงอ่อนลงอีก** ต้องมีเหตุผลอื่นนอกจากค่า rent |
| **Dashboard ชุมชนไทย** บน [Dune](https://dune.com/) | on-chain ไม่มี geo — ต้องพึ่ง registry ของเราเอง ยังไม่เปลี่ยน |
| **Mobile / [dApp Store](https://docs.solanamobile.com/)** | มีคนในชุมชนที่ทำ mobile ได้จริงกี่คน? หมวด `mobile` มี 2 รายการ สะท้อนว่ายังไม่ได้ลงแรงตรวจ |
| **[Superteam Earn](https://earn.superteam.fun/)** เป็นบันไดขั้นแรก | bounty ที่เปิดอยู่ตรงกับสกิลคนในชุมชนแค่ไหน? ต้องไปนั่งดูของจริง |

**ออกจาก Tier 3 แล้ว: Colosseum** — สมมติฐานเดิมคือ "hackathon รอบต่อไปเมื่อไหร่ (รอบ 2026 จบไป พ.ค.)"
คำตอบคือ **ไม่ต้องรอ** [Colosseum Eternal](https://colosseum.com/eternal) เปิดตลอดปี กดนาฬิกาเองแล้วมี 4 สัปดาห์ ชิง $250K pre-seed + ที่นั่ง accelerator
เหลือสมมติฐานเดียวคือ "ทีมพร้อมทุ่ม 4 สัปดาห์ไหม" ซึ่งตอบเองได้ ไม่ต้องหาข้อมูลเพิ่ม

---

## ของที่มีเดดไลน์จริง

| เมื่อไหร่ | อะไร |
|---|---|
| **5–19 ส.ค. 2026** | [Alpenglow bug bounty](https://github.com/anza-xyz/alpenglow) — เพดาน 50,000 SOL · ไม่ต้องลงทะเบียน · ต้องมี PoC · **อะไรที่ public แล้วถือว่าตกเกณฑ์ทันที รวมถึงโพสต์ใน Discord** |
| **17 ส.ค. 2026** | Agave 4.2 เริ่มเปิด feature บน mainnet — indexer ต้องรองรับ tx v1 |

---

## ถ้าให้เลือกอย่างเดียว

**1.2 ฉบับ re-scope — หน้าเดียว ภาษาไทย: Anchor × Kit/web3.js v3 + บล็อก verified-on-macOS**

เพราะไม่ต้องรออนุมัติจากใคร (ต่างจาก locale ที่ต้องให้ Foundation ตัดสินใจ) ใช้เครื่องที่ติดตั้งอยู่แล้ว และเป็นวัตถุดิบให้ 1.3 / 2.1 / 2.3 ทั้งหมด
ที่เปลี่ยนจากฉบับก่อนคือ **ตัดครึ่งที่ Foundation ทำแล้วทิ้ง แล้ว cite เขาแทน** ไม่ใช่เขียนแข่ง

## ลำดับที่แนะนำ

```
เดดไลน์ก่อน (bounty 5–19 ส.ค. · Agave 4.2 วันที่ 17)
        ↓
1.2 (ตารางเวอร์ชัน re-scope)  →  1.1 distribution  →  1.3 (quest)
                                        ↓
                              2.1 (skill)  ·  2.3 (workshop kit)
                                        ↓
                                2.2 (issue ถามเกณฑ์ locale)
```

---

## หมายเหตุความเชื่อถือได้

- ทุกลิงก์ยิง HTTP เช็คแล้ว 2026-08-05 — ตาย 0 · `blocked` 5 ตัวคือเว็บกัน bot ไม่ใช่ลิงก์เสีย
- ข้อสังเกตทุกข้อมาจากการตรวจไฟล์/ยิงลิงก์จริง ไม่ใช่ความจำ — ข้อที่ยังไม่ได้ตรวจถูกกำกับไว้ชัด
- **โน้ตยังขาด 59/180 (33%)** ทั้งหมดเป็นของชุด 127 เดิม ของที่เพิ่มรอบนี้มีโน้ตครบ
- Tier 3 ทั้งหมดเป็นสมมติฐานที่ยังไม่ได้ตรวจ — ถูกจัดแยกไว้ด้วยเหตุผลนั้น
- ตัวเลข ecosystem จากฉบับก่อน (stake ของ Firedancer ~14%) **ยังไม่ได้เช็คซ้ำ** อย่าเอาไปอ้างในที่สาธารณะก่อนตรวจ

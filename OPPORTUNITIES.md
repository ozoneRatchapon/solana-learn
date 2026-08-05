# สร้างอะไรได้บ้างจาก resource ที่มี

วิเคราะห์จากการรวบรวม 127 รายการใน [CATALOG.md](CATALOG.md) เมื่อ 2026-08-04
**ตัวเลขในเอกสารนี้แช่ไว้ที่วันวิเคราะห์โดยตั้งใจ** — ข้อสรุปตั้งอยู่บนข้อมูลชุดนั้น ถ้าแคตตาล็อกโตไปมาก `audit.sh` จะเตือนให้กลับมาอ่านใหม่ ไม่ใช่ให้ไล่แก้ตัวเลข
ยึดโยงกับตำแหน่งจริงของเรา: **Solana Thailand Genesis (Community Operator)** + **DevRel Helper** + **Superteam TH**

---

## ข้อสังเกต 5 ข้อที่ได้จากการรวบรวมจริง

ไม่ใช่ความเห็น — เป็นสิ่งที่เจอตอนไล่เก็บและยิงเช็คลิงก์ทั้ง 127 อัน

**1. ลิงก์เน่าเกิดขึ้นแม้แต่ในลิสต์ทางการ**
curated list ของ Foundation เอง (`solana-dev-skill/references/resources.md`) มี 404 อยู่ 2 ตัว —
`/docs/clients/kit` และ `/docs/programs/codama-generating-clients` ทั้งคู่ย้ายที่แล้ว
แปลว่า "ลิสต์ที่มีคนดูแลจริงและตรวจซ้ำได้" มีค่ากว่าที่คิด

**2. ปัญหาใหญ่สุดของคนเรียนปี 2026 ไม่ใช่ "หาของไม่เจอ" แต่คือ "ไม่รู้ว่าอันไหนยังใช้ได้"**
เกิดพร้อมกัน 2 คลื่น: Anchor 0.3x → **1.0** และ web3.js v1 → **Kit / v3**
ผลคือ tutorial บนเน็ตเกินครึ่งรันไม่ผ่าน แต่ไม่มีป้ายบอก คนใหม่เสียเวลาตรงนี้มากที่สุด

**3. Agent Skills คือหน้าต่างที่เพิ่งเปิดปี 2026 และยังว่าง**
Foundation ทำ [solana.com/skills](https://solana.com/skills) + [MCP](https://mcp.solana.com/) + [awesome-solana-ai](https://github.com/solana-foundation/awesome-solana-ai) ที่รับ PR
skill ทางการมี 11 ตัว community 30+ ตัว — **ยังไม่มีตัวไหนเป็นสาย education/community ops เลย** ทุกตัวเป็น protocol integration
เราเป็นทีมที่ทำ workflow แบบ agent-first อยู่แล้ว (devrel-helper) ตรงนี้คือช่องที่เรามีของจริงมากกว่าคนอื่น

**4. ทั้งแคตตาล็อกไม่มีภาษาไทยแม้แต่รายการเดียว**
แต่ [solana-com](https://github.com/solana-foundation/solana-com) มีระบบ i18n อยู่ในนั้นแล้ว และ [developer-content](https://github.com/solana-foundation/developer-content) รับ PR
ช่องทางมีอยู่ ไม่มีใครเดินเข้าไป

**5. เครื่องมือทดสอบรุ่นใหม่แก้ปัญหาคลาสสิกของงานเวิร์กช็อป**
[LiteSVM](https://github.com/LiteSVM/litesvm) / [Mollusk](https://github.com/anza-xyz/mollusk) / [Surfpool](https://github.com/solana-foundation/surfpool) — ไม่ต้องรอ airdrop ไม่ต้องพึ่ง devnet
ใครเคยจัด workshop แล้วโดน devnet rate-limit ตอนคน 40 คนขอ airdrop พร้อมกันจะรู้ว่านี่เปลี่ยนเกม

---

## Tier 1 — ทำได้เลย ใช้ของที่มีอยู่แล้ว ผลตอบแทนชัด

### 1.1 ดัน repo นี้เป็น "Solana Resource Index (TH)" ต่อสาธารณะ

ที่มีอยู่แล้ว ณ วันวิเคราะห์: 127 รายการ verified + script กันซ้ำ + linkcheck + โน้ตภาษาไทยว่าแต่ละอันใช้ตอนไหน

**ทำเพิ่ม:** GitHub Action รัน `linkcheck.sh --fix` ทุกสัปดาห์ → เปิด issue อัตโนมัติเมื่อเจอลิงก์ตาย
เป็น artifact ที่ "มีชีวิต" ไม่ใช่ awesome-list ที่ตายใน 3 เดือนเหมือนที่เห็นทั่วไป

**ทำไมถึงมีช่อง:** awesome-list ทั่วไปไม่มีใครเช็คลิงก์ ของเรามี CI เช็ค — ข้อแตกต่างเดียวนี้พอแล้ว
**ต้นทุน:** ต่ำมาก · **ความเสี่ยง:** ต้องมีคนดูแลจริง ไม่งั้นก็ตายเหมือนกัน

### 1.2 "อันไหนยังใช้ได้ปี 2026" — หน้าเดียวที่แก้ปัญหาข้อสังเกต #2

ตารางเทียบ: Anchor 0.29/0.30/0.31/0.32/**1.0** × web3.js v1/Kit/v3 × ตัวอย่างโค้ดที่รันผ่านจริง

**วัตถุดิบพร้อมแล้วในแคตตาล็อก:** [compatibility matrix](https://github.com/solana-foundation/solana-dev-skill) ของ Foundation, [Anchor migration guide](https://github.com/solana-foundation/solana-dev-skill/blob/main/skills/solana-dev/references/anchor/migrating-v0.32-to-v1.md), [web3.js v1→v3 migration](https://github.com/solana-foundation/solana-web3.js/blob/v3.x/docs/web3js-v1-to-v3-migration.md), [Sunrising web3.js](https://blueshift.gg/research/sunrising-web3js-reuniting-solanas-typescript-ecosystem)

**ของที่เรามีเหนือคนอื่น:** เครื่องเราติดตั้ง anchor-cli 1.0.2 + solana-cli 3.1.10 + rustc 1.97.1 อยู่แล้ว → ยืนยันได้ว่าอะไรรันผ่านจริง ไม่ใช่เดา
**นี่คือชิ้นที่ผมคิดว่าคุ้มที่สุดในลิสต์ทั้งหมด** — ปวดจริง แก้ได้จริง ไม่มีใครทำ

### 1.3 แปลง [solana-starter](../solana-starter) + [spl_nft_q2_26](../spl_nft_q2_26) เป็น Quest ของ Genesis

Genesis มีระบบ stake → build → unstake อยู่แล้ว แต่ quest ต้องมีเนื้อหามาจากไหนสักที่
โค้ดเดิมของเราครอบคลุม: SPL init/mint/transfer/metadata, NFT mint, vault deposit/withdraw — ครบพอเป็น quest 6–8 ข้อ

**ทำเพิ่ม:** อัปเดตจาก web3.js v1 → Kit และเขียน acceptance criteria ต่อ quest ให้ตรวจอัตโนมัติได้
**ต้นทุน:** ปานกลาง · เชื่อมกับระบบ reputation ที่มีอยู่แล้วโดยตรง

---

## Tier 2 — leverage สูง แต่ต้องลงแรง

### 2.1 Agent Skill สาย education/community (ช่องว่างจากข้อสังเกต #3)

ยังไม่มีใครทำ skill ที่:
- ตรวจว่าโค้ด Solana ในบทเรียนยังรันได้กับ toolchain ปัจจุบันไหม
- แปลง event YAML → เนื้อหา workshop → quest → acceptance criteria (คือ devrel-helper ที่เรามีอยู่ ทำให้เป็น skill สาธารณะ)
- onboard คนใหม่แบบภาษาไทย ชี้ resource ที่ถูกต้องตามระดับ

**เส้นทางเผยแพร่ชัดเจน:** PR เข้า [awesome-solana-ai](https://github.com/solana-foundation/awesome-solana-ai) → ขึ้น [solana.com/skills](https://solana.com/skills)
**ทำไมเราได้เปรียบ:** เรามี workflow agent-first ที่ใช้งานจริงอยู่แล้ว คนอื่นต้องเริ่มจากศูนย์
**ความเสี่ยง:** มาตรฐาน skill ยังใหม่ ([spec](https://agentskills.io/specification)) อาจเปลี่ยน — แต่ของที่จะเปลี่ยนคือ packaging ไม่ใช่เนื้อหา

### 2.2 ดันภาษาไทยเข้า upstream (ข้อสังเกต #4)

สองระดับ:
- **เบา:** แปล guide ที่คนไทยใช้บ่อยที่สุด 5–10 หน้า → PR เข้า [developer-content](https://github.com/solana-foundation/developer-content)
- **หนัก:** เปิด locale ไทยใน [solana-com](https://github.com/solana-foundation/solana-com)

**ผลพลอยได้ที่สำคัญกว่าตัวงาน:** merged PR เข้า repo ของ Foundation = credential ที่ใช้ต่อยอดขอ grant / เสนอตัวเป็น regional DevRel ได้จริง
และเข้ากับระบบ Genesis พอดี — merged PR = reputation
**ความเสี่ยง:** แปลแล้วต้องตามอัปเดตตลอด ไม่งั้นเป็นหนี้ให้ upstream — ควรเริ่มจากหน้าที่นิ่งแล้วเท่านั้น

### 2.3 Workshop kit ที่ไม่ต้องพึ่ง devnet (ข้อสังเกต #5)

Surfpool fork mainnet + cheatcode / LiteSVM รันในเครื่อง → 40 คนในห้องไม่ชนกัน ไม่ต้องขอ airdrop
เอาไปใส่ [SOP 03-run-event-live](../solana-thailand-devrel-helper/sops/03-run-event-live.md) ได้ตรงๆ

**ต้นทุน:** ปานกลาง · ใช้ซ้ำได้ทุกอีเวนต์ ยิ่งจัดบ่อยยิ่งคุ้ม

---

## Tier 3 — น่าสน แต่ยังเป็นการเดา ต้องพิสูจน์ก่อน

ส่วนนี้ผมมั่นใจน้อยกว่าสองส่วนบน อย่าเพิ่งลงแรงหนักจนกว่าจะทดสอบสมมติฐาน

| ไอเดีย | สมมติฐานที่ต้องพิสูจน์ก่อน |
|---|---|
| **Genesis stake vault ด้วย ZK Compression** ([Light Protocol](https://www.lightprotocol.com/)) — badge/reputation แบบไม่จ่าย rent | จำนวนสมาชิกมากพอที่ค่า rent จะเป็นปัญหาจริงหรือยัง? ถ้ายังไม่ถึงหลักพัน อาจเป็นการ over-engineer |
| **Dashboard ชุมชนไทย** บน [Dune](https://dune.com/) — ยอดกระเป๋าไทยที่ active, quest completion | มีข้อมูลพอ query แยก "ไทย" ได้จริงไหม? on-chain ไม่มี geo — ต้องพึ่ง registry ของเราเอง |
| **Mobile / [dApp Store](https://docs.solanamobile.com/)** — 0% fee + builder grant | มีคนในชุมชนที่ทำ mobile ได้จริงกี่คน? |
| **ลุย [Colosseum](https://colosseum.com/) เป็นทีม TH** — hackathon + accelerator $250K | ทีมพร้อมทุ่มเต็มเวลาไหม? hackathon รอบต่อไปเมื่อไหร่ (รอบปี 2026 จบไปแล้ว พ.ค.) |
| **[Superteam Earn](https://earn.superteam.fun/) เป็นบันไดขั้นแรก** — จับคู่ bounty กับ Builder ใน Genesis | bounty ที่เปิดอยู่ตรงกับสกิลคนในชุมชนแค่ไหน? ต้องไปนั่งดูของจริง |

---

## ถ้าให้เลือกอย่างเดียว

**1.2 (ตารางความเข้ากันได้ของเวอร์ชัน)** — เพราะเป็นจุดเดียวที่ปัญหาจริง + ไม่มีคนทำ + เรามีเครื่องมือยืนยันอยู่ในมือแล้ว
และมันเป็นวัตถุดิบตั้งต้นให้ 1.3 (quest), 2.1 (skill), 2.3 (workshop) ทั้งหมด — ทำอันนี้ก่อนแล้วอันอื่นถูกลง

## ลำดับที่แนะนำ

```
1.1 (repo สาธารณะ + CI)  →  1.2 (ตารางเวอร์ชัน)  →  1.3 (quest)
                                    ↓
                          2.1 (skill)  ·  2.3 (workshop kit)
                                    ↓
                              2.2 (ภาษาไทย upstream)
```

---

## หมายเหตุความเชื่อถือได้

- ทุกลิงก์ในแคตตาล็อกยิง HTTP เช็คแล้ว 2026-08-04 — ตาย 0
- ข้อสังเกต #1–#5 มาจากข้อมูลที่เจอตอนรวบรวมจริง ไม่ใช่ความเห็น
- Tier 3 ทั้งหมดเป็นสมมติฐานที่ยังไม่ได้ตรวจ — ถูกจัดแยกไว้ด้วยเหตุผลนั้น
- ตัวเลข ecosystem (stake ของ Firedancer ~14%, Colosseum fund) มาจากบทความช่วงกลางปี 2026 ควรเช็คซ้ำก่อนเอาไปอ้างในที่สาธารณะ

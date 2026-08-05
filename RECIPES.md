# สูตร — โจทย์นี้หยิบอะไรมาต่อกัน

> generate จาก [data/recipes.yml](data/recipes.yml) — **อย่าแก้ตรงนี้**
> แก้ YAML แล้วรัน `./scripts/render-recipes.sh`

**6 สูตร** · อัปเดต 2026-08-05

[CATALOG.md](CATALOG.md) บอกว่ามีอะไรบ้าง ไฟล์นี้บอกว่า **โจทย์นี้ต้องหยิบอันไหนมาต่อกัน**
ซึ่งเป็นความรู้ที่ปกติอยู่ในหัวคนที่เคยทำแล้วหายไปพร้อมกับคนนั้น

**ส่วนที่ทำให้สูตรมีค่าคือ `ข้อจำกัด` ไม่ใช่ขั้นตอน** — ทางแก้ที่ดีที่สุดในสุญญากาศ
มักใช้ไม่ได้กับของจริงเพราะติดข้อจำกัดที่ไม่มีใครเขียนไว้ สูตรที่ไม่ระบุข้อจำกัด
ก็คือ tutorial ธรรมดา ซึ่งมีเยอะแล้วบนเน็ต

## สารบัญ

- 🧪 [จัดเวิร์กช็อป 40 คน แต่ไม่มีใครมี SOL และขอ airdrop พร้อมกันแล้ว devnet เตะทิ้ง](#workshop-no-sol)
- 🧪 [เจอ tutorial บนเน็ต จะรู้ได้ยังไงว่ายังรันผ่านกับของปี 2026](#is-this-tutorial-still-valid)
- 🧪 [อยากรับเงินจริงหน้างาน เช่นขายของหรือเก็บค่าเข้า โดยไม่ต้องเขียนโปรแกรมบนเชน](#accept-payment-at-event)
- 🧪 [จ่ายรางวัล quest ให้คนในชุมชนหลายสิบคนพร้อมกัน โดยไม่ต้องกดทีละคน](#pay-many-quest-rewards)
- 🧪 [อยากทำสรุปสถานะเครือข่ายภาษาไทยรายสัปดาห์ แต่ไม่มีเวลานั่งไล่อ่านทุกแหล่ง](#weekly-network-brief-th)
- 🧪 [เขียนโปรแกรมเสร็จแล้ว จะขึ้น mainnet ต้องเตรียมอะไรบ้าง](#ship-program-to-mainnet)

✅ เคยทำจริงแล้ว · 🧪 ประกอบจากของที่ตรวจแล้ว แต่ยังไม่เคยรันทั้งชุด

---

<a id="workshop-no-sol"></a>

## จัดเวิร์กช็อป 40 คน แต่ไม่มีใครมี SOL และขอ airdrop พร้อมกันแล้ว devnet เตะทิ้ง

`🧪 ยังไม่เคยรันทั้งชุด` · ยืนยันล่าสุด 2026-08-05

**ข้อจำกัดที่ทำให้ทางแก้ทั่วไปใช้ไม่ได้**

- ผู้เข้าร่วมส่วนใหญ่ไม่เคยมีกระเป๋ามาก่อน ไม่มีทั้ง SOL และ USDC
- เน็ตในงานอีเวนต์ช้าและหลุดบ่อย พึ่ง devnet ไม่ได้
- มีเวลาสอนจริงไม่เกิน 2 ชั่วโมงรวมติดตั้ง

**หยิบอะไรมาใช้**

- [Surfpool Repository](https://github.com/solana-foundation/surfpool)
- [LiteSVM](https://github.com/litesvm/litesvm)
- [Kora (gasless/relayer)](https://solana.com/docs/tools/kora)
- [Fee Abstraction — ให้คนอื่นจ่ายค่าแก๊สแทน](https://solana.com/docs/payments/send-payments/payment-processing/fee-abstraction)
- [Quickstart — รับเงินก้อนแรกใน 5 นาที](https://solana.com/docs/payments/quickstart)

**ประกอบยังไง** — แยกสองสาย — สายที่เขียนโปรแกรมบนเชนใช้ LiteSVM หรือ Surfpool รันในเครื่อง ไม่ต้องต่อเน็ตเลยหลังติดตั้งเสร็จ ส่วนสายที่จะเห็นของจริงบน mainnet ใช้ Kora เป็นคนออกค่าแก๊สแทน ผู้เข้าร่วมจึงทำธุรกรรมได้โดยไม่ต้องมี SOL เปิดคาบด้วย quickstart ที่วางปุ่มรับเงินได้ใน 5 นาที เพื่อให้เห็นผลก่อนเจอ Rust

**จุดที่จะพลาด** — Surfpool ต้อง fork mainnet ซึ่งใช้เน็ตตอนเริ่ม ให้ทำก่อนงานแล้วแจกภาพ container ไป · Kora ต้องมีคนรัน relayer และเติมเงินไว้ ไม่ใช่บริการฟรีสาธารณะ ต้องเตรียมล่วงหน้า · rent ที่ Agave 4.2 ลด 90% ทำให้การออกค่าเปิด token account ให้ผู้เข้าร่วมถูกลงมาก แต่ยังไม่ฟรี ต้องคำนวณจำนวนหัวคูณค่าเปิดบัญชีก่อน

---

<a id="is-this-tutorial-still-valid"></a>

## เจอ tutorial บนเน็ต จะรู้ได้ยังไงว่ายังรันผ่านกับของปี 2026

`🧪 ยังไม่เคยรันทั้งชุด` · ยืนยันล่าสุด 2026-08-05

**ข้อจำกัดที่ทำให้ทางแก้ทั่วไปใช้ไม่ได้**

- tutorial ส่วนใหญ่ไม่เขียนเวอร์ชันไว้ หรือเขียนไว้แต่ไม่ตรงกับที่ใช้จริง
- ลงมือรันตามทั้งบทเพื่อพิสูจน์ว่าพังใช้เวลานานเกินไป
- เครื่องติดตั้ง Anchor ได้ทีละสายเท่านั้น

**หยิบอะไรมาใช้**

- [Compatibility Matrix (ของ Foundation)](https://github.com/solana-foundation/solana-dev-skill/blob/main/skills/solana-dev/references/compatibility-matrix.md)
- [Anchor Version Manager (AVM)](https://www.anchor-lang.com/docs/avm)
- [Anchor v0.32 → v1 Migration Guide](https://github.com/solana-foundation/solana-dev-skill/blob/main/skills/solana-dev/references/anchor/migrating-v0.32-to-v1.md)
- [web3.js v1 → v3 Migration Guide](https://github.com/solana-foundation/solana-web3.js/blob/v3.x/docs/web3js-v1-to-v3-migration.md)
- [Sunrising web3.js — ทำไม TS ecosystem ถึงกลับมารวมกัน](https://blueshift.gg/research/sunrising-web3js-reuniting-solanas-typescript-ecosystem)

**ประกอบยังไง** — ดูสัญญาณเร็วสามอย่างก่อนลงแรง — import ที่เขียนว่า @coral-xyz/anchor แปลว่าก่อน 1.0 (ชื่อเปลี่ยนเป็น @anchor-lang/core แล้ว) · เห็น new Connection กับ PublicKey แปลว่า web3.js v1 · เห็น solana-test-validator แปลว่าเขียนก่อนยุค LiteSVM เจอสัญญาณไหนก็เปิด compatibility matrix ของ Foundation เทียบ แล้วใช้ AVM สลับสาย Anchor ไปตรงกับที่ tutorial เขียนเพื่อพิสูจน์ แทนที่จะอัปของตัวเองทิ้ง

**จุดที่จะพลาด** — อย่าอัป anchor-cli จาก 1.0.2 ขึ้นเพื่อ "ให้ทันสมัย" เพราะจะทดสอบสาย 1.0 ไม่ได้อีก · matrix ของ Foundation ครอบฝั่ง Anchor/CLI/GLIBC แต่ไม่ครอบแกน Kit กับ web3.js v3 ตรงนั้นต้องดู migration guide สองตัวแทน

---

<a id="accept-payment-at-event"></a>

## อยากรับเงินจริงหน้างาน เช่นขายของหรือเก็บค่าเข้า โดยไม่ต้องเขียนโปรแกรมบนเชน

`🧪 ยังไม่เคยรันทั้งชุด` · ยืนยันล่าสุด 2026-08-05

**ข้อจำกัดที่ทำให้ทางแก้ทั่วไปใช้ไม่ได้**

- ไม่มีทีมพัฒนา ต้องขึ้นได้ภายในวันสองวัน
- ต้องกระทบยอดกับรายการขายจริงได้ ไม่ใช่แค่เห็นว่าเงินเข้า
- ผิดพลาดแล้วเป็นเงินจริง ไม่มีปุ่ม undo

**หยิบอะไรมาใช้**

- [Quickstart — รับเงินก้อนแรกใน 5 นาที](https://solana.com/docs/payments/quickstart)
- [Payment Button (React component สำเร็จรูป)](https://solana.com/docs/payments/accept-payments/payment-button)
- [Verification Tools — ตรวจว่าเงินเข้าจริงและกระทบยอด](https://solana.com/docs/payments/accept-payments/verification-tools)
- [Production Readiness — เช็คลิสต์ก่อนขึ้น mainnet](https://solana.com/docs/payments/production-readiness)

**ประกอบยังไง** — เริ่มที่ quickstart ให้มีปุ่มที่รับเงินได้จริงก่อน แล้วค่อยอ่าน payment-button เพื่อปรับโหมดและ callback ให้ตรงกับหน้าร้าน · ส่วนที่ tutorial ทั่วไปข้ามคือ verification-tools ที่สอนกระทบยอดด้วย memo ซึ่งเป็นสิ่งที่ทำให้ปิดบัญชีตอนจบงานได้ · ก่อนเปิดรับเงินจริงให้ไล่เช็คลิสต์ production-readiness 14 ข้อทั้งหมด

**จุดที่จะพลาด** — Commerce Kit ยังเป็น beta เอกสารเตือนเองว่า API เปลี่ยนได้ อย่าเพิ่งสอนว่าเป็นมาตรฐาน · ข้อที่พลาดกันบ่อยที่สุดในเช็คลิสต์คือระดับ commitment — เลือกผิดแล้วนับว่าเงินเข้า ทั้งที่ยังไม่ final และข้อยืนยัน mint ว่าไม่ใช่ของ devnet

---

<a id="pay-many-quest-rewards"></a>

## จ่ายรางวัล quest ให้คนในชุมชนหลายสิบคนพร้อมกัน โดยไม่ต้องกดทีละคน

`🧪 ยังไม่เคยรันทั้งชุด` · ยืนยันล่าสุด 2026-08-05

**ข้อจำกัดที่ทำให้ทางแก้ทั่วไปใช้ไม่ได้**

- ผู้รับบางคนยังไม่มี token account ต้องมีคนออกค่าเปิดให้
- งบมาจาก treasury ที่ต้องมีคนอนุมัติมากกว่าหนึ่งคน
- ต้องตรวจสอบย้อนหลังได้ว่าใครได้เท่าไหร่

**หยิบอะไรมาใช้**

- [Batch Payments — จ่ายหลายคนใน tx เดียว](https://solana.com/docs/payments/send-payments/payment-processing/batch-payments)
- [Spend Permissions — มอบสิทธิ์ใช้เงินแบบมีเพดาน](https://solana.com/docs/payments/advanced-payments/spend-permissions)
- [Verification Tools — ตรวจว่าเงินเข้าจริงและกระทบยอด](https://solana.com/docs/payments/accept-payments/verification-tools)
- [Squads Protocol](https://squads.so/)

**ประกอบยังไง** — ยัดหลาย instruction ใน transaction เดียวตาม batch-payments แล้วใช้ transaction planning เมื่อจำนวนเกินขนาด tx · ฝั่งอนุมัติใช้ Squads เป็น multisig ของ treasury · ถ้าอยากให้ระบบดึงเงินเองตามรอบแทนการกดจ่าย ให้ดู spend-permissions ซึ่งกำหนด เพดานได้และเจ้าของเพิกถอนเองได้ทันที ต่างจากการโอนเข้ากระเป๋ากลาง

**จุดที่จะพลาด** — Agave 4.2 ขยาย tx เป็น 4,096 byte ตั้งแต่ 17 ส.ค. 2026 ซึ่งเพิ่มจำนวนผู้รับต่อ tx ได้ แต่ต้อง opt-in เอง ของเดิมยังคิดที่ 1,232 byte · ตรวจ address ผู้รับก่อนส่งเสมอว่า เป็นกระเป๋าไม่ใช่ token account หรือ mint ซึ่งเป็นสาเหตุอันดับหนึ่งของเงินหาย

---

<a id="weekly-network-brief-th"></a>

## อยากทำสรุปสถานะเครือข่ายภาษาไทยรายสัปดาห์ แต่ไม่มีเวลานั่งไล่อ่านทุกแหล่ง

`🧪 ยังไม่เคยรันทั้งชุด` · ยืนยันล่าสุด 2026-08-05

**ข้อจำกัดที่ทำให้ทางแก้ทั่วไปใช้ไม่ได้**

- มีเวลาไม่เกิน 20 นาทีต่อสัปดาห์
- ตัวเลขต้องอ้างได้ ถ้าโดนถามต้องชี้แหล่งได้ทันที
- ไม่อยากพึ่งแหล่งที่อาจหายไป

**หยิบอะไรมาใช้**

- [Solana State (รายงานสถานะเครือข่ายอัตโนมัติ)](https://solana-state.vercel.app/)
- [Solana Network Data (first-party)](https://solana.com/data)
- [Solana Network Upgrades (hub)](https://solana.com/upgrades)
- [SGP — Solana Governance Proposals (repo)](https://github.com/solana-foundation/solana-governance-proposals)
- [solana.com llms.txt (ดัชนีเอกสารสำหรับ AI)](https://solana.com/llms.txt)

**ประกอบยังไง** — ดึงวัตถุดิบด้วยเครื่อง — solana-state มี /api/report/markdown ที่เป็นสรุปสำเร็จรูป ราว 4.6 KB รีเฟรชทุก 30 นาที · เทียบตัวเลขที่จะเอาไปอ้างกับ solana.com/data ซึ่งเป็นทางการแต่ lag 1 วัน · ฝั่ง governance ดึง SGP repo ที่เป็น markdown ล้วน · หน้า upgrades ต้องอ่านด้วยคน ใช้ .md ไม่ได้ ส่วนที่ automate ไม่ได้คือการเลือกว่าอะไรสำคัญกับคนไทยและการเขียน ซึ่งคือคุณค่าทั้งหมด

**จุดที่จะพลาด** — อย่าเรียกสิ่งนี้ว่าบอทอัตโนมัติ มันคือระบบเตรียมวัตถุดิบให้คนเขียน 20 นาที · solana-state โฮสต์บน vercel.app ฟรี หายได้ทุกเมื่อ ตัวเลขที่จะเอาไปพูดในที่สาธารณะ ให้ยึด solana.com/data เป็นหลัก · โค้ดตัวดึงควรอยู่ repo devrel-helper ไม่ใช่ที่นี่

---

<a id="ship-program-to-mainnet"></a>

## เขียนโปรแกรมเสร็จแล้ว จะขึ้น mainnet ต้องเตรียมอะไรบ้าง

`🧪 ยังไม่เคยรันทั้งชุด` · ยืนยันล่าสุด 2026-08-05

**ข้อจำกัดที่ทำให้ทางแก้ทั่วไปใช้ไม่ได้**

- ไม่มีงบจ้าง audit เต็มรูปแบบ
- ทีมมีคนเดียวหรือสองคน ไม่มีใครรีวิวโค้ดให้
- พลาดแล้วเป็นเงินคนอื่น

**หยิบอะไรมาใช้**

- [Production Readiness — เช็คลิสต์ก่อนขึ้น mainnet](https://solana.com/docs/payments/production-readiness)
- [Blueshift — Program Security Course](https://learn.blueshift.gg/en/courses/program-security)
- [Neodyme Blog](https://neodyme.io/en/blog/)
- [Squads Protocol](https://squads.so/)
- [subscriptions (delegation / จ่ายรายรอบ on-chain)](https://github.com/solana-foundation/subscriptions)

**ประกอบยังไง** — ไล่เช็คลิสต์ production-readiness 14 ข้อก่อน ซึ่งครอบชั้น client และ RPC · แต่มันไม่ครอบชั้นโปรแกรม ส่วนนั้นใช้คอร์ส program security ของ Blueshift ไล่เรื่องตรวจเจ้าของ account การคุมสิทธิ์ และ CPI แล้วอ่านเคสจริงจากบล็อก Neodyme · upgrade authority ต้องอยู่ใต้ multisig ของ Squads ไม่ใช่กุญแจเดียวในเครื่องใครคนหนึ่ง · อยากดูว่าโปรแกรมที่ผ่าน audit จริงหน้าตายังไง อ่าน subscriptions ที่เปิดโค้ดครบ

**จุดที่จะพลาด** — เช็คลิสต์ทางการ 14 ข้อผ่านหมดแล้วยังขึ้น mainnet ไม่ได้ ถ้ายังไม่มี audit multisig upgrade authority และ verified build — สามอย่างนี้ไม่มีอยู่ในเช็คลิสต์นั้นเลย เพราะมันเขียนสำหรับคนที่ใช้โปรแกรมของคนอื่น ไม่ใช่คนที่เขียนเอง

---

ทุก URL ใน `หยิบอะไรมาใช้` ต้องมีอยู่จริงใน [data/resources.yml](data/resources.yml)
— `recipe-check.sh` บังคับ ทำให้สูตรอ้างของที่ไม่เคยตรวจไม่ได้

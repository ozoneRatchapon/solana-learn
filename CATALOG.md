# Solana Resource Catalog

> ไฟล์นี้ถูก generate จาก [data/resources.yml](data/resources.yml) — **อย่าแก้ตรงนี้**
> แก้ที่ YAML แล้วรัน `./scripts/render.sh`

รวม **174** รายการ · อัปเดต 2026-08-04

หมายเหตุสถานะ: `blocked` = เว็บกัน bot ตอน curl (ลิงก์ยังใช้ได้), `unverified` = เช็คอัตโนมัติไม่ผ่าน ต้องดูด้วยตา

## สารบัญ

- [Official — Foundation & Anza (source of truth ตัวจริง)](#official--foundation--anza-source-of-truth-ตัวจริง) — 18
- [Learning — คอร์ส, bootcamp, tutorial](#learning--คอร์ส-bootcamp-tutorial) — 13
- [Program Frameworks — Anchor / Pinocchio / native](#program-frameworks--anchor--pinocchio--native) — 12
- [Client SDK — Kit, web3.js, scaffolding](#client-sdk--kit-web3js-scaffolding) — 10
- [Testing — LiteSVM, Mollusk, Surfpool](#testing--litesvm-mollusk-surfpool) — 5
- [IDL & Codegen](#idl--codegen) — 4
- [Tokens & NFT — SPL, Token-2022, Metaplex](#tokens--nft--spl-token-2022-metaplex) — 5
- [Payments & Commerce](#payments--commerce) — 20
- [Security & Audit](#security--audit) — 5
- [AI / Agent Skills / MCP](#ai--agent-skills--mcp) — 15
- [Infra & RPC providers](#infra--rpc-providers) — 10
- [Data & Analytics](#data--analytics) — 13
- [DeFi & Ecosystem protocols](#defi--ecosystem-protocols) — 12
- [Mobile](#mobile) — 2
- [Protocol internals — Agave, Firedancer, network upgrades](#protocol-internals--agave-firedancer-network-upgrades) — 7
- [Governance — SGP, SIMD, โหวตบนเชน](#governance--sgp-simd-โหวตบนเชน) — 8
- [Funding — grants, hackathon, bounty, jobs](#funding--grants-hackathon-bounty-jobs) — 12
- [Thailand — ชุมชนไทย](#thailand--ชุมชนไทย) — 3

## Official — Foundation & Anza (source of truth ตัวจริง)

- [Solana Documentation](https://solana.com/docs) `official`
  จุดเริ่มต้นทุกอย่าง ปี 2026 rebuild ใหม่ code sample ผ่าน CI ทุกตัว
  <sub>docs, core, rpc, canonical</sub>
- [Solana Developers Portal](https://solana.com/developers) `official`
  หน้ารวม guides / cookbook / courses / bootcamp / templates
  <sub>hub, index</sub>
- [Solana Developer Guides](https://solana.com/developers/guides) `official`
  <sub>guides, howto</sub>
- [Solana Cookbook (official)](https://solana.com/developers/cookbook) `official`
  recipe สั้นๆ ต่อ task — ต่างจาก solanacookbook.com ของเดิมที่เป็น community
  <sub>snippets, recipes</sub>
- [Solana RPC API Reference](https://solana.com/docs/rpc) `official`
  <sub>rpc, api, reference</sub>
- [Solana Tools & Infrastructure Docs](https://solana.com/docs/tools) `official`
  <sub>tooling</sub>
- [Solana Developer Platform (SDP)](https://platform.solana.com) `official`
  platform API-first สำหรับ enterprise/สถาบันการเงิน ออกปี 2026 — ของใหม่ ยังมีคนใช้น้อย
  <sub>api, enterprise, fintech, new-2026</sub>
- [Solana Developer Platform Docs](https://platform.solana.com/docs) `official`
  <sub>api, docs</sub>
- [Solana Media / Changelog](https://solana.com/news) `official`
  Solana Changelog ออกทุก ~2 สัปดาห์ ใช้ track ว่าอะไรเปลี่ยน
  <sub>news, changelog</sub>
- [Solana Foundation GitHub](https://github.com/solana-foundation) `official`
  <sub>github, org</sub>
- [developer-content (repo ของ docs ทั้งหมด)](https://github.com/solana-foundation/developer-content) `official`
  ARCHIVED — ตรวจ 4 ส.ค. 2026 ด้วย gh api ได้ archived=true, push ล่าสุด 24 ม.ค. 2025 เปิด PR ไม่ได้แล้ว เนื้อหาย้ายไปอยู่ solana-com เก็บไว้อ้างอิงประวัติเท่านั้น (โน้ตเดิมเขียนว่าเป็นช่องทาง contribute ซึ่งผิด)
  <sub>github, docs, contributable</sub>
- [solana-com (เว็บ solana.com)](https://github.com/solana-foundation/solana-com) `official`
  มี i18n อยู่ในนี้ — จุดเข้าถ้าจะดันภาษาไทย
  <sub>github, website, i18n</sub>
- [Validated (podcast)](https://solana.com/validated) `official`
  <sub>podcast</sub>
- [solana-developer-platform (SDP repo)](https://github.com/solana-foundation/solana-developer-platform) `official`
  โค้ดหลังบ้านของ platform.solana.com — monorepo Node 22/TS/Postgres/Redis มี sdp-api (Cloud Run + OpenAPI), dashboard, docs; ตัวโปรเจกต์ประกาศเองว่ายัง pre-mainnet ยังไม่ผ่าน audit ห้ามเอาไปใช้กับเงินจริง และ self-host ยังทำไม่เสร็จ — ค่าที่แท้จริงตอนนี้คือใช้อ่านว่า Foundation ออกแบบ wallet/token issuance/compliance ฝั่ง enterprise ยังไง
  <sub>github, sdp, enterprise, typescript, monorepo</sub>
- [Solana Foundation — repo ทั้งหมด (99 repo)](https://github.com/orgs/solana-foundation/repositories) `official`
  ต่างจากหน้า org ธรรมดาตรงเห็นครบทุก repo และเรียง/กรองได้ (?type=all&sort=updated) ใช้ตอนอยากรู้ว่า Foundation กำลังทำอะไรอยู่จริง ไม่ใช่แค่ที่ pin ไว้ — ของที่โผล่จากการไล่หน้านี้เช่น subscriptions, solana-keychain, rpc-latency-monitor, github-workflows ไม่มีใน curated list ที่ไหนเลย; ไล่บ่อยๆ ยิง API เร็วกว่า: curl -s "https://api.github.com/orgs/solana-foundation/repos?sort=pushed&per_page=30" | jq -r ".[] | \"\(.name) ★\(.stargazers_count) \(.pushed_at[0:10]) \(.description)\""
  <sub>github, index, browse, audit</sub>
- [Anza — repo ทั้งหมด (60 repo)](https://github.com/orgs/anza-xyz/repositories) `anza`
  ฝั่ง Anza เป็นคนทำ core: agave (validator), kit (JS SDK ที่มาแทน web3.js), solana-sdk (Rust), pinocchio, mollusk, jetstreamer (indexing 2.7M TPS+), llvm-project fork; เข้าหน้านี้เวลาจะเช็คว่าเครื่องมือ core ตัวไหนยังมีคนแตะอยู่ — ดูวันที่ push สำคัญกว่าดาว เพราะหลายตัวดาวน้อยแต่เป็นของจริงที่ใช้ใน production
  <sub>github, index, browse, agave, kit</sub>
- [Solana Policy Institute](https://www.solanapolicyinstitute.org/)
  องค์กรไม่แสวงกำไร ไม่ฝักใฝ่พรรค ทำหน้าที่อธิบายเครือข่ายกระจายศูนย์ให้ผู้ออกกฎหมายเข้าใจ — ทำงาน 6 เรื่อง: stablecoin, Project Open, การคุ้มครองนักพัฒนา, การเปิดให้คนทั่วไปเข้าถึงการลงทุน, ความชัดเจนเรื่องภาษีจาก staking/mining และกฎหมายโครงสร้างตลาด; มีคลังเอกสารกฎหมาย (amicus brief, จดหมายร่วม) และห้องข่าวที่ตาม CLARITY Act อยู่; ค่าที่แท้จริงสำหรับงานไทยคือใช้เป็นแม่แบบว่าเวลาคุยกับหน่วยงานกำกับควรวางกรอบเรื่องยังไง โดยเฉพาะประเด็นการคุ้มครองนักพัฒนา (เขียนโค้ดโอเพนซอร์สไม่ควรถูกตีความเป็นตัวกลาง) ที่ตรงกับความกังวลของ dev ไทย; ระวัง เป็นมุมนโยบายสหรัฐ เอามาใช้ตรงๆ กับกฎไทยไม่ได้ และเว็บไม่ได้ระบุความสัมพันธ์กับ Solana Foundation ชัดเจน
  <sub>policy, regulation, nonprofit, advocacy, legal</sub>
- [Global Developer Event Calendar — ฟอร์มส่งอีเวนต์เข้าปฏิทินโลก](https://docs.google.com/forms/d/e/1FAIpQLSfTosHwpQg2Uvf7tgySMSIEzyJGxaRaNNSL9HhTl_GgNFQvWg/viewform) `official`
  ฟอร์มส่งอีเวนต์เข้าปฏิทินนักพัฒนาระดับโลกของ Foundation (ท้ายฟอร์มยืนยันว่าสร้างภายใน solana.foundation) — กรอกไม่กี่ช่อง: ชื่องาน วันที่ สถานที่ เว็บไซต์ (4 ช่องนี้บังคับ) แล้วเลือกโฟกัส (Solana/คริปโต/เทคคอนเฟอเรนซ์/แฮกกาธอน/AI/ความปลอดภัย) กับรูปแบบ (ออนไลน์/ในสถานที่/ผสม) พร้อมสรุปงานและอีเมลติดต่อ; นี่คือช่องกระจายงานที่ต้นทุนเกือบศูนย์สำหรับงาน Genesis และ Superteam TH — ไม่ต้องรออนุมัติจากใคร ไม่ต้องมีคอนเนกชัน แค่กรอก ต่างจากช่องทางอื่นในลิสต์นี้ที่ต้องมีของก่อนถึงจะเข้าไปได้; ไม่ระบุเดดไลน์ เป็นฟอร์มเปิดรับต่อเนื่อง แต่เป็น Google Form ที่ปิดเมื่อไหร่ก็ได้ ควรเช็คก่อนวางแผนพึ่งพา
  <sub>events, submission, devrel, calendar, distribution</sub>

## Learning — คอร์ส, bootcamp, tutorial

- [Solana Courses](https://solana.com/developers/courses) `official`
  <sub>course, structured</sub>
- [Solana Developer Bootcamp](https://solana.com/developers/bootcamp) `official`
  foundations → program patterns → fullstack → production
  <sub>bootcamp, video</sub>
- [solana-bootcamp-2026](https://github.com/solana-foundation/solana-bootcamp-2026) `official`
  <sub>github, bootcamp, curriculum</sub>
- [Blueshift](https://learn.blueshift.gg/)
  Foundation แนะนำเอง — คอร์สฟรี open-source มี challenge ให้ทำจริง
  <sub>course, free, anchor, rust, typescript, challenges</sub>
- [Blueshift GitHub](https://github.com/blueshift-gg)
  <sub>github, course-content</sub>
- [Blueshift Research](https://blueshift.gg/research/)
  เขียนเรื่อง sunrising web3.js / ทิศทาง TS ecosystem ได้ดี
  <sub>research, ecosystem</sub>
- [Solana Cookbook (community, รุ่นเก่า)](https://solanacookbook.com/)
  ยังมีของดี แต่หลายตัวอย่างเป็น web3.js v1 — เช็ควันที่ก่อนใช้
  <sub>snippets, legacy</sub>
- [Turbin3](https://turbin3.org/)
  cohort เข้มข้น มี live code review + mentor 2,000+ dev ผ่านมาแล้ว
  <sub>cohort, intensive, rust, anchor</sub>
- [Turbin3 Institute (free training)](https://turbin3.org/institute)
  <sub>free, training</sub>
- [Rise In — Solana Bootcamp](https://www.risein.com/programs/solana-bootcamp)
  <sub>bootcamp</sub>
- [RareSkills — Ethereum to Solana](https://www.rareskills.io/solana-tutorial)
  ดีมากถ้ากลุ่มเป้าหมายเป็น dev สาย EVM
  <sub>evm-migration, tutorial</sub>
- [HackQuest — Solana learning track](https://www.hackquest.io/)
  <sub>interactive</sub>
- [Ackee — School of Solana](https://ackee.xyz/school-of-solana)
  <sub>course, certificate</sub>

## Program Frameworks — Anchor / Pinocchio / native

- [solana-developers/program-examples](https://github.com/solana-developers/program-examples) `official`
  ตัวอย่าง program แยกตาม pattern — วัตถุดิบชั้นดีสำหรับทำ quest
  <sub>examples, anchor, native</sub>
- [QuickNode — solana-program-examples](https://github.com/quicknode/solana-program-examples) `vendor`
  <sub>examples, tested</sub>
- [Anchor Documentation](https://www.anchor-lang.com/) `official`
  ปัจจุบัน Anchor 1.0 แล้ว (เครื่องคุณ = anchor-cli 1.0.2)
  <sub>anchor, docs, canonical</sub>
- [Anchor Repository](https://github.com/solana-foundation/anchor) `official`
  URL นี้ 301 ไป github.com/otter-sec/anchor แล้ว (crates.io ของ anchor-lang ก็ชี้ otter-sec) แต่ anchor-lang.com ยังลิงก์ solana-foundation อยู่ — คงไว้แบบนี้เพราะ 301 ยังพาไปถึง แต่ต้องรู้ว่าคนดูแลจริงเปลี่ยนแล้ว
  <sub>anchor, github</sub>
- [Anchor Version Manager (AVM)](https://www.anchor-lang.com/docs/avm) `official`
  <sub>anchor, versioning</sub>
- [Anchor v0.32 → v1 Migration Guide](https://github.com/solana-foundation/solana-dev-skill/blob/main/skills/solana-dev/references/anchor/migrating-v0.32-to-v1.md) `official`
  สำคัญมาก — tutorial เก่าเกือบทั้งหมดยังเป็น 0.3x
  <sub>anchor, migration, breaking-change</sub>
- [Pinocchio](https://github.com/anza-xyz/pinocchio) `anza`
  zero-dependency zero-copy ลด CU ได้ 88–95% เทียบ Anchor
  <sub>pinocchio, zero-copy, performance</sub>
- [Pinocchio Guide](https://github.com/vict0rcarvalh0/pinocchio-guide)
  <sub>pinocchio, tutorial</sub>
- [Helius — How to Build with Pinocchio](https://www.helius.dev/blog/pinocchio) `vendor`
  <sub>pinocchio, article</sub>
- [Solana Optimized Programs](https://github.com/Laugharne/solana_optimized_programs)
  <sub>optimization, cu</sub>
- [sBPF Assembly SDK](https://github.com/blueshift-gg/sbpf)
  <sub>sbpf, assembly, advanced</sub>
- [Compatibility Matrix (ของ Foundation)](https://github.com/solana-foundation/solana-dev-skill/blob/main/skills/solana-dev/references/compatibility-matrix.md) `official`
  ตารางความเข้ากันได้ทางการ 15 KB ครอบ Anchor 0.29 ถึง 1.1.x, Solana CLI 1.16-4.1, Platform Tools, GLIBC รายดิสโทร, และเวอร์ชัน litesvm ฝั่ง Rust/node — น่าอายที่ repo นี้เพิ่งเพิ่มวันนี้ทั้งที่เป็นวัตถุดิบหลักของงานตารางเวอร์ชันที่ตั้งเป็นเป้าไว้เอง; สิ่งที่ตารางนี้ไม่มีและเป็นช่องที่เหลือให้ทำจริงคือแกน @solana/kit และ web3.js v3 กับการยืนยันบน macOS (ของเขาอิง Debian)
  <sub>version, anchor, toolchain, compatibility, matrix</sub>

## Client SDK — Kit, web3.js, scaffolding

- [Solana Templates](https://solana.com/developers/templates) `official`
  <sub>scaffold, starter</sub>
- [Solana Kit Docs](https://www.solanakit.com/) `anza`
  SDK มาตรฐานปัจจุบัน — tree-shakable zero-dependency แทน web3.js v1
  <sub>kit, typescript, canonical</sub>
- [@solana/kit repository](https://github.com/anza-xyz/kit) `anza`
  <sub>kit, github</sub>
- [Kit Plugins](https://github.com/anza-xyz/kit-plugins) `anza`
  rpc, signer, wallet, litesvm, instruction-plan
  <sub>kit, plugins</sub>
- [JavaScript/TypeScript client docs (Kit + client + React hooks)](https://solana.com/docs/clients/official/javascript) `official`
  URL ที่ curated list ของ Foundation ระบุไว้ (/docs/clients/kit) ตาย 404 — อันนี้คือของจริง ครอบคลุม @solana/kit, @solana/client และ React hooks
  <sub>kit, docs, react</sub>
- [Rust client docs](https://solana.com/docs/clients/official/rust) `official`
  <sub>rust, client</sub>
- [@solana/web3.js v3.x](https://github.com/solana-foundation/solana-web3.js/tree/v3.x) `official`
  v3 = API แบบคลาสสิกแต่รันบนไส้ใน Kit — v1 อยู่ maintenance (security fix เท่านั้น)
  <sub>web3js, v3</sub>
- [web3.js v1 → v3 Migration Guide](https://github.com/solana-foundation/solana-web3.js/blob/v3.x/docs/web3js-v1-to-v3-migration.md) `official`
  <sub>migration, web3js</sub>
- [Sunrising web3.js — ทำไม TS ecosystem ถึงกลับมารวมกัน](https://blueshift.gg/research/sunrising-web3js-reuniting-solanas-typescript-ecosystem)
  อ่านตัวนี้ก่อนตัดสินใจว่าโปรเจกต์จะใช้ Kit หรือ web3.js v3
  <sub>context, article</sub>
- [create-solana-dapp](https://github.com/solana-developers/create-solana-dapp) `official`
  <sub>scaffold, cli</sub>

## Testing — LiteSVM, Mollusk, Surfpool

- [Surfpool Docs](https://solana.com/docs/tools/surfpool/) `official`
  fork mainnet ได้ + cheatcode — เหมาะกับ workshop ที่ไม่อยากรอ airdrop
  <sub>surfpool, mainnet-fork, cheatcodes</sub>
- [Surfpool Repository](https://github.com/solana-foundation/surfpool) `official`
  <sub>surfpool, github</sub>
- [LiteSVM](https://github.com/LiteSVM/litesvm)
  เร็วกว่า solana-test-validator หลายเท่า มีทั้ง crate และ npm
  <sub>litesvm, fast-test</sub>
- [LiteSVM Docs](https://solana.com/docs/tools/litesvm) `official`
  <sub>litesvm, docs</sub>
- [Mollusk](https://github.com/anza-xyz/mollusk) `anza`
  ทดสอบระดับ instruction + วัด CU ได้
  <sub>mollusk, unit-test, cu-benchmark</sub>

## IDL & Codegen

- [Codama](https://github.com/codama-idl/codama)
  gen client จาก IDL — มาตรฐานปัจจุบันของสาย Kit
  <sub>idl, codegen, canonical</sub>
- [Codama — Generating Clients (docs)](https://solana.com/docs/programs/codama/clients) `official`
  URL ที่ curated list ของ Foundation ระบุไว้ (/docs/programs/codama-generating-clients) ตาย 404 — อันนี้คือของจริง
  <sub>idl, codegen</sub>
- [IDLs — Interface Definition Language (guide)](https://solana.com/developers/guides/advanced/idls) `official`
  <sub>idl, concept</sub>
- [Shank (Metaplex)](https://github.com/metaplex-foundation/shank)
  ดึง IDL จาก native program ที่ไม่ได้ใช้ Anchor
  <sub>idl, native-program</sub>

## Tokens & NFT — SPL, Token-2022, Metaplex

- [SPL Token Documentation](https://spl.solana.com/token) `official`
  <sub>spl, token</sub>
- [Token-2022 Documentation](https://spl.solana.com/token-2022) `official`
  <sub>token-2022, extensions</sub>
- [Tokenized Assets (docs)](https://solana.com/docs/tokenization) `official`
  <sub>rwa, tokenization</sub>
- [Token-2022 Launch Quickstart](https://solana.com/docs/tokenization/quickstart) `official`
  <sub>token-2022, quickstart</sub>
- [Metaplex Developer Docs](https://developers.metaplex.com/)
  <sub>nft, core, bubblegum, candy-machine, umi</sub>

## Payments & Commerce

- [Solana Pay](https://docs.solanapay.com/) `official`
  <sub>payment, qr</sub>
- [Payments docs](https://solana.com/docs/payments) `official`
  <sub>payment, checkout</sub>
- [Kora (gasless/relayer)](https://solana.com/docs/tools/kora) `official` `unverified`
  relayer ที่ทำให้ผู้ใช้ทำธุรกรรมได้โดยไม่ต้องมี SOL — อ่านคู่กับ fee-abstraction และ x402-facilitator ในหมวดเดียวกัน; แก้ URL 4 ส.ค. 2026: ของเดิมชี้ docs.kora.network ซึ่งตายแล้ว (TLS ล้ม) และโดเมน kora.network กลายเป็น parked domain ประกาศขาย — apex ตอบ 200 แต่เนื้อแค่ 114 byte redirect ไป GoDaddy อย่าเผลอใช้เป็นตัวสำรอง
  <sub>gasless, relayer, fee-payer, onboarding</sub>
- [Solana × WSOP (case study การใช้งานจริง)](https://solana.com/wsop) `official`
  Solana เป็น presenting sponsor ของ WSOP 2026 — ของจริงที่ใช้อ้างได้คือ buy-in ทัวร์นาเมนต์ผ่านแอป WSOP LIVE ด้วย SOL/USDC/USDT ยืนยันทันที ไม่มีค่าธรรมเนียมประมวลผล เป็นเคส consumer payments ระดับแบรนด์ mainstream ที่เล่าให้คนนอกวงคริปโตฟังรู้เรื่อง ใช้เปิดหัวตอนพูดเรื่อง payments ได้; ระวัง — เป็นหน้าแคมเปญ ไม่ใช่เอกสารเทคนิค งาน Showdown 4 ส.ค. 2026 และ Paradise ธ.ค. 2026 ผ่านไปแล้วน่าจะเน่า ให้รีวิวใหม่ต้นปี 2027
  <sub>adoption, case-study, consumer, usdc, mainstream</sub>
- [subscriptions (delegation / จ่ายรายรอบ on-chain)](https://github.com/solana-foundation/subscriptions) `official`
  โปรแกรมจ่ายเงินรายรอบบน SPL Token/Token-2022 — deploy mainnet แล้วจริง (De1egAFMkMWZSN5rYXRj9CAdheBamobVNubTsi9avR44 เช็คแล้ว executable) audit โดย Cantina หลายรอบ ล่าสุดปี 2026; กลไก: PDA 'Subscription Authority' เป็น delegate ตัวเดียวต่อคู่ user-mint แล้วให้ Delegation PDA อีกชั้นคุมว่าโอนได้เมื่อไหร่ เลยมีหลาย delegation พร้อมกันได้โดยไม่เสียความปลอดภัยแบบ approve ปกติ รองรับ fixed / recurring / subscription plan ปิดแล้วได้ rent คืน; น่าสนใจเป็นพิเศษเพราะ stack ตรงกับที่ repo นี้เชียร์ — Pinocchio + Codama + LiteSVM + client TS/Rust ใช้เป็นตัวอย่างโค้ด production ที่อ่านได้จริง
  <sub>subscription, delegation, token-2022, pinocchio, codama, litesvm, audited</sub>
- [Subscriptions Delegation Program — เอกสารทางการ](https://solana.com/docs/payments/subscriptions/overview) `official`
  คู่มือฝั่งเอกสารของโปรแกรม subscriptions (คู่กับ repo solana-foundation/subscriptions) — อธิบายรากของปัญหาชัดกว่า README: token account ของ SPL อนุมัติ delegate ได้ทีละรายเดียว เลยรองรับหลายข้อตกลงพร้อมกันไม่ได้ โปรแกรมนี้แก้ด้วย Subscription Authority ต่อคู่ (user, mint) แล้วเช็คทุกการโอนกับ record แยก; จุดที่ต้องรู้และไม่มีในหน้าอื่น — Token-2022 ที่ตั้ง TransferHook ไว้ โปรแกรมจะส่ง hook account เข้า TransferChecked CPI ให้เอง (SDK เรียก resolveTransferHookAccounts) และมี event ยิงผ่าน self-CPI ให้ indexer ตามได้ทุกธุรกรรม พร้อม versioning สำหรับ migrate account ทีหลัง; มี demo app ให้ลองเล่นด้วย
  <sub>subscription, delegation, token-2022, transfer-hook, events, docs</sub>
- [Agentic Payments / x402 (หน้าหลัก)](https://solana.com/docs/payments/agentic-payments) `official`
  จุดตั้งต้นของ x402 — ให้ AI agent จ่ายเงินเองเพื่อเรียก API/ทรัพยากร โดยรื้อ HTTP 402 Payment Required ที่ค้างมาตั้งแต่ยุคแรกของเว็บมาใช้จริง อ่านหน้านี้ก่อนแล้วค่อยไป intro-to-x402 ที่ลงมือทำ
  <sub>x402, agent, api, micropayment</sub>
- [How to get started with x402 on Solana](https://solana.com/docs/payments/agentic-payments/intro-to-x402) `official`
  ไกด์ยาว ~29 KB ระดับ beginner ที่พาสร้าง flow 402 จริง — server ตัวตรวจเงินขั้นต่ำ + client ที่จ่ายแล้วเข้าถึง endpoint ได้ มีตารางว่า SDK ตัวไหนรองรับ Solana บ้างและตัวอย่างแบบ native; ตัวนี้เอาไปทำเวิร์กช็อปได้เลยเพราะจบในไฟล์เดียว
  <sub>x402, guide, beginner, http-402, sdk</sub>
- [x402 + Kora — เดโมจ่ายค่า API แบบไม่มีค่าแก๊ส](https://solana.com/docs/payments/agentic-payments/x402-facilitator) `official`
  ต่อ x402 เข้ากับ Kora (relayer แบบ gasless) — ผู้เรียก API จ่ายเป็น token ได้โดยไม่ต้องมี SOL ในกระเป๋าเลย มีสถาปัตยกรรม + setup + โค้ดครบ; สำคัญกับบริบทไทยตรงที่ตัดปัญหา "ต้องไปหา SOL มาก่อนถึงจะเริ่มได้" ซึ่งเป็นกำแพงแรกที่คนใหม่เจอเสมอ
  <sub>x402, kora, gasless, relayer, demo</sub>
- [Indexing — เฝ้าธุรกรรมระดับ production](https://solana.com/docs/payments/accept-payments/indexing) `official`
  อธิบายว่าทำไม polling RPC ถึงไม่พอเวลามีปริมาณเยอะ และต่างกันยังไงระหว่างข้อมูลดิบกับ parsed แล้วพาไปที่ Geyser/Yellowstone gRPC พร้อมลิสต์ผู้ให้บริการ endpoint (Triton / Helius / QuickNode) — อ่านคู่กับ entry ของ Triton ในหมวด infra-rpc จะเห็นภาพครบทั้งฝั่งแนวคิดและฝั่งของจริง
  <sub>indexing, geyser, yellowstone, grpc, monitoring</sub>
- [Verification Tools — ตรวจว่าเงินเข้าจริงและกระทบยอด](https://solana.com/docs/payments/accept-payments/verification-tools) `official`
  ท่าตรวจเงินเข้าตั้งแต่เช็ค balance, เฝ้า transfer, ไล่ประวัติธุรกรรม จนถึงกระทบยอดกับ order ด้วย memo และมีหัวข้อ protections ด้วย — ชิ้นที่ร้านค้าจริงต้องใช้แต่ tutorial ส่วนใหญ่ข้ามไป (สอนแค่ส่งเงินออกแล้วจบ)
  <sub>verification, memo, reconcile, balance</sub>
- [Spend Permissions — มอบสิทธิ์ใช้เงินแบบมีเพดาน](https://solana.com/docs/payments/advanced-payments/spend-permissions) `official`
  ไกด์ ~31 KB เรื่อง delegate token: อนุมัติ/เพิกถอน/โอนในฐานะ delegate/เช็คสถานะ พร้อมหัวข้อความปลอดภัย — ของเด็ดคือตารางเทียบ delegation กับ custody เต็มรูปแบบ (ใครถือเหรียญ / เพดานความเสียหาย / เพิกถอนได้เองไหม) ใช้ตอบคำถามคลาสสิกว่า "ให้สิทธิ์แอปแล้วมันเชิดเงินหนีได้ไหม" ได้ตรงจุด
  <sub>delegation, approve, revoke, custody, security</sub>
- [Deferred Execution — เซ็นตอนนี้ ส่งทีหลัง (durable nonce)](https://solana.com/docs/payments/advanced-payments/deferred-execution) `official`
  ใช้ durable nonce เพื่อให้ transaction ที่เซ็นแล้วไม่หมดอายุตาม blockhash — รองรับ flow อนุมัติหลายชั้น งาน treasury และการเซ็นแบบออฟไลน์ มีโค้ดไล่ทีละขั้นตั้งแต่สร้าง nonce account; durable nonce เป็นเรื่องที่คนเข้าใจผิดบ่อยมากและแทบไม่มีสอนเป็นภาษาไทย
  <sub>durable-nonce, offline-signing, treasury, approval-flow</sub>
- [Fee Abstraction — ให้คนอื่นจ่ายค่าแก๊สแทน](https://solana.com/docs/payments/send-payments/payment-processing/fee-abstraction) `official`
  อธิบายกลไก fee payer แยกจากผู้ส่ง แล้วต่อยอดเป็นระดับ scale ด้วย Kora — ผู้ใช้ทำธุรกรรมได้โดยไม่ต้องมี SOL; นี่คือคำตอบของปัญหา onboarding ที่เจอทุกงานอีเวนต์ (คนมีแต่ USDC/ไม่มี SOL เลยติดตั้งแต่ก้าวแรก)
  <sub>gasless, sponsor, fee-payer, kora, onboarding</sub>
- [Batch Payments — จ่ายหลายคนใน tx เดียว](https://solana.com/docs/payments/send-payments/payment-processing/batch-payments) `official`
  ยัดหลาย instruction ใน transaction เดียวเพื่อจ่ายหลายปลายทางพร้อมกัน มีโค้ดไล่ตั้งแต่หา token account จนตรวจยอด และมีหัวข้อ transaction planning ตอนจำนวนเกินขนาด tx; ใช้ได้จริงกับงานแจกรางวัล quest / จ่ายค่าตอบแทนชุมชนเป็นรอบ
  <sub>batch, airdrop, transaction-planning, payroll</sub>
- [Production Readiness — เช็คลิสต์ก่อนขึ้น mainnet](https://solana.com/docs/payments/production-readiness) `official`
  ครอบ RPC infra, การทำให้ tx ลงบล็อกจริง, ระดับ confirmation, จัดการ error, gasless, security แล้วปิดท้ายด้วยเช็คลิสต์ 14 ข้อก่อนขึ้น mainnet (นับ checkbox จริงแล้ว) (RPC สำรอง, priority fee แบบไดนามิก, retry ตอน blockhash หมดอายุ, ยืนยัน mint ว่าไม่ใช่ของ devnet, ไม่มี key ใน frontend, load test) — เอาไปใช้เป็นแบบฟอร์มรีวิวโปรเจกต์ในชุมชนได้เลย ตัวนี้คุ้มที่สุดในหมวดนี้
  <sub>production, checklist, rpc, priority-fee, retry, security</sub>
- [Payments Developer Tools (รวมของฝั่ง vendor)](https://solana.com/docs/payments/developer-tools) `official`
  ลิสต์เครื่องมือฝั่งที่สาม แยกเป็น CLI / library&SDK / faucet devnet / infra / auth / AI tools / program dev — ใช้เป็นแหล่งหา resource ต่อ และเป็นที่มาของชื่อแพ็กเกจตระกูล @solana-commerce/* ที่โผล่ในไกด์อื่น
  <sub>index, tools, sdk, faucet, auth</sub>
- [Quickstart — รับเงินก้อนแรกใน 5 นาที](https://solana.com/docs/payments/quickstart) `official`
  สั้นมาก (~2.7 KB) ติดตั้ง @solana-commerce/kit แล้ววางปุ่มลง React ก็รับ stablecoin ได้เลย มีให้ลองในเบราว์เซอร์ก่อน — เหมาะเป็นบทเปิดเวิร์กช็อปที่สุดเพราะเห็นผลไวและไม่ต้องเขียนโปรแกรมบนเชนเลย
  <sub>quickstart, react, commerce-kit, workshop</sub>
- [Payment Button (React component สำเร็จรูป)](https://solana.com/docs/payments/accept-payments/payment-button) `official`
  รายละเอียด API ของปุ่มจาก @solana-commerce/kit — โหมดการจ่าย, config, event callback, ทำ trigger เองได้; ระวัง เอกสารเตือนเองว่า Commerce Kit ยังเป็น beta API เปลี่ยนได้ก่อนออกตัวจริง อย่าเพิ่งเอาไปสอนว่าเป็นมาตรฐาน
  <sub>react, component, commerce-kit, beta</sub>
- [pay.sh — จ่ายค่า API ต่อครั้งโดยไม่ต้องสมัคร](https://pay.sh/) `official`
  x402 ที่ขึ้นใช้งานจริงแล้ว ไม่ใช่แค่สเปคในเอกสาร — CLI ตัวเดียว (brew install pay หรือ npm i -g @solana/pay) จัดการ HTTP 402 ให้ทั้งหมด agent เรียก API ที่มีค่าใช้จ่ายได้โดยไม่ต้องสมัครสมาชิกและไม่ต้องมีบัญชีกับผู้ให้บริการแต่ละราย ทะเบียนตอนนี้มี 72 เจ้า ราคาตั้งแต่ฟรีถึง $10 ต่อครั้ง (QuickNode RPC, Nansen, Birdeye, Venice.ai, Alibaba Cloud, AgentMail) เติมเงินผ่าน PayPal/Venmo/Apple Pay หรือกระเป๋า Solana; ดูแลโดย Foundation ยืนยันจาก repo github.com/solana-foundation/pay ที่ลิงก์อยู่ในหน้า; มี /index.md และ /llms.txt ให้ agent อ่านตรงได้แบบเดียวกับ solana.com; ข้อควรรู้ — ไม่ได้จำกัดแค่ของสาย Solana เป็นเกตเวย์ไป API ทั่วไป และเอกสารเตือนเองว่าให้ถือว่าราคา/หัวข้อมูลจากผู้ให้บริการเป็นข้อมูลที่เชื่อไม่ได้ ต้องตรวจก่อนใช้
  <sub>x402, agent, cli, pay-per-call, mcp, registry</sub>

## Security & Audit

- [Ackee — Solana Auditors Bootcamp](https://github.com/Ackee-Blockchain/Solana-Auditors-Bootcamp)
  ฟรี + มี cert สาย security โดยเฉพาะ
  <sub>audit, free, certificate</sub>
- [Blueshift — Program Security Course](https://learn.blueshift.gg/en/courses/program-security)
  <sub>security, course, free</sub>
- [Solana Dev Skill — Security Checklist](https://github.com/solana-foundation/solana-dev-skill/blob/main/skills/solana-dev/references/security.md) `official`
  checklist สั้นๆ ที่ใช้รีวิว PR ได้จริง
  <sub>checklist, signer, account-validation</sub>
- [Trident Arena (AI security scan)](https://tridentarena.xyz)
  จากทีม School of Solana — scan หา logic flaw เฉพาะทาง Solana
  <sub>ai, audit, scanner</sub>
- [Neodyme Blog](https://neodyme.io/en/blog/)
  <sub>audit, writeup, exploit</sub>

## AI / Agent Skills / MCP

- [Metaplex Agent Skill (official)](https://github.com/metaplex-foundation/skill)
  <sub>skill, nft, mplx-cli</sub>
- [Solana Agent Skills (หน้ารวม)](https://solana.com/skills) `official`
  11 skill ทางการ + community อีก 30+ ตัว
  <sub>skill, claude-code, index, new-2026</sub>
- [solana-dev-skill (official)](https://github.com/solana-foundation/solana-dev-skill) `official`
  ติดตั้ง: npx skills add https://github.com/solana-foundation/solana-dev-skill
  <sub>skill, anchor, pinocchio, kit, testing, canonical</sub>
- [Solana Developer MCP](https://mcp.solana.com/) `official`
  endpoint จริงคือ https://mcp.solana.com/mcp (Streamable HTTP, ไม่ต้องใช้ API key) ต่อได้ทั้ง Claude Code / Codex / Cursor / Windsurf / VS Code; มี 5 tool — list_sections, get_documentation, Solana_Documentation_Search (semantic), Solana_Expert__Ask_For_Help (ถามวิธีทำ/ดีบัก), program_autofixer (สแกนโค้ด Anchor/Pinocchio หาช่องโหว่); ตัวนี้กับ solana-dev-skill คนละอย่าง — MCP ยิงสดตอนรัน ส่วน skill คือไฟล์ที่ติดตั้งไว้ในเครื่อง
  <sub>mcp, docs-search, autofixer, remote, no-auth</sub>
- [awesome-solana-ai](https://github.com/solana-foundation/awesome-solana-ai) `official`
  ลิสต์ AI tooling ทั้งหมด — ที่ที่ควรส่ง PR ถ้าเราทำ skill เอง
  <sub>index, skills, agents, tools</sub>
- [Agent Skills Specification](https://agentskills.io/specification)
  <sub>spec, standard</sub>
- [skills.sh (discovery + installer)](https://www.skills.sh/)
  <sub>registry, installer</sub>
- [Solana Agent Kit](https://github.com/sendaifun/solana-agent-kit)
  <sub>agent, 30-protocols, langchain</sub>
- [SendAI Skills (DeFi/infra skill รวม)](https://github.com/sendaifun/skills)
  <sub>skills, defi, jupiter, raydium, kamino</sub>
- [solana-ai-kit (CLAUDE.md/agents/hooks)](https://github.com/solanabr/solana-ai-kit)
  ชุด config Claude Code สำหรับ Solana — เทียบกับของเราแล้วหยิบของดีมาใช้ได้
  <sub>claude-code, config, template</sub>
- [Helius core-ai skills](https://github.com/helius-labs/core-ai) `vendor`
  <sub>skill, rpc, das, svm-internals</sub>
- [QuickNode — Solana Finance Claude Plugin](https://github.com/quicknode/solana-finance-claude-plugin) `vendor`
  แก้ 4 ส.ค. 2026 — URL เดิม quiknode-labs/solana-anchor-claude-skill 301 มาที่นี่ และของเปลี่ยนไปแล้วจริงๆ ไม่ใช่แค่ย้ายบ้าน ชื่อเดิมในแคตตาล็อกจึงชี้ผิดของ
  <sub>skill, plugin, finance, claude</sub>
- [Orquestra (IDL → REST + MCP)](https://github.com/berkayoztunc/orquestra)
  <sub>idl, rest-api, mcp</sub>
- [solana.com llms.txt (ดัชนีเอกสารสำหรับ AI)](https://solana.com/llms.txt) `official`
  ดัชนี 514 หน้าเอกสารทางการพร้อมคำอธิบายบรรทัดเดียวต่อหน้า — ท่าที่ควรรู้และเช็คแล้วว่าใช้ได้จริง: เติม .md ท้าย URL ไหนก็ได้จะได้ markdown ดิบ (หรือส่ง header Accept: text/markdown ผลเท่ากัน) และมีดัชนีย่อยรายหมวด ขนาดต่างกันมากตามหมวด (วัดเอง 4 ส.ค. 2026: finance 471 byte, defi 1.4 KB, payments 5.5 KB, rpc 13.5 KB) ใช้ตัวย่อยตอนทำงานเรื่องเดียวจะประหยัด context กว่าดัชนีเต็ม 93 KB มาก; ตัวไฟล์เองบอกด้วยว่าโค้ดใน cookbook มาจากไฟล์ตัวอย่างที่เทสต์แล้ว ให้เชื่อมากกว่าเดาเอง
  <sub>llms-txt, markdown, context, agent, index</sub>
- [solana.com llms-full.txt (เอกสารทั้งชุดไฟล์เดียว)](https://solana.com/llms-full.txt) `official`
  เอกสารทั้งหมดรวมไฟล์เดียว 4.5 MB ~462,000 คำ — ใหญ่เกินกว่าจะโยนเข้า context ตรงๆ เหมาะกับ index ทำ RAG หรือ grep ออฟไลน์มากกว่า ถ้าจะให้ agent อ่านสดใช้ llms.txt ตัวดัชนีแล้วดึงเฉพาะหน้าที่ต้องการจะคุ้มกว่ามาก
  <sub>llms-txt, corpus, offline, rag</sub>

## Infra & RPC providers

- [Helius](https://www.helius.dev/) `vendor`
  <sub>rpc, das, webhook, laserstream</sub>
- [Helius Blog](https://www.helius.dev/blog) `vendor`
  คุณภาพบทความสูงสุดในสาย Solana internals — ใช้เป็นวัตถุดิบสอนได้เลย
  <sub>article, deep-dive</sub>
- [QuickNode Solana Guides](https://www.quicknode.com/guides/solana-development) `vendor`
  <sub>guides, rpc</sub>
- [Triton One](https://triton.one/) `vendor`
  <sub>rpc, yellowstone-grpc</sub>
- [Chainstack — Solana tooling overview](https://docs.chainstack.com/docs/solana-tooling) `vendor`
  <sub>overview, tooling</sub>
- [Triton — Riptide & Shred Streaming (ก่อนบล็อกจะเกิด)](https://blog.triton.one/before-the-block-get-the-fastest-streams-on-solana/) `vendor`
  อธิบายชั้นข้อมูลที่เร็วกว่า RPC ปกติ: Riptide คือ endpoint gRPC ตัวใหม่ (Dragon's Mouth เดิม ราคาเท่าเดิม เปลี่ยนแค่ URL) เคลม P90 มาถึงก่อนเจ้าอื่น 81.8% · Shred Streaming คือดูดชิ้นข้อมูลดิบขนาดไม่เกิน 1,228 byte ตรงจาก 5 เมือง (NY/London/Amsterdam/Frankfurt/Tokyo) ร่วมกับ DoubleZero — ได้เห็น tx ก่อนบล็อกประกอบเสร็จ แต่ต้อง verify signature/กู้ packet/decode เองทั้งหมด; อ่านตัวนี้ถ้าจะสอนว่าทำไม arbitrage/oracle ถึงไม่ใช้ RPC ธรรมดา และเส้นแบ่ง shred กับ block คืออะไร
  <sub>grpc, geyser, shred, latency, mev, streaming</sub>
- [rpcpool / Triton One — repo ทั้งหมด (106 repo)](https://github.com/orgs/rpcpool/repositories) `vendor`
  org GitHub ของ Triton One (คนละชื่อกับเว็บ เลยหาไม่เจอถ้าไม่รู้) — ตระกูล Yellowstone อยู่ที่นี่ทั้งหมดและเป็น open-source จริง: yellowstone-grpc (Dragon's Mouth ตัวจริง ดาว 988), yellowstone-vixen (toolkit parse โปรแกรม), yellowstone-faithful (ประวัติ Solana ทั้งเชนแบบ content-addressed), yellowstone-jet (ส่ง tx ผ่าน QUIC + SwQoS), yellowstone-thorofare (เบนช์มาร์ก Geyser gRPC); ของพวกนี้รันเองได้ ไม่ต้องซื้อบริการ เหมาะเป็นวัตถุดิบเวิร์กช็อป infra
  <sub>github, index, yellowstone, grpc, indexing, opensource</sub>
- [rpc-latency-monitor (วัด latency ผู้ให้บริการ RPC)](https://github.com/solana-foundation/rpc-latency-monitor) `official`
  Rust + Apache-2.0 วัด latency ของผู้ให้บริการ RPC แบบ read-only หลายภูมิภาค ส่งออกเป็น Prometheus metrics — จุดขายคือความเป็นกลาง ไม่ใช่เบนช์มาร์กที่ vendor ทำเอง รันเองได้เพื่อวัดจากไทยโดยเฉพาะ ซึ่งตัวเลขจากสิงคโปร์/ญี่ปุ่นที่ vendor โชว์มักไม่ตรงกับที่คนไทยเจอจริง
  <sub>rust, prometheus, benchmark, neutral, self-host</sub>
- [Superbank — รัน indexer ประวัติ Solana เองทั้งเชน](https://blog.triton.one/self-hosting-superbank/) `vendor`
  คู่มือรัน Superbank เอง — indexer ที่ดูดทั้ง ledger ลง ClickHouse แล้วเปิดเป็น JSON-RPC ที่เข้ากันได้กับ Solana แปลว่าเปลี่ยน endpoint แล้วโค้ดเดิมใช้ได้เลย ไม่มี rate limit; ประกอบ 3 ส่วน (ClickHouse / ingestor / superbank-rpc) คุยกันผ่าน HTTP แยกเครื่องได้ ต้องมี ClickHouse 26.x, Rust 1.80+, ป้อนข้อมูลจาก Dragon Mouth gRPC หรือ Fumarole แล้ว backfill ย้อนหลังจาก public RPC; ข้อควรรู้ก่อนตื่นเต้น — ขอ RAM อย่างน้อย 32 GB และแนะนำ 64 GB+ สำหรับ production ไม่ใช่ของที่รันบนโน้ตบุ๊กในเวิร์กช็อปได้; เหตุผลที่ควรรันเองคือคุมได้ว่าจะ index อะไร มีข้อกำหนดเรื่องที่เก็บข้อมูลในประเทศ หรือ query เยอะจนคิดเป็นรายครั้งแล้วไม่คุ้ม — ประเด็น data residency สำคัญกับงานที่ต้องคุยกับหน่วยงานกำกับไทย
  <sub>indexer, clickhouse, self-host, json-rpc, data-residency, rust</sub>
- [superbank (repo)](https://github.com/solana-rpc/superbank) `vendor`
  โค้ดของ Superbank — Rust อยู่ใต้ org solana-rpc ไม่ใช่ rpcpool อย่างที่เดา (หาไม่เจอถ้าไล่จาก org ของ Triton) ★49 ยัง active ส.ค. 2026; อ่านคู่กับบทความ self-hosting ในหมวดเดียวกัน ตัวบทความบอกว่าทำไมและต้องเตรียมอะไร ส่วน repo บอกว่าโครงสร้างจริงเป็นยังไง
  <sub>indexer, clickhouse, rust, opensource</sub>

## Data & Analytics

- [Solana Explorer (first-party)](https://explorer.solana.com/) `official`
  <sub>explorer</sub>
- [Solscan](https://solscan.io/) `vendor` `blocked`
  403 ตอน curl = กัน bot ไม่ใช่ลิงก์ตาย
  <sub>explorer, retail</sub>
- [Dune Analytics](https://dune.com/) `vendor` `blocked`
  fork dashboard คนอื่นได้ ประหยัดเวลามาก
  <sub>sql, dashboard, fork</sub>
- [DefiLlama — Solana](https://defillama.com/chain/Solana) `vendor` `blocked`
  <sub>tvl, defi</sub>
- [Solana Compass](https://solanacompass.com/)
  มี transcript พอดแคสต์ให้ค้นด้วย — วัตถุดิบทำ content ดี
  <sub>projects, metrics, podcast-transcript</sub>
- [Helius — Analyzing Solana On-chain Data: Tools & Dashboards](https://www.helius.dev/blog/solana-data-tools) `vendor`
  <sub>overview, comparison</sub>
- [Birdeye](https://birdeye.so/) `vendor` `blocked`
  <sub>token, price, dex</sub>
- [Step Finance](https://www.step.finance/) `vendor`
  <sub>portfolio, dashboard</sub>
- [Solana Network Data (first-party)](https://solana.com/data) `official`
  ตัวเลขเครือข่ายทางการ (tx, fee, CU, fee payer, slot) — ใช้อ้างอิงในสไลด์/คอนเทนต์ได้โดยไม่ต้องแก้ตัวเลขเอง แต่ refresh วันละ 2 รอบและ lag 1 วัน ไม่ใช่ realtime ถ้าต้องสดใช้ explorer/Dune แทน; หน้านี้ยังลิงก์ไป Allium / Tokens.xyz / Lightspeed / Tx Sender Metrics ด้วย
  <sub>network-stats, dashboard, official-numbers</sub>
- [Solana State (รายงานสถานะเครือข่ายอัตโนมัติ)](https://solana-state.vercel.app/)
  แดชบอร์ดอิสระ (ประกาศเองว่าไม่ได้สังกัด Foundation) รวม execution / validator / เศรษฐกิจ / การใช้งาน / upgrade ที่กำลังจะมา รีเฟรชทุก 30 นาที; ของเด็ดคือมี API สองตัวที่ curl ได้ตรงๆ — /api/report เป็น JSON มี schemaVersion, sources, freshness, alerts, incidents ครบ และ /api/report/markdown เป็นสรุป ~4.6 KB พร้อมตารางที่โยนให้ agent หรือแปะลงคอนเทนต์ได้เลย; เทียบกับ solana.com/data ที่ lag 1 วัน ตัวนี้สดกว่ามาก แต่แลกด้วยความเป็นทางการที่น้อยกว่า — เอาตัวเลขไปอ้างในสไลด์ควรยึด solana.com/data, จะดูสดๆ หรือให้ AI อ่านใช้ตัวนี้; ข้อควรระวัง: โฮสต์บน vercel.app ฟรี หายได้ทุกเมื่อ
  <sub>dashboard, realtime, json-api, markdown-api, agent-friendly</sub>
- [solana-data-aggregator (เครื่องยนต์หลัง solana.com/data)](https://github.com/solana-foundation/solana-data-aggregator) `official`
  Python + MIT — ตัวที่ประมวลผลตัวเลขให้หน้า solana.com/data ทั้งหมด เปิดโค้ดให้ดูว่านิยามของแต่ละ metric คำนวณมายังไงจริงๆ (เช่นนับ non-vote tx ยังไง) แทนที่จะเชื่อตัวเลขบนหน้าเว็บอย่างเดียว — มีประโยชน์ตอนต้องตอบคำถามว่า TPS ที่เห็นนับแบบไหน ซึ่งเถียงกันบ่อยมาก
  <sub>python, mit, pipeline, opensource, metrics</sub>
- [RWA.xyz — หุ้น/ETF ที่ถูก tokenize](https://app.rwa.xyz/stocks) `vendor`
  ทะเบียนหุ้นและ ETF ที่ออกเป็นโทเคน ดูข้ามเชนได้ในที่เดียว มี Solana อยู่ในนั้นเยอะ (Tesla xStock, Circle, Securitize) ตอนเช็ค 4 ส.ค. 2026 ทั้งตลาดมีมูลค่ากระจายอยู่ ~$2.28B จาก 3,315 โทเคน ผู้ถือ ~983K แพลตฟอร์มใหญ่สุดคือ Ondo / bStocks / xStocks; ใช้ตอบคำถามที่คนไทยถามบ่อยที่สุดข้อหนึ่งคือซื้อหุ้นสหรัฐบนเชนได้จริงไหมและใครออก — และใช้ cross-check กับตัวเลข tokenized equities ที่ Solana State รายงาน ถ้าสองที่ไม่ตรงแปลว่านิยามการนับต่างกัน ต้องดูก่อนเอาไปอ้าง; เป็นของ vendor ไม่ใช่ตัวเลขทางการ
  <sub>rwa, tokenized-equity, xstocks, cross-chain, registry</sub>
- [Blockworks — เทียบเชนแบบเคียงข้าง (Spot DEX)](https://blockworks.com/analytics/chain-comparison/chain-comparison-spot-dex) `vendor`
  เทียบ 22 L1 กับ 12 L2 ในหน้าเดียว สลับมุมได้ระหว่าง Overview / Financials / Onchain Activity / Staking / Spot DEX / Lending / Vaults — ค่าอยู่ที่เวลาต้องตอบว่าทำไมต้อง Solana ไม่ใช่เชนอื่น การชี้ตัวเลขเทียบกันตรงๆ จากแหล่งที่เป็นกลางน่าเชื่อกว่าเอาตัวเลขฝั่ง Solana มาพูดเอง; Blockworks เป็นพาร์ตเนอร์ข้อมูลที่ solana.com/data อ้างถึงด้วย (Lightspeed) แต่หน้านี้เป็นมุมของ Blockworks เอง ไม่ใช่ของ Foundation
  <sub>comparison, dex-volume, l1, l2, benchmark</sub>

## DeFi & Ecosystem protocols

- [Jupiter](https://jup.ag/)
  <sub>dex-aggregator, swap, perps</sub>
- [Raydium](https://raydium.io/)
  <sub>amm, clmm, launchlab</sub>
- [Orca (Whirlpools)](https://www.orca.so/)
  <sub>clmm, amm</sub>
- [Kamino Finance](https://app.kamino.finance/)
  <sub>lending, leverage, liquidity</sub>
- [Drift Protocol](https://www.drift.trade/)
  <sub>perps, spot</sub>
- [Meteora](https://www.meteora.ag/)
  <sub>dlmm, vault, launch</sub>
- [Pyth Network](https://pyth.network/)
  <sub>oracle, price-feed</sub>
- [Switchboard](https://switchboard.xyz/)
  <sub>oracle, vrf, on-demand</sub>
- [Squads Protocol](https://squads.so/)
  เกี่ยวตรงกับ treasury/vault ของ Genesis
  <sub>multisig, treasury, smart-account</sub>
- [Jito](https://www.jito.network/) `blocked`
  <sub>mev, lst, bundle</sub>
- [Light Protocol (ZK Compression)](https://www.lightprotocol.com/)
  token/PDA แบบไม่ต้องจ่าย rent — น่าสนสำหรับ airdrop/badge จำนวนมาก
  <sub>zk, compression, rent-free</sub>
- [Harness — trading terminal open-source](https://github.com/GuiBibeau/harness-trade)
  แอปเทรดครบวงจรที่เปิดโค้ด (Apache-2.0): perps ผ่าน Phoenix + spot ผ่าน Jupiter ในบัญชี USDC เดียว มี TP/SL ลากบนชาร์ต, position sizing, journal, ฟีเจอร์ AI (ผู้ใช้ใส่ API key เอง) — ค่าอยู่ที่ได้อ่านโค้ดแอป DeFi ที่ต่อ Phoenix/Jupiter/Privy จริงทั้งระบบ ซึ่งตัวอย่างแบบนี้หายาก ส่วนใหญ่ที่เจอเป็น demo swap หน้าเดียว; stack ไม่เหมือนใครในลิสต์นี้ — SvelteKit + Bun monorepo ไม่ใช่ Next.js; ข้อควรระวัง: open beta ★11 คนทำหลักคนเดียว (589 PR ตั้งแต่ ม.ค. 2026 ยัง active) ใช้เป็นตัวอย่างอ่านโค้ดได้ อย่าถือเป็น reference ที่ผ่านการพิสูจน์ และอย่าแนะนำให้มือใหม่เอาเงินจริงไปลอง
  <sub>trading, perps, phoenix, jupiter, sveltekit, bun, privy, reference-app</sub>

## Mobile

- [Solana Mobile](https://solanamobile.com/)
  <sub>seeker, hardware</sub>
- [Solana Mobile Docs](https://docs.solanamobile.com/)
  dApp Store คิดค่าธรรมเนียม 0% + มี builder grant
  <sub>mobile-stack, dapp-store, sample-apps</sub>

## Protocol internals — Agave, Firedancer, network upgrades

- [Agave (validator client)](https://github.com/anza-xyz/agave) `anza`
  ปี 2026 ปล่อยรุ่นทุก ~6 สัปดาห์ (v4.x)
  <sub>validator, client</sub>
- [Firedancer](https://github.com/firedancer-io/firedancer)
  กินสัดส่วน stake บน mainnet ราว 14% (กลางปี 2026)
  <sub>validator, client-diversity, c</sub>
- [Anza](https://www.anza.xyz/) `anza`
  <sub>core-dev, org</sub>
- [Solana Network Upgrades (Alpenglow roadmap)](https://solana.com/news/solana-network-upgrades) `official`
  TowerBFT → Alpenglow เป้า finality 150ms และเลิกใช้ vote transaction — โค้ดเสร็จอยู่ใน Agave 4.2 แล้วแต่ยังไม่เปิดใช้ รอเปิดใน 4.3 ราว ต.ค. 2026 (ยืนยันจากหน้า agave-4-2-release-overview 4 ส.ค. 2026)
  <sub>alpenglow, consensus, roadmap</sub>
- [100M CU Blocks (SIMD-0286)](https://solana.com/upgrades/100m-cu-blocks) `official`
  block limit 60M→100M CU ขึ้น mainnet แล้ว epoch 1009 (29 ก.ค. 2026) — dev ทั่วไปไม่ต้องแก้อะไร แต่ที่คนเข้าใจผิดบ่อยคือ per-account write limit ยังเป็น 12M CU เท่าเดิม เพิ่มแค่พื้นที่ขนานไม่ได้ทำให้ tx เดี่ยวเร็วขึ้น; ใช้ตอบคำถามในคอมมูฯ ได้ตรงๆ
  <sub>simd, compute-unit, block-limit, mainnet-live</sub>
- [Solana Network Upgrades (hub)](https://solana.com/upgrades) `official`
  หน้ารวม upgrade ทุกตัวพร้อมสถานะ (live / under development / เป้าไตรมาส) — จุดตั้งต้นที่ดีกว่าเก็บหน้าย่อยทีละอันเพราะไม่เน่าเวลามีของใหม่ ใช้เช็คก่อนตอบคำถามคอมมูฯ ว่าอะไรขึ้น mainnet แล้วจริง; ส.ค. 2026 มี 10 ตัว — live: 100M CU Blocks, Optimized Token Program, BLS Pubkey+VAT (อันนี้ validator ต้องลงมือ) · Q3 2026: Larger Tx Sizes, Reduced Slot Times · กำลังทำ: Alpenglow, Reduced Rent, XDP, Agave 4.2, New Crypto Schemes
  <sub>roadmap, upgrade, index, status</sub>
- [Agave 4.2 — รวมสามอย่างที่กระทบ dev มากที่สุดปีนี้](https://solana.com/upgrades/agave-4-2-release-overview) `official`
  เริ่มเปิด feature บน mainnet 17 ส.ค. 2026 ไม่มี breaking change แต่ของข้างในกระทบวิธีออกแบบแอปจริง สามตัว: (1) SIMD-0437 ลดค่า rent 90% ทยอยผ่าน 5 feature gate — SPL token account จาก ~$0.159 เหลือ ~$0.0159 แปลว่าธุรกิจออกค่าเปิดบัญชีให้ผู้ใช้ทั้งหมดเริ่มเป็นไปได้จริงในเชิงต้นทุน ต่อกับ fee-abstraction/Kora ในหมวด payments ได้พอดี (2) SIMD-0296 transaction v1 ขยายขนาดสูงสุด 1,232 -> 4,096 byte งานที่เคยยัดไม่ลง tx เดียวอย่าง ZK proof หรือ multisig ใหญ่ ทำแบบ atomic ได้แล้ว ต้อง opt-in เอง และ indexer ต้องรองรับ layout ใหม่ (3) SIMD-0525 ลด slot 400ms -> 200ms ทีละ 50ms สี่ครั้ง; Alpenglow โค้ดเสร็จใน 4.2 แล้วแต่ยังไม่เปิด รอ 4.3 ต.ค. 2026
  <sub>agave, rent, transaction-size, slot-time, simd, deadline-aug-2026</sub>

## Governance — SGP, SIMD, โหวตบนเชน

- [SIMD — Solana Improvement Documents](https://github.com/solana-foundation/solana-improvement-documents) `official`
  อยากรู้ว่า protocol จะเปลี่ยนอะไร อ่านที่นี่ก่อนข่าว
  <sub>governance, spec, proposal</sub>
- [SIMD Mirror (อ่านง่ายกว่า)](https://simd.mixy.one/)
  <sub>simd, browse</sub>
- [SGP-0003: Resource and Inclusion Fee (โหวตบนเชน)](https://governance.solana.com/proposal/AGHDQ6gjRFJPoyEcHuc4X7sbxJwyJfeKTb3UrGFzFNZD) `official`
  ข้อเสนอรื้อโครงสร้าง base fee: inclusion fee คงที่ 2,500 lamport/tx เข้า leader 100% + resource fee ตาม requested cost unit เผา 100% (ramp 1/10→1/4→1/2 lamport/CU) priority fee ไม่เปลี่ยน สเปคเทคนิคอยู่ที่ SIMD-0553 โหวตนี้เป็นแค่ mandate ไม่ได้เปิด feature gate — ประเด็นที่ต้องบอกคนไทย: ค่า fee จะผูกกับ CU ที่ 'ขอ' ไม่ใช่ที่ 'ใช้' การใส่ compute budget เผื่อๆ จะเริ่มมีราคา สอน request CU ให้แม่นตั้งแต่ตอนนี้; หน้านี้ render ฝั่ง client — curl/WebFetch ได้หน้าเปล่า ต้องเปิดเบราว์เซอร์หรืออ่าน account บนเชนเอง
  <sub>sgp, governance, fee, simd-0553, economics</sub>
- [Solana Validator Governance (portal)](https://governance.solana.com/) `official`
  หน้าโหวตจริง ดู proposal ที่เปิดอยู่/ผลโหวต/top voter — เป็น SPA อ่านผ่าน curl ไม่ได้ ต้องเปิดเบราว์เซอร์ ข้อมูลดิบอยู่บนเชนใต้ program govYkyQ3ePtGULAtY6V75qjWE8UH4vCUVQ1W4HdCAZU
  <sub>sgp, voting, portal, stake-weighted</sub>
- [Solana Governance Docs](https://docs.governance.solana.com/) `official`
  อธิบายกลไกจริง: NCN สร้าง merkle snapshot ของ stake → operator โหวต hash จนได้ consensus → validator เปิด proposal → ได้ support 15% ของ cluster ถึงเปิดโหวต → delegator override เสียงของ validator ตัวเองได้ด้วย stake account proof; มี program ID / CLI args / error code ครบ อ่านตัวนี้ก่อนถ้าจะสอนเรื่อง governance
  <sub>sgp, ncn, svmgov, process, cli</sub>
- [SGP — Solana Governance Proposals (repo)](https://github.com/solana-foundation/solana-governance-proposals) `official`
  ตัว SGP เป็น markdown ทั้งหมด — อ่านง่ายกว่า portal มากและ curl ได้ ต่างจาก SIMD ตรง SGP ตอบ 'ควรทำไหม' (โหวตด้วย stake) SIMD ตอบ 'ทำยังไง' (รีวิวเชิงเทคนิค); ผ่านต้องได้ 2 ใน 3 ไม่มี quorum ขั้นต่ำ lifecycle Draft→Support→Voting→Accepted→Implementation→Activation ราว 11 epoch มี template ให้ด้วย
  <sub>sgp, markdown, template, lifecycle</sub>
- [solana-governance (svmgov tooling)](https://github.com/solana-foundation/solana-governance) `official`
  โค้ดทั้งระบบ: โปรแกรม svmgov (Anchor), CLI ภาษา Rust สำหรับเปิด proposal/โหวตจาก terminal, NCN module, frontend Next.js — เป็นตัวอย่าง production Anchor + merkle proof ที่อ่านได้จริง ใช้เป็นวัตถุดิบสอนได้
  <sub>svmgov, anchor, cli, rust, ncn</sub>
- [Solana Forum — Governance](https://forum.solana.com/c/gov/11) `official`
  ที่ถกกันก่อนขึ้นเชน เธรดใหญ่ๆ อยู่ที่นี่ (SIMD-0326 Alpenglow 117 reply, priority fee เข้า validator เต็ม 76 reply) — อยากรู้ 'ทำไม' เบื้องหลังโหวตต้องอ่านที่นี่ ไม่ใช่ตัว proposal
  <sub>forum, discussion, pre-chain, simd</sub>

## Funding — grants, hackathon, bounty, jobs

- [Colosseum](https://colosseum.com/)
  hackathon + accelerator 6 สัปดาห์ + venture fund $60M
  <sub>hackathon, accelerator, vc</sub>
- [Colosseum Hackathon](https://colosseum.com/hackathon)
  <sub>hackathon</sub>
- [Colosseum Codex (blog)](https://blog.colosseum.com/)
  <sub>announcement, blog</sub>
- [Superteam](https://superteam.fun/)
  <sub>talent-network, community</sub>
- [Superteam Earn (bounty)](https://earn.superteam.fun/)
  ทางเข้าที่ต่ำที่สุดสำหรับคนไทยจะได้เงินก้อนแรกจาก ecosystem
  <sub>bounty, grant, freelance</sub>
- [Superteam Talent (หางาน)](https://talent.superteam.fun/)
  <sub>jobs</sub>
- [Superteam × Solana Hackathon Hub](https://superteam.fun/hackathon)
  <sub>hackathon, hub</sub>
- [Solana Foundation Grants](https://solana.org/grants) `official`
  <sub>grant</sub>
- [Superteam Events Calendar](https://luma.com/superteam)
  <sub>events</sub>
- [Solana Foundation — บอร์ดสมัครงาน](https://jobs.ashbyhq.com/Solana%20Foundation) `official`
  บอร์ดงานทางการของ Foundation (Ashby) — ส.ค. 2026 เปิด 10 ตำแหน่ง ส่วนใหญ่เป็นสาย BD/growth และมีฝั่งเอเชียหลายตัว (Greater China, Japan, Trading Growth Lead - Asia) ซึ่งใกล้ตัวคนไทยกว่าที่คิด; หน้าเว็บเป็น SPA อ่านผ่าน curl ไม่ได้ แต่ Ashby มี public API ดึงได้ทั้งบอร์ดพร้อมรายละเอียด: https://api.ashbyhq.com/posting-api/job-board/Solana%20Foundation?includeCompensation=true แล้วอ่านด้วย jq
  <sub>jobs, careers, ashby, remote</sub>
- [Solana Program Engineer (เปิดรับตลอด ไม่ใช่ตำแหน่งเดียว)](https://jobs.ashbyhq.com/Solana%20Foundation/6be29283-a2e0-48f4-b388-d06f48e240b3) `official`
  ไม่ใช่ประกาศรับตำแหน่งเดียวแต่เป็น open application เอาไว้แสดงความสนใจ แล้ว Foundation จะจับคู่กับทีมในระบบนิเวศให้ — Remote-International เต็มเวลา เปิดมาตั้งแต่ พ.ย. 2025 ถึง ส.ค. 2026 ก็ยังเปิดอยู่ คนไทยสมัครได้ไม่ติดเรื่องที่อยู่; สายงานที่ระบุไว้ตรงกับสิ่งที่คนจบ Blueshift/Turbin3 ฝึกมาพอดี — DeFi ขั้นสูง (CLOB, AMM, lending/perps, oracle, liquidation engine), core infra (smart wallet, gasless relayer, session key, indexer, contribute Anchor/Pinocchio), และ on-chain app (token launch, RWA, DePIN); ใช้เป็นปลายทางที่จับต้องได้เวลามีคนถามว่าเรียนไปแล้วไปทำอะไรต่อ
  <sub>jobs, defi, anchor, pinocchio, remote-international, open-application</sub>
- [Alpenglow Bug Bounty — 50,000 SOL (5-19 ส.ค. 2026)](https://github.com/anza-xyz/alpenglow) `anza`
  เตือน: หน้าต่างส่งแค่ 5-19 ส.ค. 2026 เท่านั้น เงินรางวัลรวมสูงสุด 50,000 SOL; repo นี้ไม่มีโค้ด เป็นแค่ประตูรับ submission — ตัว Alpenglow จริงอยู่ใน agave เขาชี้จุดเริ่มไว้ 4 crate คือ votor (เครื่องโหวต), votor-messages (ชนิดของ vote/certificate), bls-sigverify, bls-cert-verify; เดิม Alpenglow ถูกกันออกจาก bug bounty ของ agave เพิ่งมาเข้าเกณฑ์รอบนี้ แปลว่าโค้ดส่วนนี้ยังผ่านสายตาคนนอกน้อยกว่าส่วนอื่น; ส่งผ่าน GitHub Security Advisory และห้ามเปิดเผยถึงจะเข้าเกณฑ์ — ควรกระจายข่าวในชุมชนทันทีเพราะปิดเร็ว
  <sub>bounty, security, consensus, alpenglow, audit, deadline</sub>

## Thailand — ชุมชนไทย

- [Superteam Thailand — Events Calendar](https://luma.com/SuperteamTH) `TH`
  <sub>events, luma</sub>
- [Solana Thailand Genesis — Discord](https://discord.gg/PGbUgNmsns) `TH`
  ทางเข้าหลักของชุมชน (rank Spectator → Challenger → Builder → Job Hunter)
  <sub>discord, community</sub>
- [ozoneRatchapon (King Crab — Community Operator)](https://github.com/ozoneRatchapon) `TH`
  <sub>maintainer</sub>


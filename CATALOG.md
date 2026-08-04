# Solana Resource Catalog

> ไฟล์นี้ถูก generate จาก [data/resources.yml](data/resources.yml) — **อย่าแก้ตรงนี้**
> แก้ที่ YAML แล้วรัน `./scripts/render.sh`

รวม **145** รายการ · อัปเดต 2026-08-04

หมายเหตุสถานะ: `blocked` = เว็บกัน bot ตอน curl (ลิงก์ยังใช้ได้), `unverified` = เช็คอัตโนมัติไม่ผ่าน ต้องดูด้วยตา

## สารบัญ

- [Official — Foundation & Anza (source of truth ตัวจริง)](#official--foundation--anza-source-of-truth-ตัวจริง) — 16
- [Learning — คอร์ส, bootcamp, tutorial](#learning--คอร์ส-bootcamp-tutorial) — 13
- [Program Frameworks — Anchor / Pinocchio / native](#program-frameworks--anchor--pinocchio--native) — 11
- [Client SDK — Kit, web3.js, scaffolding](#client-sdk--kit-web3js-scaffolding) — 10
- [Testing — LiteSVM, Mollusk, Surfpool](#testing--litesvm-mollusk-surfpool) — 5
- [IDL & Codegen](#idl--codegen) — 4
- [Tokens & NFT — SPL, Token-2022, Metaplex](#tokens--nft--spl-token-2022-metaplex) — 5
- [Payments & Commerce](#payments--commerce) — 5
- [Security & Audit](#security--audit) — 5
- [AI / Agent Skills / MCP](#ai--agent-skills--mcp) — 15
- [Infra & RPC providers](#infra--rpc-providers) — 7
- [Data & Analytics](#data--analytics) — 10
- [DeFi & Ecosystem protocols](#defi--ecosystem-protocols) — 11
- [Mobile](#mobile) — 2
- [Protocol internals — Agave, Firedancer, network upgrades](#protocol-internals--agave-firedancer-network-upgrades) — 6
- [Governance — SGP, SIMD, โหวตบนเชน](#governance--sgp-simd-โหวตบนเชน) — 8
- [Funding — grants, hackathon, bounty, jobs](#funding--grants-hackathon-bounty-jobs) — 9
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
  PR เข้าตรงนี้ได้ — ช่องทางหลักถ้าจะ contribute เนื้อหา/แปล
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
- [Kora (gasless/relayer)](https://docs.kora.network/) `unverified`
  อยู่ในลิสต์ curated ของ Foundation แต่ตอนเช็คลิงก์ resolve ไม่ผ่าน — ต้องยืนยันซ้ำ
  <sub>gasless, relayer</sub>
- [Solana × WSOP (case study การใช้งานจริง)](https://solana.com/wsop) `official`
  Solana เป็น presenting sponsor ของ WSOP 2026 — ของจริงที่ใช้อ้างได้คือ buy-in ทัวร์นาเมนต์ผ่านแอป WSOP LIVE ด้วย SOL/USDC/USDT ยืนยันทันที ไม่มีค่าธรรมเนียมประมวลผล เป็นเคส consumer payments ระดับแบรนด์ mainstream ที่เล่าให้คนนอกวงคริปโตฟังรู้เรื่อง ใช้เปิดหัวตอนพูดเรื่อง payments ได้; ระวัง — เป็นหน้าแคมเปญ ไม่ใช่เอกสารเทคนิค งาน Showdown 4 ส.ค. 2026 และ Paradise ธ.ค. 2026 ผ่านไปแล้วน่าจะเน่า ให้รีวิวใหม่ต้นปี 2027
  <sub>adoption, case-study, consumer, usdc, mainstream</sub>
- [subscriptions (delegation / จ่ายรายรอบ on-chain)](https://github.com/solana-foundation/subscriptions) `official`
  โปรแกรมจ่ายเงินรายรอบบน SPL Token/Token-2022 — deploy mainnet แล้วจริง (De1egAFMkMWZSN5rYXRj9CAdheBamobVNubTsi9avR44 เช็คแล้ว executable) audit โดย Cantina หลายรอบ ล่าสุดปี 2026; กลไก: PDA 'Subscription Authority' เป็น delegate ตัวเดียวต่อคู่ user-mint แล้วให้ Delegation PDA อีกชั้นคุมว่าโอนได้เมื่อไหร่ เลยมีหลาย delegation พร้อมกันได้โดยไม่เสียความปลอดภัยแบบ approve ปกติ รองรับ fixed / recurring / subscription plan ปิดแล้วได้ rent คืน; น่าสนใจเป็นพิเศษเพราะ stack ตรงกับที่ repo นี้เชียร์ — Pinocchio + Codama + LiteSVM + client TS/Rust ใช้เป็นตัวอย่างโค้ด production ที่อ่านได้จริง
  <sub>subscription, delegation, token-2022, pinocchio, codama, litesvm, audited</sub>

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
  semantic search เอกสาร + autofixer โปรแกรม Anchor/Pinocchio ต่อ Claude Code ได้
  <sub>mcp, docs-search, autofixer</sub>
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
- [QuickNode — Anchor Claude Skill](https://github.com/quiknode-labs/solana-anchor-claude-skill) `vendor`
  <sub>skill, anchor, kit</sub>
- [Orquestra (IDL → REST + MCP)](https://github.com/berkayoztunc/orquestra)
  <sub>idl, rest-api, mcp</sub>
- [solana.com llms.txt (ดัชนีเอกสารสำหรับ AI)](https://solana.com/llms.txt) `official`
  ดัชนี 514 หน้าเอกสารทางการพร้อมคำอธิบายบรรทัดเดียวต่อหน้า — ท่าที่ควรรู้และเช็คแล้วว่าใช้ได้จริง: เติม .md ท้าย URL ไหนก็ได้จะได้ markdown ดิบ (หรือส่ง header Accept: text/markdown ผลเท่ากัน) และมีดัชนีย่อยรายหมวด เช่น /docs/finance/llms.txt, /docs/payments/llms.txt ขนาดแค่ ~500 byte ใช้ตัวย่อยตอนทำงานเรื่องเดียวจะประหยัด context กว่าเยอะ; ตัวไฟล์เองบอกด้วยว่าโค้ดใน cookbook มาจากไฟล์ตัวอย่างที่เทสต์แล้ว ให้เชื่อมากกว่าเดาเอง
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

## Data & Analytics

- [Solana Explorer (first-party)](https://explorer.solana.com/) `official`
  <sub>explorer</sub>
- [Solscan](https://solscan.io/) `vendor` `blocked`
  403 ตอน curl = กัน bot ไม่ใช่ลิงก์ตาย
  <sub>explorer, retail</sub>
- [Dune Analytics](https://dune.com/) `vendor` `blocked`
  fork dashboard คนอื่นได้ ประหยัดเวลามาก
  <sub>sql, dashboard, fork</sub>
- [Flipside Crypto](https://flipsidecrypto.xyz/) `vendor`
  <sub>sql, historical</sub>
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
  TowerBFT → Alpenglow เป้า finality 150ms, mainnet ปลายปี 2026
  <sub>alpenglow, consensus, roadmap</sub>
- [100M CU Blocks (SIMD-0286)](https://solana.com/upgrades/100m-cu-blocks) `official`
  block limit 60M→100M CU ขึ้น mainnet แล้ว epoch 1009 (29 ก.ค. 2026) — dev ทั่วไปไม่ต้องแก้อะไร แต่ที่คนเข้าใจผิดบ่อยคือ per-account write limit ยังเป็น 12M CU เท่าเดิม เพิ่มแค่พื้นที่ขนานไม่ได้ทำให้ tx เดี่ยวเร็วขึ้น; ใช้ตอบคำถามในคอมมูฯ ได้ตรงๆ
  <sub>simd, compute-unit, block-limit, mainnet-live</sub>
- [Solana Network Upgrades (hub)](https://solana.com/upgrades) `official`
  หน้ารวม upgrade ทุกตัวพร้อมสถานะ (live / under development / เป้าไตรมาส) — จุดตั้งต้นที่ดีกว่าเก็บหน้าย่อยทีละอันเพราะไม่เน่าเวลามีของใหม่ ใช้เช็คก่อนตอบคำถามคอมมูฯ ว่าอะไรขึ้น mainnet แล้วจริง; ส.ค. 2026 มี 10 ตัว — live: 100M CU Blocks, Optimized Token Program, BLS Pubkey+VAT (อันนี้ validator ต้องลงมือ) · Q3 2026: Larger Tx Sizes, Reduced Slot Times · กำลังทำ: Alpenglow, Reduced Rent, XDP, Agave 4.2, New Crypto Schemes
  <sub>roadmap, upgrade, index, status</sub>

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

## Thailand — ชุมชนไทย

- [Superteam Thailand — Events Calendar](https://luma.com/SuperteamTH) `TH`
  <sub>events, luma</sub>
- [Solana Thailand Genesis — Discord](https://discord.gg/PGbUgNmsns) `TH`
  ทางเข้าหลักของชุมชน (rank Spectator → Challenger → Builder → Job Hunter)
  <sub>discord, community</sub>
- [ozoneRatchapon (King Crab — Community Operator)](https://github.com/ozoneRatchapon) `TH`
  <sub>maintainer</sub>


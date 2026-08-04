# Solana Resource Catalog

> ไฟล์นี้ถูก generate จาก [data/resources.yml](data/resources.yml) — **อย่าแก้ตรงนี้**
> แก้ที่ YAML แล้วรัน `./scripts/render.sh`

รวม **127** รายการ · อัปเดต 2026-08-04

หมายเหตุสถานะ: `blocked` = เว็บกัน bot ตอน curl (ลิงก์ยังใช้ได้), `unverified` = เช็คอัตโนมัติไม่ผ่าน ต้องดูด้วยตา

## สารบัญ

- [Official — Foundation & Anza (source of truth ตัวจริง)](#official--foundation--anza-source-of-truth-ตัวจริง) — 13
- [Learning — คอร์ส, bootcamp, tutorial](#learning--คอร์ส-bootcamp-tutorial) — 13
- [Program Frameworks — Anchor / Pinocchio / native](#program-frameworks--anchor--pinocchio--native) — 11
- [Client SDK — Kit, web3.js, scaffolding](#client-sdk--kit-web3js-scaffolding) — 10
- [Testing — LiteSVM, Mollusk, Surfpool](#testing--litesvm-mollusk-surfpool) — 5
- [IDL & Codegen](#idl--codegen) — 4
- [Tokens & NFT — SPL, Token-2022, Metaplex](#tokens--nft--spl-token-2022-metaplex) — 5
- [Payments & Commerce](#payments--commerce) — 3
- [Security & Audit](#security--audit) — 5
- [AI / Agent Skills / MCP](#ai--agent-skills--mcp) — 13
- [Infra & RPC providers](#infra--rpc-providers) — 5
- [Data & Analytics](#data--analytics) — 9
- [DeFi & Ecosystem protocols](#defi--ecosystem-protocols) — 11
- [Mobile](#mobile) — 2
- [Protocol internals — Agave, Firedancer, SIMD](#protocol-internals--agave-firedancer-simd) — 6
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

## Protocol internals — Agave, Firedancer, SIMD

- [SIMD — Solana Improvement Documents](https://github.com/solana-foundation/solana-improvement-documents) `official`
  อยากรู้ว่า protocol จะเปลี่ยนอะไร อ่านที่นี่ก่อนข่าว
  <sub>governance, spec, proposal</sub>
- [SIMD Mirror (อ่านง่ายกว่า)](https://simd.mixy.one/)
  <sub>simd, browse</sub>
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


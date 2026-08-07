# Solana Resource Catalog

> ไฟล์นี้ถูก generate จาก [data/resources.yml](data/resources.yml) — **อย่าแก้ตรงนี้**
> แก้ที่ YAML แล้วรัน `./scripts/render.sh`

รวม **210** รายการ · ข้อมูลล่าสุด 2026-08-07

หมายเหตุสถานะ: `blocked` = เว็บกัน bot ตอน curl (ลิงก์ยังใช้ได้), `unverified` = เช็คอัตโนมัติไม่ผ่าน ต้องดูด้วยตา

## สารบัญ

- [Official — Foundation & Anza (source of truth ตัวจริง)](#official--foundation--anza-source-of-truth-ตัวจริง) — 18
- [Learning — คอร์ส, bootcamp, tutorial](#learning--คอร์ส-bootcamp-tutorial) — 18
- [Program Frameworks — Anchor / Pinocchio / native](#program-frameworks--anchor--pinocchio--native) — 12
- [Client SDK — Kit, web3.js, scaffolding](#client-sdk--kit-web3js-scaffolding) — 11
- [Testing — LiteSVM, Mollusk, Surfpool](#testing--litesvm-mollusk-surfpool) — 5
- [IDL & Codegen](#idl--codegen) — 4
- [Tokens & NFT — SPL, Token-2022, Metaplex](#tokens--nft--spl-token-2022-metaplex) — 7
- [Payments & Commerce](#payments--commerce) — 23
- [Security & Audit](#security--audit) — 7
- [AI / Agent Skills / MCP](#ai--agent-skills--mcp) — 19
- [Infra & RPC providers](#infra--rpc-providers) — 12
- [Data & Analytics](#data--analytics) — 13
- [DeFi & Ecosystem protocols](#defi--ecosystem-protocols) — 13
- [Mobile](#mobile) — 2
- [Protocol internals — Agave, Firedancer, network upgrades](#protocol-internals--agave-firedancer-network-upgrades) — 10
- [Governance — SGP, SIMD, โหวตบนเชน](#governance--sgp-simd-โหวตบนเชน) — 9
- [Green software — พลังงาน คาร์บอน ประสิทธิภาพ](#green-software--พลังงาน-คาร์บอน-ประสิทธิภาพ) — 4
- [Funding — grants, hackathon, bounty, jobs](#funding--grants-hackathon-bounty-jobs) — 19
- [Thailand — ชุมชนไทย](#thailand--ชุมชนไทย) — 4

## Official — Foundation & Anza (source of truth ตัวจริง)

- [Solana Documentation](https://solana.com/docs) `official`
  จุดเริ่มต้นทุกอย่าง ปี 2026 rebuild ใหม่ code sample ผ่าน CI ทุกตัว
  <sub>docs, core, rpc, canonical</sub>
- [Solana Developers Portal](https://solana.com/developers) `official`
  หน้ารวม guides / cookbook / courses / bootcamp / templates
  <sub>hub, index</sub>
- [Solana Developer Guides](https://solana.com/developers/guides) `official`
  ระวัง URL นี้ redirect ไป solana.com/docs แล้ว หน้า guides เดิมไม่มีอยู่ต่างหากอีกต่อไป — ปลายทางปัจจุบันคือหน้า Start Here ที่ให้เลือกระหว่าง quickstart, เขียนโค้ดกับ AI agent, หรือเรียนว่า Solana ทำงานยังไง; เก็บ entry ไว้เพราะยังมีคนส่งลิงก์เก่านี้กันอยู่ จะได้รู้ว่ามันพาไปไหน
  <sub>guides, howto</sub>
- [Solana Cookbook (official)](https://solana.com/developers/cookbook) `official`
  recipe สั้นๆ ต่อ task — ต่างจาก solanacookbook.com ของเดิมที่เป็น community
  <sub>snippets, recipes</sub>
- [Solana RPC API Reference](https://solana.com/docs/rpc) `official`
  เอกสารอ้างอิง JSON-RPC ทั้งชุด พร้อม endpoint ของแต่ละ cluster และเรื่องระดับ commitment — ตัวหลังเป็นจุดที่คนพลาดบ่อยที่สุดเวลาทำระบบจ่ายเงิน เพราะเลือก commitment ผิดแล้วนับว่าเงินเข้าทั้งที่ยังไม่ final
  <sub>rpc, api, reference</sub>
- [Solana Tools & Infrastructure Docs](https://solana.com/docs/tools) `official`
  แคตตาล็อกเครื่องมือทางการทั้งหมด แยกเป็น reference / งานในเครื่อง / เรียนจากตัวอย่าง / เครื่องมือ / ระบบนิเวศ — ใช้เป็นตัวเทียบว่าแคตตาล็อกของเราตกอะไรไปบ้าง ซึ่งเป็นวิธีหา resource ใหม่ที่ได้ผลกว่าการค้นเอง
  <sub>tooling</sub>
- [Solana Developer Platform (SDP)](https://platform.solana.com) `official`
  platform API-first สำหรับ enterprise/สถาบันการเงิน ออกปี 2026 — ของใหม่ ยังมีคนใช้น้อย
  <sub>api, enterprise, fintech, new-2026</sub>
- [Solana Developer Platform Docs](https://platform.solana.com/docs) `official`
  เอกสารของ SDP — แดชบอร์ดกับ REST API สำหรับออกสินทรัพย์จริง งานชำระเงิน และตลาด พร้อมชั้นควบคุมตามกฎในตัว; เขียนสำหรับองค์กรที่ไม่อยากแตะระดับโปรแกรมเอง อ่านคู่กับ repo solana-developer-platform ที่ประกาศเองว่ายัง pre-mainnet และยังไม่ผ่าน audit
  <sub>api, docs</sub>
- [Solana Media / Changelog](https://solana.com/news) `official`
  Solana Changelog ออกทุก ~2 สัปดาห์ ใช้ track ว่าอะไรเปลี่ยน
  <sub>news, changelog</sub>
- [Solana Foundation GitHub](https://github.com/solana-foundation) `official`
  org GitHub ของ Foundation 99 repo — ประตูเข้าของทุกอย่างฝั่งทางการ แต่หน้านี้โชว์แค่ที่ pin ไว้ ถ้าจะดูครบต้องไปหน้า repositories ที่เก็บแยกไว้แล้ว ซึ่งเป็นที่ที่ของอย่าง subscriptions และ rpc-latency-monitor โผล่มาให้เจอ
  <sub>github, org</sub>
- [developer-content (repo ของ docs ทั้งหมด)](https://github.com/solana-foundation/developer-content) `official`
  ARCHIVED — ตรวจ 4 ส.ค. 2026 ด้วย gh api ได้ archived=true, push ล่าสุด 24 ม.ค. 2025 เปิด PR ไม่ได้แล้ว เนื้อหาย้ายไปอยู่ solana-com เก็บไว้อ้างอิงประวัติเท่านั้น (โน้ตเดิมเขียนว่าเป็นช่องทาง contribute ซึ่งผิด)
  <sub>github, docs, contributable</sub>
- [solana-com (เว็บ solana.com)](https://github.com/solana-foundation/solana-com) `official`
  มี i18n อยู่ในนี้ — จุดเข้าถ้าจะดันภาษาไทย
  <sub>github, website, i18n</sub>
- [Validated (podcast)](https://solana.com/validated) `official`
  พอดแคสต์ที่ Austin Federa คุยกับผู้ก่อตั้งและนักวิจัยในระบบนิเวศ — ใช้เป็นวัตถุดิบทำคอนเทนต์เพราะได้บริบทเบื้องหลังการตัดสินใจที่ไม่มีในเอกสาร; ถ้าจะค้นเนื้อหาแบบเป็นข้อความ Solana Compass มี transcript ให้ค้นได้ในหมวด data-analytics
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
  คอร์สทางการแบบมีลำดับ — แต่ต้องรู้ก่อนว่า URL นี้ redirect ไปที่ GitHub tree ของ repo developer-content ซึ่ง archived ตั้งแต่ ม.ค. 2025 แปลว่าเนื้อหายังอ่านได้แต่ไม่มีใครอัปเดตแล้วและส่ง PR แก้ไม่ได้ ตรวจวันที่ในแต่ละบทก่อนใช้สอน โดยเฉพาะส่วนที่เป็น web3.js v1
  <sub>course, structured</sub>
- [Solana Developer Bootcamp](https://solana.com/developers/bootcamp) `official`
  foundations → program patterns → fullstack → production
  <sub>bootcamp, video</sub>
- [solana-bootcamp-2026](https://github.com/solana-foundation/solana-bootcamp-2026) `official`
  โปรเจกต์จริง 8 ตัว (voting, escrow, private transfers, stablecoin, stableswap, x402, RWA, prediction market) — ตรวจโค้ดแล้ว 5 ส.ค. 2026: ใช้ anchor-lang 1.0.0-rc.2 + @anchor-lang/core 1.0 คือของปัจจุบัน ไม่ใช่ 0.3x แบบ tutorial ส่วนใหญ่บนเน็ต
  <sub>github, bootcamp, curriculum</sub>
- [Blueshift](https://learn.blueshift.gg/)
  Foundation แนะนำเอง — คอร์สฟรี open-source มี challenge ให้ทำจริง
  <sub>course, free, anchor, rust, typescript, challenges</sub>
- [Blueshift GitHub](https://github.com/blueshift-gg)
  org GitHub ของ Blueshift (92 repo) — เนื้อหาคอร์สเปิดโค้ดทั้งหมดอยู่ที่นี่ ใช้ตอนอยากดูเฉลยหรือหยิบโครงแบบฝึกไปดัดแปลงเป็น quest ของ Genesis โดยไม่ต้องเขียนใหม่
  <sub>github, course-content</sub>
- [Blueshift Research](https://blueshift.gg/research/)
  เขียนเรื่อง sunrising web3.js / ทิศทาง TS ecosystem ได้ดี
  <sub>research, ecosystem</sub>
- ~~[Solana Cookbook (community, รุ่นเก่า)](https://solanacookbook.com/)~~ `เลิกใช้`
  ตัวอย่างส่วนใหญ่เป็น web3.js v1 ซึ่งอยู่ maintenance แล้ว โค้ดก็อปไปรันตรงๆ กับ Kit/v3 ไม่ผ่าน — ยังมีของดีเชิงแนวคิดอยู่ แต่ต้องแปลงโค้ดเองทุกครั้ง
  **ใช้แทน:** https://solana.com/developers/cookbook
  cookbook ชุมชนรุ่นแรก ครอบคลุม task พื้นฐานกว้างและอธิบายแนวคิดดี — ปัจจุบันมีตัวทางการแล้ว
  <sub>snippets, legacy</sub>
- [Turbin3](https://turbin3.org/)
  cohort เข้มข้น มี live code review + mentor 2,000+ dev ผ่านมาแล้ว
  <sub>cohort, intensive, rust, anchor</sub>
- [Turbin3 Institute (free training)](https://turbin3.org/institute)
  สายฝึกฟรีของ Turbin3 มีผู้สอนจากวงการจริง เคลมว่ามีคนผ่านแล้ว 2,000+ — เป็นประตูที่เบากว่า cohort หลักที่เข้มข้นและต้องทุ่มเวลา ใช้เป็นขั้นแรกให้คนไทยที่ยังไม่แน่ใจว่าไหวไหม
  <sub>free, training</sub>
- [Rise In — Solana Bootcamp](https://www.risein.com/programs/solana-bootcamp)
  bootcamp แบบมีรอบลงทะเบียน เปิดรับทั้งมือใหม่และคนที่เขียนโปรแกรมเป็นแล้ว — ต่างจากคอร์สที่เรียนเองได้ตลอดเวลาตรงมีกำหนดเวลาและมีเพื่อนร่วมรุ่น ซึ่งช่วยคนที่เรียนเองแล้วไม่จบ; ต้องเช็ครอบที่เปิดอยู่ก่อนแนะนำ
  <sub>bootcamp</sub>
- [RareSkills — Ethereum to Solana](https://www.rareskills.io/solana-tutorial)
  ดีมากถ้ากลุ่มเป้าหมายเป็น dev สาย EVM
  <sub>evm-migration, tutorial</sub>
- [HackQuest — Solana learning track](https://www.hackquest.io/)
  แพลตฟอร์มเรียนแบบหลายเชน มี Solana เป็นหนึ่งใน 20+ ระบบนิเวศที่รองรับ พร้อมอีเวนต์ แฮกกาธอน และ accelerator — ค่าอยู่ที่เหมาะกับคนที่ยังไม่ตัดสินใจว่าจะลงเชนไหน ส่วนคนที่เลือก Solana แล้วควรไป Blueshift หรือ Ackee ที่ลึกกว่า
  <sub>interactive</sub>
- [Ackee — School of Solana](https://ackee.xyz/school-of-solana)
  คอร์สฟรีที่มีใบรับรอง สอน Rust ควบ Solana มี lecture, Solana Handbook และเกณฑ์รับใบรับรองเขียนไว้ชัด — ต่างจากคอร์สอื่นในหมวดตรงมีเส้นจบที่วัดได้ เหมาะกับคนที่ต้องการหลักฐานเอาไปสมัครงาน ไม่ใช่แค่ความรู้
  <sub>course, certificate</sub>
- [Solana Crashcourse — เส้นทางสั้นก่อนลง bootcamp เต็ม](https://solana.com/developers/bootcamp/solana-crashcourse) `official`
  คอร์สสั้นทางการที่เพิ่งเพิ่มเข้ามาใน bootcamp — เน้นเส้นทางสั้นที่สุดจาก "ยังไม่รู้อะไรเลย" ไปถึง "มีแอปที่ deploy แล้ว" ครอบ 3 อย่าง: roadmap ของนักพัฒนา Solana, ตั้งสภาพแวดล้อมในเครื่องให้ใช้งานได้ และ build-deploy รอบแรก; **ต่างจาก bootcamp เต็ม 4 โมดูลตรงที่ตั้งใจให้เบา** เอกสารเขียนเองว่าให้กลับไป bootcamp เมื่ออยากได้เส้นทางที่ลึกกว่า — เหมาะเป็นตัวส่งให้คนไทยที่ถามว่า "เริ่มยังไง" แล้วยังไม่พร้อมทุ่มเวลากับ bootcamp; หมายเหตุ หน้ายังใหม่ ตัวเอกสารเขียนเองว่า "more lessons can be added here as they finish editing" แปลว่ายังไม่ครบ ควรเช็คก่อนวางเป็นหลักสูตรจริง
  <sub>course, quickstart, video, roadmap, beginner</sub>
- [MIT 14.129 — Blockchain and the Design of Financial Systems (ฟรี)](https://ocw.mit.edu/courses/14-129-blockchain-and-the-design-of-financial-systems-spring-2025/)
  คอร์สระดับบัณฑิตศึกษาของ MIT ที่เอาเทคโนโลยีฝั่งคอมพิวเตอร์ (คริปโต บล็อกเชน tokenization แพลตฟอร์ม อัลกอริทึม) มาชนกับเครื่องมือฝั่งเศรษฐศาสตร์ (contract theory, mechanism design, general equilibrium, monetary theory) เป้าคือเข้าใจว่าข้อสมมติคืออะไร จุดอ่อนอยู่ตรงไหน และจะกระทบอะไรจริง — เปิดฟรีบน OCW มีทั้ง syllabus, readings, lecture notes และวิดีโอ; **ไม่ใช่ของ Solana แต่เก็บด้วยเหตุผลเฉพาะที่หนักกว่าปกติ** — ผู้สอนคือ Prof. Robert M. Townsend เจ้าของ Townsend Thai Project ที่สำรวจครัวเรือนไทยต่อเนื่องตั้งแต่ปี 1997 ครอบ 2,880 ครัวเรือน 262 กลุ่มชุมชน และ 161 สถาบันการเงินระดับหมู่บ้าน คือคนที่เข้าใจระบบการเงินฐานรากของไทยลึกที่สุดคนหนึ่ง มาสอนเรื่องออกแบบระบบการเงินด้วยบล็อกเชน; ใช้ตอนต้องเถียงเรื่อง tokenomics หรือออกแบบกลไกให้มีน้ำหนักกว่าอ้างจากบล็อกโปรโตคอล เช่นเวลาคุยเรื่อง SGP-0003 ที่เปลี่ยนโครงสร้างค่าธรรมเนียม ซึ่งเป็นโจทย์ mechanism design ตรงๆ
  <sub>mit-ocw, economics, mechanism-design, graduate, free, lecture-notes</sub>
- [Solana Rust client course (เรียนใน VS Code)](https://github.com/bergabman/solana-rust-vscode-course)
  คอร์สฝั่ง client ของ Solana ที่เขียนด้วย Rust และ **เรียนอยู่ใน VS Code เลย** โครง repo มี exercises, crates, book (mdBook) และ justfile คือทำเป็นแบบฝึกหัดให้แก้ทีละข้อแบบ rustlings ไม่ใช่อ่านเอกสารเฉยๆ; ค่าอยู่ที่แคตตาล็อกนี้มีคอร์สฝั่งเขียนโปรแกรมบนเชนเยอะแล้วแต่**ฝั่ง client ที่เป็น Rust หายาก** ส่วนใหญ่เป็น TypeScript; ข้อควรระวัง ★16 คนทำคนเดียว push ล่าสุด พ.ค. 2026 และ **ไม่มี license** ซึ่งแปลว่าตามกฎหมายเอาไปใช้ต่อไม่ได้ ต้องถามเจ้าของก่อนถ้าจะเอาไปดัดแปลงเป็นเนื้อหาสอน
  <sub>rust, client-side, vscode, exercises, interactive</sub>
- [Solana Stack Exchange — คลังคำถามที่ค้นได้ (แต่คนตอบน้อย)](https://solana.stackexchange.com/)
  ถาม-ตอบแบบ Stack Exchange ที่ค้นย้อนหลังได้และมี API สาธารณะ — ตัวเลขจริงจาก api.stackexchange.com วันที่ 6 ส.ค. 2026: คำถาม 8,226 · คำตอบ 9,606 · ผู้ใช้ 50,119; **แต่ต้องรู้ก่อนส่งให้มือใหม่** — ไม่มีคำตอบเลย 1,750 ข้อ (21%) และมีคำตอบที่เจ้าของรับแล้วแค่ 34% เฉลี่ยคำตอบต่อคำถาม 1.17 · คำถาม 3 อันล่าสุด (26 ก.ค. / 27 ก.ค. / 3 ส.ค.) ยังไม่มีคำตอบสักข้อ **ใช้เป็นคลังค้นของเก่าได้ดี แต่อย่าบอกคนใหม่ว่าถามแล้วจะได้คำตอบ** ให้ไป Discord หรือ forum เร็วกว่า; มุมกลับที่น่าสนใจ — 1,750 คำถามค้างคือช่องสร้างชื่อที่ต้นทุนต่ำสำหรับคนไทยที่รู้เรื่องนั้นจริง ตอบแล้วเป็นผลงานที่ค้นเจอถาวรและอ้างอิงได้ ต่างจากตอบใน Discord ที่หายไปใน 3 วัน
  <sub>qa, stackexchange, archive, unanswered, api</sub>
- [Solana Curriculum — สื่อการสอนทางการสำหรับมหาวิทยาลัยและ bootcamp](https://github.com/solana-foundation/curriculum) `official`
  ชุดสื่อการสอน Solana ที่ Foundation ทำให้มหาวิทยาลัยและ bootcamp เอาไปใช้ (★193) มี 7 คอร์ส — blockchain-basics, rust-basics-for-solana-development, anchor-and-programs, spl-tokens-2022-and-extensions, web-for-solana-development-101, web3-solana-starter-pack, defi-on-jupiter แต่ละคอร์สมี course-plan แยก; **นี่คือของที่ตรงกับงาน community operator มากที่สุดในแคตตาล็อกทั้งหมด** เพราะไม่ต้องออกแบบหลักสูตรเองตั้งแต่ต้น หยิบโครงมาปรับเป็นภาษาไทยแล้วต่อกับ quest ของ Genesis ได้เลย; **ข้อควรระวังสองข้อ** — ไม่มี license ตามกฎหมายจึงเอาไปดัดแปลงไม่ได้จนกว่าจะถาม (ปัญหาเดียวกับ solana-rust-vscode-course) และ push ล่าสุด ม.ค. 2026 คือเงียบมา 7 เดือน ต้องเช็คว่าเนื้อหายังตรงกับ Anchor 1.0 และ Kit หรือยังก่อนเอาไปสอน
  <sub>curriculum, teaching, workshop, course-plan, university</sub>

## Program Frameworks — Anchor / Pinocchio / native

- [solana-developers/program-examples](https://github.com/solana-developers/program-examples) `official`
  ตัวอย่าง program แยกตาม pattern — วัตถุดิบชั้นดีสำหรับทำ quest
  <sub>examples, anchor, native</sub>
- [QuickNode — solana-program-examples](https://github.com/quicknode/solana-program-examples) `vendor`
  ตัวอย่าง program สาย Anchor อีกชุด ใช้เสริมกับของ solana-developers ที่เป็นตัวหลัก — repo ยัง active (push ล่าสุด 4 ส.ค. 2026)
  <sub>examples, tested</sub>
- [Anchor Documentation](https://www.anchor-lang.com/) `official`
  ปัจจุบัน Anchor 1.0 แล้ว (เครื่องคุณ = anchor-cli 1.0.2)
  <sub>anchor, docs, canonical</sub>
- [Anchor Repository](https://github.com/solana-foundation/anchor) `official`
  URL นี้ 301 ไป github.com/otter-sec/anchor แล้ว (crates.io ของ anchor-lang ก็ชี้ otter-sec) แต่ anchor-lang.com ยังลิงก์ solana-foundation อยู่ — คงไว้แบบนี้เพราะ 301 ยังพาไปถึง แต่ต้องรู้ว่าคนดูแลจริงเปลี่ยนแล้ว
  <sub>anchor, github</sub>
- [Anchor Version Manager (AVM)](https://www.anchor-lang.com/docs/avm) `official`
  ตัวสลับเวอร์ชัน Anchor — สำคัญมากกับงานตารางความเข้ากันได้ที่ตั้งเป็นธง เพราะทำให้ทดสอบหลายสายได้โดยไม่ต้องถอนของเดิม เครื่องเจ้าของติดตั้ง 1.0.2 อยู่และไม่ควรอัปทับ ให้ใช้ AVM เพิ่มสายอื่นแทน
  <sub>anchor, versioning</sub>
- [Anchor v0.32 → v1 Migration Guide](https://github.com/solana-foundation/solana-dev-skill/blob/main/skills/solana-dev/references/anchor/migrating-v0.32-to-v1.md) `official`
  สำคัญมาก — tutorial เก่าเกือบทั้งหมดยังเป็น 0.3x
  <sub>anchor, migration, breaking-change</sub>
- [Pinocchio](https://github.com/anza-xyz/pinocchio) `anza`
  zero-dependency zero-copy ลด CU ได้ 88–95% เทียบ Anchor
  <sub>pinocchio, zero-copy, performance</sub>
- [Pinocchio Guide](https://github.com/vict0rcarvalh0/pinocchio-guide)
  คู่มือ Pinocchio จากชุมชน — ระวัง: repo ไม่ถูกแตะตั้งแต่ 27 ม.ค. 2026 ขณะที่ตัว Pinocchio เองยังพัฒนาต่อ เทียบกับ repo ทางการก่อนเชื่อรายละเอียด API
  <sub>pinocchio, tutorial</sub>
- [Helius — How to Build with Pinocchio](https://www.helius.dev/blog/pinocchio) `vendor`
  สอนเขียนโปรแกรมด้วย Pinocchio พร้อมเทียบกับ Anchor และ Steel ตรงๆ และมีตัวอย่างสร้าง token — เป็นบทความที่ตอบคำถาม "จะเลือกเฟรมเวิร์กไหน" ได้ดีที่สุดในลิสต์ เพราะเทียบให้เห็นทั้งสามฝั่งแทนที่จะเชียร์ตัวเดียว
  <sub>pinocchio, article</sub>
- [Solana Optimized Programs](https://github.com/Laugharne/solana_optimized_programs)
  ถอดเทปวิดีโอเรื่องการรีดประสิทธิภาพโปรแกรม — compute, storage, data พร้อมเทียบ Anchor กับ Pinocchio และลงถึงระดับ assembly; ★9 push ล่าสุด พ.ค. 2025 เป็นของเก่ากว่าตัวอื่นในหมวด ใช้เอาแนวคิด อย่าลอกโค้ดตรงๆ โดยไม่เช็คเวอร์ชัน
  <sub>optimization, cu</sub>
- [sBPF Assembly SDK](https://github.com/blueshift-gg/sbpf)
  เครื่องมือ bootstrap/build/deploy โปรแกรม sBPF assembly (Rust ★127 ยัง active) — สำหรับงานที่ต้องรีด compute unit จนสุดทางซึ่งจะสำคัญขึ้นมากถ้า SGP-0003 ผ่าน เพราะค่า fee จะผูกกับ CU ที่ขอ; ไม่ใช่ของสำหรับมือใหม่
  <sub>sbpf, assembly, advanced</sub>
- [Compatibility Matrix (ของ Foundation)](https://github.com/solana-foundation/solana-dev-skill/blob/main/skills/solana-dev/references/compatibility-matrix.md) `official`
  ตารางความเข้ากันได้ทางการ 15 KB ครอบ Anchor 0.29 ถึง 1.1.x, Solana CLI 1.16-4.1, Platform Tools, GLIBC รายดิสโทร, และเวอร์ชัน litesvm ฝั่ง Rust/node — น่าอายที่ repo นี้เพิ่งเพิ่มวันนี้ทั้งที่เป็นวัตถุดิบหลักของงานตารางเวอร์ชันที่ตั้งเป็นเป้าไว้เอง; สิ่งที่ตารางนี้ไม่มีและเป็นช่องที่เหลือให้ทำจริงคือแกน @solana/kit และ web3.js v3 กับการยืนยันบน macOS (ของเขาอิง Debian)
  <sub>version, anchor, toolchain, compatibility, matrix</sub>

## Client SDK — Kit, web3.js, scaffolding

- [Solana Templates](https://solana.com/developers/templates) `official`
  เทมเพลตพร้อมใช้สำหรับ dApp, DeFi, NFT marketplace — ประหยัดขั้นตอนตั้งโครงที่มักพาคนใหม่ไปติดกับ config ก่อนได้เขียนอะไรเลย; เช็คก่อนว่าเทมเพลตที่หยิบใช้ web3.js v1 หรือ Kit เพราะยังมีทั้งสองแบบปนกันในระบบนิเวศ
  <sub>scaffold, starter</sub>
- [Solana Kit Docs](https://www.solanakit.com/) `anza`
  SDK มาตรฐานปัจจุบัน — tree-shakable zero-dependency แทน web3.js v1
  <sub>kit, typescript, canonical</sub>
- [@solana/kit repository](https://github.com/anza-xyz/kit) `anza`
  โค้ดต้นทางของ Kit ที่ Anza ดูแลเอง — อ่านคู่กับ solanakit.com ที่เป็นเอกสาร ใช้ repo นี้เวลาต้องดู source / issue / changelog จริง
  <sub>kit, github</sub>
- [Kit Plugins](https://github.com/anza-xyz/kit-plugins) `anza`
  rpc, signer, wallet, litesvm, instruction-plan
  <sub>kit, plugins</sub>
- [JavaScript/TypeScript client docs (Kit + client + React hooks)](https://solana.com/docs/clients/official/javascript) `official`
  URL ที่ curated list ของ Foundation ระบุไว้ (/docs/clients/kit) ตาย 404 — อันนี้คือของจริง ครอบคลุม @solana/kit, @solana/client และ React hooks
  <sub>kit, docs, react</sub>
- [Rust client docs](https://solana.com/docs/clients/official/rust) `official`
  รายการ crate ทางการฝั่ง Rust แยกเป็นกลุ่มชัด: client / program / interface / การเซ็นและจัดการกุญแจ — ใช้ตอนต้องเลือกว่าจะ import ตัวไหนแทนการเดาจากชื่อ ซึ่งพลาดง่ายเพราะ crate ตระกูล solana-* ถูกแยกย่อยใหม่หลังยุค monorepo
  <sub>rust, client</sub>
- [@solana/web3.js v3.x](https://github.com/solana-foundation/solana-web3.js/tree/v3.x) `official`
  v3 = API แบบคลาสสิกแต่รันบนไส้ใน Kit — v1 อยู่ maintenance (security fix เท่านั้น)
  <sub>web3js, v3</sub>
- [web3.js v1 → v3 Migration Guide](https://github.com/solana-foundation/solana-web3.js/blob/v3.x/docs/web3js-v1-to-v3-migration.md) `official`
  คู่มือย้ายจาก web3.js v1 ไป v3 อย่างเป็นทางการ — เป็นวัตถุดิบหลักของงานตารางความเข้ากันได้ที่ตั้งเป็นธง เพราะเป็นคลื่นที่สองที่ทำให้ tutorial เก่ารันไม่ผ่าน; อ่านคู่กับ compatibility-matrix ของ Foundation ซึ่งครอบฝั่ง Anchor แต่ไม่ครอบฝั่งนี้
  <sub>migration, web3js</sub>
- [Sunrising web3.js — ทำไม TS ecosystem ถึงกลับมารวมกัน](https://blueshift.gg/research/sunrising-web3js-reuniting-solanas-typescript-ecosystem)
  อ่านตัวนี้ก่อนตัดสินใจว่าโปรเจกต์จะใช้ Kit หรือ web3.js v3
  <sub>context, article</sub>
- [create-solana-dapp](https://github.com/solana-foundation/create-solana-dapp) `official`
  ตัวสร้างโครงโปรเจกต์ที่เร็วที่สุดสำหรับเริ่มแอป Solana (★643 push วันนี้ 6 ส.ค. 2026 ยัง active มาก) — เลือกเทมเพลตแล้วได้โครงที่รันได้ทันที ไม่ต้องต่อ config เอง เชื่อมกับ solana-foundation/templates; **หมายเหตุเรื่อง URL — repo ย้ายจาก org solana-developers มาอยู่ solana-foundation แล้ว** ลิงก์เก่ายัง redirect มาถูกที่ แต่แคตตาล็อกอัปเดตเป็นปลายทางจริงแล้วเพื่อไม่ให้พึ่ง redirect ที่วันหนึ่งอาจหาย; ก่อนใช้เช็คว่าเทมเพลตที่เลือกใช้ web3.js v1 หรือ Kit เพราะยังมีทั้งสองแบบปนกันในระบบนิเวศ
  <sub>scaffold, cli</sub>
- [Open Wallet Standard — เซ็นแบบมีนโยบายกำกับ รันในเครื่อง](https://github.com/open-wallet-standard/core)
  มาตรฐานเปิดสำหรับจัดการกระเป๋าและเซ็นธุรกรรมที่รันในเครื่อง โดยมีชั้นนโยบายกำกับว่าอะไรเซ็นได้บ้าง รองรับหลายเชนไม่ใช่แค่ Solana (Rust, MIT, ★363, สร้าง ก.พ. 2026 push ก.ค. 2026); **เกี่ยวกับสายที่เก็บมาสองวันโดยตรง** — พอ agent เริ่มถือเงินและรับงานได้ (Agent Registry, Superteam Earn, pay.sh, payment-channels) คำถามถัดมาคือจะให้มันเซ็นอะไรได้บ้างโดยไม่ต้องมอบกุญแจทั้งดอก ตัวนี้ตอบข้อนั้น ต่อกับ spend-permissions ในหมวด payments ที่ทำเรื่องเดียวกันแต่ระดับ token; ยังไม่ได้ตรวจว่ามีใครใช้ใน production จริงหรือยัง ★363 บ่งว่ามีคนสนใจแต่ไม่ได้บอกว่าใช้จริง
  <sub>wallet, signing, policy, multi-chain, rust, agent</sub>

## Testing — LiteSVM, Mollusk, Surfpool

- [Surfpool Docs](https://solana.com/docs/tools/surfpool/) `official`
  fork mainnet ได้ + cheatcode — เหมาะกับ workshop ที่ไม่อยากรอ airdrop
  <sub>surfpool, mainnet-fork, cheatcodes</sub>
- [Surfpool Repository](https://github.com/solana-foundation/surfpool) `official`
  fork mainnet มารันในเครื่องพร้อม cheatcode (Rust ★581 active) — แก้ปัญหาเวิร์กช็อปที่ต้องใช้สภาพจริงของ mainnet แต่ไม่อยากพึ่งเครือข่าย ต่างจาก LiteSVM ตรงได้สถานะจริงของโปรแกรมที่ deploy อยู่แล้วมาเล่นด้วย
  <sub>surfpool, github</sub>
- [LiteSVM](https://github.com/LiteSVM/litesvm)
  เร็วกว่า solana-test-validator หลายเท่า มีทั้ง crate และ npm
  <sub>litesvm, fast-test</sub>
- [LiteSVM Docs](https://solana.com/docs/tools/litesvm) `official`
  เอกสารทางการของ LiteSVM — รันโปรแกรมในโปรเซสเดียวกันเลย ไม่ต้องมี validator ไม่ต้องรอเครือข่าย มีทั้งฝั่ง Rust และ TypeScript; นี่คือตัวที่ทำให้เวิร์กช็อป 40 คนไม่ต้องแย่ง airdrop กัน อ่านหน้านี้ก่อน repo เพราะสรุปการติดตั้งกับข้อจำกัดไว้ครบกว่า
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
  อธิบายว่า IDL คือ JSON ที่บรรยายโปรแกรม ใช้ decode instruction กับ account และ generate client หลายภาษาได้โดยไม่ต้องอ่านซอร์ส — มีทั้งฝั่ง Anchor และฝั่งที่ไม่ใช้ Anchor ซึ่งหายากกว่า; อ่านหน้านี้ก่อนเข้าเครื่องมือ codegen ตัวอื่นในหมวดเดียวกัน จะเข้าใจว่าแต่ละตัวทำอะไรกับ IDL
  <sub>idl, concept</sub>
- [Shank (Metaplex)](https://github.com/metaplex-foundation/shank)
  ดึง IDL จาก native program ที่ไม่ได้ใช้ Anchor
  <sub>idl, native-program</sub>

## Tokens & NFT — SPL, Token-2022, Metaplex

- [SPL Token Documentation](https://spl.solana.com/token) `official`
  เอกสารอ้างอิงของ SPL Token โปรแกรมเดิม — อ่านเมื่อทำงานกับ mint/account ที่สร้างมานานแล้วหรือต้องเข้าใจ interface ระดับ instruction; ของใหม่ควรเริ่มที่ Token-2022 แทน และหมายเหตุว่า URL นี้ redirect ไป solana-program.com แล้ว ลิงก์เดิมยังใช้ได้แต่ปลายทางย้ายบ้าน
  <sub>spl, token</sub>
- [Token-2022 Documentation](https://spl.solana.com/token-2022) `official`
  รุ่นที่ต่อยอด SPL Token ด้วย extension — เป็นตัวที่ควรใช้กับของใหม่ทุกกรณี เพราะฟีเจอร์อย่าง transfer hook, confidential transfer, metadata ในตัว อยู่ที่นี่ทั้งหมด; หน้ามีหัวข้อ Security Audits แยกให้ด้วย ใช้ตอบคำถามว่าปลอดภัยพอไหมได้ตรงๆ ต่างจากเอกสารส่วนใหญ่ที่ต้องไปหาเอง
  <sub>token-2022, extensions</sub>
- [Tokenized Assets (docs)](https://solana.com/docs/tokenization) `official`
  หน้าแม่ของสาย tokenization ฝั่งทางการ ครอบ stablecoin และ RWA พร้อมกลไกคุมการโอน ความเป็นส่วนตัว และการชำระราคา — มุมนี้เขียนสำหรับคนที่ต้องคุยเรื่อง compliance ไม่ใช่คนที่จะ mint เล่น ใช้เป็นตัวตั้งเวลาคุยกับองค์กรหรือหน่วยงานที่ถามเรื่องกฎก่อนถามเรื่องโค้ด
  <sub>rwa, tokenization</sub>
- [Token-2022 Launch Quickstart](https://solana.com/docs/tokenization/quickstart) `official`
  พา mint Token-2022 แบบพร้อมใช้กับงานที่มีข้อกำหนดในราว 10 นาทีบนเครือข่ายในเครื่อง ได้ metadata, หยุดการโอนได้, permanent delegate และบัญชีที่ freeze ไว้เป็นค่าเริ่มต้นครบในตัวอย่างเดียว — เป็นบทเปิดเวิร์กช็อปสาย token ที่ดีที่สุดเพราะเห็นของจริงเร็วและต่อยอดไปหน้าแม่ได้
  <sub>token-2022, quickstart</sub>
- [Metaplex Developer Docs](https://developers.metaplex.com/)
  ศูนย์รวมเอกสารของ Metaplex — token, NFT, smart contract, dev tool และสาย agent อยู่ที่เดียว ใช้เมื่อทำงาน NFT ที่เกินกว่าที่ SPL ให้ เช่น collection, royalty, compression; หมายเหตุ URL นี้ redirect ไป metaplex.com/docs แล้ว
  <sub>nft, core, bubblegum, candy-machine, umi</sub>
- [Collector Crypt — การ์ดสะสมจริงบนเชน](https://collectorcrypt.com/) `vendor`
  ตัวอย่างที่ชัดที่สุดของ RWA สาย longtail บน Solana — เอาการ์ด Pokemon/กีฬาจริงเข้าตู้เซฟแล้ว mint เป็น NFT ถอนกลับเป็นของจริงได้ตลอด ต้องผ่านการเกรดจาก PSA/BGS/CGC ก่อน เก็บในคลังควบคุมอุณหภูมิของ PWCC/ALT พร้อมประกัน; ตัวเลข มิ.ย. 2026 ปริมาณซื้อขายสะสม ~$1.3B รายได้โปรโตคอลสะสม >$64M และ พ.ค. 2026 มีการ์ดในตู้เกิน 130,000 ใบ ค่าธรรมเนียมผู้ขาย 2% (แพลตฟอร์ม 1% + royalty 1%) จุดที่ดังคือ Gacha Machine ที่จำลองการเปิดซองแบบสุ่ม; ค่าสำหรับเราคือใช้เป็นเคสสอนว่า tokenization ที่มีของจริงหนุนหลังหน้าตาเป็นยังไง จับต้องได้กว่าอธิบาย RWA ด้วยพันธบัตร และคนไทยที่เล่นการ์ดมีเยอะ เข้าใจได้ทันทีโดยไม่ต้องอธิบายคริปโตก่อน
  <sub>rwa, longtail, collectibles, vault, gacha, redeem</sub>
- [Beezie — ของสะสมและสินค้าหรูบนเชน](https://beezie.com/) `vendor` `blocked`
  ตลาดของสะสมที่ tokenize การ์ดที่ผ่านการเกรด สินค้า sealed รองเท้า และเพิ่งเปิดหมวดสินค้าหรู — ขึ้น Solana ไตรมาส 2 ปี 2026 (เดิมอยู่ Flow แล้วไป Base ทำปริมาณได้ $100M) เก็บของในคลังระดับสถาบัน ถอนของจริงได้ทั่วโลก ผ่านการเกรดจาก PSA/BGS/CGC เหมือนกัน; ตัวเลขที่ประกาศเอง รายได้ประจำต่อปี >$142M, claw pull 540,000+ ครั้ง, ซื้อคืนทันที 530,000+ ครั้ง อัตราซื้อคืนราว 90%; หมายเหตุ beezie.io 301 ไป beezie.com แล้ว และตัวเลขทั้งหมดเป็นของบริษัทเอง ยังไม่มีแหล่งกลางยืนยัน ต่างจาก Collector Crypt ที่มีข้อมูลบนเชนให้ตรวจ
  <sub>rwa, longtail, collectibles, luxury, vault, multichain</sub>

## Payments & Commerce

- [Solana Pay](https://docs.solanapay.com/) `official`
  สเปคและ reference implementation ของ Solana Pay — มาตรฐาน URL/QR สำหรับรับเงิน มีรายชื่อกระเป๋าที่รองรับอยู่ในนั้นด้วย ซึ่งเป็นข้อมูลที่ต้องดูก่อนตัดสินใจใช้จริงเพราะถ้ากระเป๋าที่ผู้ใช้ไทยใช้ไม่รองรับก็จบ; สำหรับของใหม่ปี 2026 ควรเทียบกับ Commerce Kit และ payment button ในหมวดเดียวกันก่อนเลือก
  <sub>payment, qr</sub>
- [Payments docs](https://solana.com/docs/payments) `official`
  หน้าแม่ของหมวด payments ทั้งหมด 32 หน้า — จุดตั้งต้นก่อนลงหน้าย่อย และเป็นที่ที่ตัวเลขทางการอย่างค่าธรรมเนียมต่ำกว่า $0.001 กับการชำระราคาแบบทันทีถูกเขียนไว้ให้อ้างได้; ในแคตตาล็อกเก็บหน้าย่อยที่มีเนื้อจริงไว้ 13 หน้า ส่วนที่เหลือบันทึกเหตุผลไว้ใน rejected.yml แล้ว
  <sub>payment, checkout</sub>
- [Kora (gasless/relayer)](https://solana.com/docs/tools/kora) `official`
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
- [solana-foundation/pay — CLI ของ x402](https://github.com/solana-foundation/pay) `official`
  โค้ดของ CLI ที่อยู่เบื้องหลัง pay.sh (Rust, MIT, ★1,746 push ทุกวัน) รองรับสามมาตรฐานคือ x402, MPP และ AP2 — เก็บแยกจาก pay.sh เพราะหน้าเว็บบอกวิธีใช้ ส่วน repo บอกว่ามันทำงานยังไงและรองรับอะไรบ้าง; ดาว 1,746 บนเครื่องมือที่เพิ่งออกแปลว่าสายจ่ายเงินให้ agent กำลังมาจริง ไม่ใช่ของทดลอง
  <sub>x402, mpp, ap2, cli, rust, agentic</sub>
- [Solana Private Channels (payment channel ระดับองค์กร)](https://github.com/solana-foundation/solana-private-channels) `official`
  payment channel ที่ต่อสภาพคล่องกับ mainnet โดยตรง ทำธุรกรรมนับพันรายการแบบทันทีพร้อมคุมสิทธิ์และความเป็นส่วนตัว — ประกอบด้วย core ที่ทำ 5 ขั้น (ตัดซ้ำ ตรวจลายเซ็น จัดลำดับ ประมวลผล settle), โปรแกรม escrow/withdraw, indexer และ gateway; ใช้ Token-2022 confidential transfer กับ ZK proof ตอนถอนได้ ซึ่งเชื่อมกับหมวด tokens-nft; **ระวัง repo ประกาศเองว่ายังไม่ผ่าน audit และยังพัฒนาอยู่ ห้ามใช้กับเงินจริง** เก็บไว้อ่านว่า Foundation ออกแบบชั้น privacy ฝั่งองค์กรยังไง ไม่ใช่เอาไปใช้
  <sub>payment-channel, privacy, token-2022, zk, experimental, rust</sub>
- [payment-channels — primitive จ่ายเงินให้ agent (ยังไม่เสร็จ)](https://github.com/solana-foundation/payment-channels) `official`
  primitive สำหรับการจ่ายเงินแบบ agentic รองรับ x402 กับ MPP — **README ขึ้นธง 🚧 Work in progress เอง** ★4 สร้าง เม.ย. 2026 แต่ push วันนี้ (6 ส.ค. 2026) แปลว่ายังทำอยู่จริงไม่ใช่ของทิ้ง; **อย่าสับสนกับ solana-private-channels ที่เก็บไว้แล้ว** — ตัวนั้น ★61 เป็น payment channel ระดับองค์กรที่เน้นความเป็นส่วนตัวและ throughput ส่วนตัวนี้เป็น primitive ฝั่ง agentic payment คนละโจทย์กัน; เก็บเพราะเป็นชิ้นที่หายไปในภาพรวมสาย agent ที่เก็บมาทั้งวัน (Agent Registry ให้ตัวตน · Earn ให้งาน · pay.sh ให้จ่าย) ตัวนี้คือชั้น primitive ที่อยู่ใต้ pay.sh อีกที — **ยังใช้ทำอะไรจริงไม่ได้ เก็บไว้ดูทิศทาง ไม่ใช่เอาไปใช้**
  <sub>x402, mpp, agentic, payment-channel, rust, wip</sub>

## Security & Audit

- [Ackee — Solana Auditors Bootcamp](https://github.com/Ackee-Blockchain/Solana-Auditors-Bootcamp)
  ฟรี + มี cert สาย security โดยเฉพาะ
  <sub>audit, free, certificate</sub>
- [Blueshift — Program Security Course](https://learn.blueshift.gg/en/courses/program-security)
  คอร์สความปลอดภัยระดับโปรแกรม ครอบเรื่องที่พลาดกันบ่อยที่สุด — ตรวจเจ้าของ account, การคุมสิทธิ์, และ CPI; ต่างจากบล็อกความปลอดภัยทั่วไปตรงเป็นคอร์สมีลำดับและมีแบบฝึก เหมาะให้คนที่เขียน Anchor เป็นแล้วแต่ยังไม่เคยคิดเรื่องคนโจมตี
  <sub>security, course, free</sub>
- [Solana Dev Skill — Security Checklist](https://github.com/solana-foundation/solana-dev-skill/blob/main/skills/solana-dev/references/security.md) `official`
  checklist สั้นๆ ที่ใช้รีวิว PR ได้จริง
  <sub>checklist, signer, account-validation</sub>
- [Trident Arena (AI security scan)](https://tridentarena.xyz)
  จากทีม School of Solana — scan หา logic flaw เฉพาะทาง Solana
  <sub>ai, audit, scanner</sub>
- [Neodyme Blog](https://neodyme.io/en/blog/)
  บล็อกของทีม audit ที่เจาะ Solana โดยเฉพาะ — เขียนถึงช่องโหว่จริงที่เคยเจอในโปรแกรมจริง ใช้เป็นวัตถุดิบสอนว่าโค้ดพังหน้าตาเป็นยังไง ซึ่งมีน้ำหนักกว่าการท่องรายการ best practice; อ่านคู่กับคอร์สความปลอดภัยของ Blueshift ในหมวดเดียวกัน
  <sub>audit, writeup, exploit</sub>
- [Helius — ZK proof ตอนที่ 1: พื้นฐาน](https://www.helius.dev/blog/zero-knowledge-proofs-an-introduction-to-the-fundamentals) `vendor`
  บทความยาวมาก (ข้อความล้วนราว 67,000 ตัวอักษร) ปูพื้น zero-knowledge proof ตั้งแต่ต้น — เป็นตอนที่ 1 ของสองตอน ตอนที่ 2 ว่าด้วยการใช้งานบน Solana โดยเฉพาะ; **อ่านตัวนี้ก่อนถ้ายังไม่เคยแตะ ZK** เพราะเนื้อหาฝั่ง Solana อย่าง Token-2022 confidential transfer, ZK compression ของ Light Protocol และ private channels สมมติว่าผู้อ่านรู้พื้นฐานแล้วทั้งหมด; เป็นของ vendor แต่เขียนแบบสอนไม่ใช่ขายของ ยาวขนาดนี้เอามาย่อยเป็นคอนเทนต์ไทยได้หลายตอน
  <sub>zk, cryptography, fundamentals, longform, explainer</sub>
- [Helius — ZK proof ตอนที่ 2: ใช้จริงบน Solana](https://www.helius.dev/blog/zero-knowledge-proofs-its-applications-on-solana) `vendor`
  ตอนที่ 2 ต่อจากพื้นฐาน — ว่าด้วยว่า ZK ถูกใช้จริงตรงไหนบน Solana; **ตัวนี้คือสะพานที่หายไป** ระหว่างทฤษฎีกับของที่เก็บไว้ในแคตตาล็อกแล้ว: Token-2022 confidential transfer, ZK compression ของ Light Protocol, และ solana-private-channels ที่ใช้ ZK proof ตอนถอนเงิน ทั้งสามตัวนั้นสมมติว่าผู้อ่านรู้แล้วว่า ZK ทำงานยังไง; อ่านคู่กับตอนที่ 1 ตามลำดับ อย่าข้ามมาอ่านตัวนี้ก่อน
  <sub>zk, solana, applications, confidential-transfer, compression</sub>

## AI / Agent Skills / MCP

- [Metaplex Agent Skill (official)](https://github.com/metaplex-foundation/skill)
  skill ทางการของ Metaplex สำหรับงาน NFT/token — ตัวอย่างของ skill ที่ผูกกับโปรโตคอลเดียว ซึ่งเป็นรูปแบบที่ skill ในระบบนิเวศเกือบทั้งหมดเป็นอยู่ตอนนี้ ใช้เป็นแบบอ้างอิงโครงสร้างเวลาจะทำของตัวเอง
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
  สเปคกลางของ Agent Skills — บอกโครงไดเรกทอรีและรูปแบบ SKILL.md ที่ต้องเขียน; อ่านตัวนี้ก่อนลงมือทำ skill ของตัวเอง จะได้ไม่ต้องรื้อ packaging ทีหลัง มาตรฐานยังใหม่และเปลี่ยนได้ แต่สิ่งที่เปลี่ยนคือวิธีห่อ ไม่ใช่เนื้อหาข้างใน
  <sub>spec, standard</sub>
- [skills.sh (discovery + installer)](https://www.skills.sh/)
  ไดเรกทอรีรวม skill ของ agent พร้อมตัวติดตั้ง มี leaderboard ให้ดูว่าตัวไหนคนใช้จริง — ใช้สำรวจว่าช่องไหนมีคนทำแล้วก่อนลงแรงทำซ้ำ ซึ่งเป็นขั้นตอนที่ควรทำก่อนเริ่ม skill สาย education ตามที่เขียนไว้ใน OPPORTUNITIES
  <sub>registry, installer</sub>
- [Solana Agent Kit](https://github.com/sendaifun/solana-agent-kit)
  ตัวเชื่อม agent เข้ากับโปรโตคอลบน Solana ★1,704 เป็นตัวที่คนใช้มากที่สุดในสายนี้ — แต่ push ล่าสุด พ.ค. 2026 ห่างจากตัวอื่นในหมวดเดียวกันที่ยังขยับทุกสัปดาห์ ต้องเช็คว่ารองรับ Kit/web3.js v3 แล้วหรือยังก่อนเริ่มโปรเจกต์ใหม่
  <sub>agent, 30-protocols, langchain</sub>
- [SendAI Skills (DeFi/infra skill รวม)](https://github.com/sendaifun/skills)
  ตลาดรวม skill สาย Solana สำหรับ agent (★122) — ที่ที่ควรไปดูก่อนว่ามีคนทำ skill ที่คิดอยู่แล้วหรือยัง และเป็นช่องเผยแพร่ที่เข้าถึงง่ายกว่าการรอขึ้น solana.com/skills
  <sub>skills, defi, jupiter, raydium, kamino</sub>
- [solana-ai-kit (CLAUDE.md/agents/hooks)](https://github.com/solanabr/solana-ai-kit)
  ชุด config Claude Code สำหรับ Solana — เทียบกับของเราแล้วหยิบของดีมาใช้ได้
  <sub>claude-code, config, template</sub>
- [Helius core-ai skills](https://github.com/helius-labs/core-ai) `vendor`
  ชุดเครื่องมือ AI ทางการของ Helius (TypeScript ★24 ยัง active ส.ค. 2026) — มุมของผู้ให้บริการ RPC ที่ทำ tooling ให้ agent เรียกข้อมูลบนเชน ใช้เทียบกับ MCP ทางการว่าใครครอบอะไร ก่อนตัดสินใจว่าจะพึ่งเจ้าไหน
  <sub>skill, rpc, das, svm-internals</sub>
- [QuickNode — Solana Finance Claude Plugin](https://github.com/quicknode/solana-finance-claude-plugin) `vendor`
  แก้ 4 ส.ค. 2026 — URL เดิม quiknode-labs/solana-anchor-claude-skill 301 มาที่นี่ และของเปลี่ยนไปแล้วจริงๆ ไม่ใช่แค่ย้ายบ้าน ชื่อเดิมในแคตตาล็อกจึงชี้ผิดของ
  <sub>skill, plugin, finance, claude</sub>
- [Orquestra (IDL → REST + MCP)](https://github.com/berkayoztunc/orquestra)
  แปลง IDL ของโปรแกรมเป็น REST API และ MCP server ให้อัตโนมัติ (TypeScript ★21) — ตัดงานเขียน wrapper ด้วยมือทิ้งทั้งขั้น เหมาะกับตอนอยากให้ agent คุยกับโปรแกรมที่เพิ่ง deploy โดยไม่ต้องทำ client เอง; ของ community เจ้าเดียว ยังไม่มี audit ใช้กับ devnet ก่อน
  <sub>idl, rest-api, mcp</sub>
- [solana.com llms.txt (ดัชนีเอกสารสำหรับ AI)](https://solana.com/llms.txt) `official`
  ดัชนี 514 หน้าเอกสารทางการพร้อมคำอธิบายบรรทัดเดียวต่อหน้า — ท่าที่ควรรู้และเช็คแล้วว่าใช้ได้จริง: เติม .md ท้าย URL ไหนก็ได้จะได้ markdown ดิบ (หรือส่ง header Accept: text/markdown ผลเท่ากัน) และมีดัชนีย่อยรายหมวด ขนาดต่างกันมากตามหมวด (วัดเอง 4 ส.ค. 2026: finance 471 byte, defi 1.4 KB, payments 5.5 KB, rpc 13.5 KB) ใช้ตัวย่อยตอนทำงานเรื่องเดียวจะประหยัด context กว่าดัชนีเต็ม 93 KB มาก; ตัวไฟล์เองบอกด้วยว่าโค้ดใน cookbook มาจากไฟล์ตัวอย่างที่เทสต์แล้ว ให้เชื่อมากกว่าเดาเอง
  <sub>llms-txt, markdown, context, agent, index</sub>
- [solana.com llms-full.txt (เอกสารทั้งชุดไฟล์เดียว)](https://solana.com/llms-full.txt) `official`
  เอกสารทั้งหมดรวมไฟล์เดียว 4.5 MB ~462,000 คำ — ใหญ่เกินกว่าจะโยนเข้า context ตรงๆ เหมาะกับ index ทำ RAG หรือ grep ออฟไลน์มากกว่า ถ้าจะให้ agent อ่านสดใช้ llms.txt ตัวดัชนีแล้วดึงเฉพาะหน้าที่ต้องการจะคุ้มกว่ามาก
  <sub>llms-txt, corpus, offline, rag</sub>
- [Superteam Earn สำหรับ AI agent](https://superteam.fun/earn/agents)
  Earn เปิดให้ agent ทำงานรับเงินได้จริง มี skill ทางการที่ superteam.fun/skill.md (v0.5.1) กับ heartbeat.md (v0.2.0) — flow คือ POST /api/agents ตั้งชื่อ agent แล้วได้ apiKey กับ claimCode กลับมา จากนั้นดึงงานที่ agent ทำได้จาก /api/agents/listings/live (กรอง type=bounty|project|hackathon และ deadline ได้) ส่งงานผ่าน /api/agents/submissions/create แล้ว **ให้มนุษย์ถือ claimCode ไปรับเงิน** เพราะ agent รับเงินเองไม่ได้; จำกัด 60 submission/ชั่วโมง และงานประเภท project บังคับใส่ Telegram ของมนุษย์; นี่คือคำตอบของช่องที่ค้างในเรดาร์ว่าทำไมนับ bounty ไม่ได้ — มี API อยู่จริงแต่ต้องลงทะเบียนก่อน ไม่ได้เปิดสาธารณะ (ยิงเปล่าๆ ได้ 401); และเป็นตัวอย่างรูปธรรมของสิ่งที่ OPPORTUNITIES 2.1 อยากทำ คือเผยแพร่ skill ให้ agent อ่านเอง
  <sub>agent, api, skill-md, bounty, autonomous, earn</sub>
- [Colosseum Copilot (skill สำหรับ Claude Code)](https://colosseum.com/copilot)
  skill ที่ติดตั้งเข้า Claude Code/Codex ได้ตรงๆ (npx skills add ColosseumOrg/colosseum-copilot — repo ★11 push ก.ค. 2026 ยังไม่ระบุ license) ใช้เอาไอเดียไปชนกับ **ผลงานแฮกกาธอน 5,400+ ชิ้น** บวกสินค้าคริปโต 6,300+ ตัวผ่าน The Grid และแหล่งวิจัยคัดแล้ว 65+ แห่ง (a16z Crypto, Multicoin, Electric Capital) เพื่อดูว่าไอเดียซ้ำกับใครแล้วบ้างและช่องว่างอยู่ตรงไหน; ค่าที่แท้จริงคือ **ใช้ลดความเสี่ยงก่อนกดนาฬิกา Eternal** — 4 สัปดาห์เต็มเวลาแล้วมาพบทีหลังว่ามีคนทำไปแล้วสามรอบคือความเสียหายที่เลี่ยงได้ด้วยการค้นครึ่งชั่วโมง; ต้องขอ token ก่อนใช้ หน้าเว็บไม่ระบุราคา ต้องเช็คก่อนแนะนำว่าฟรีหรือไม่
  <sub>skill, research, competitor-scan, hackathon-data, idea-validation</sub>
- [Solana Agent Registry (ตัวตนและชื่อเสียงของ agent บนเชน)](https://solana.com/agent-registry) `official`
  โปรโตคอลบนเชนที่ให้ AI agent มีตัวตนที่ยืนยันได้ ชื่อเสียงที่พกติดตัวไปได้ และโครงสร้างความน่าเชื่อถือ — ทำงานบน Solana และคุยกับมาตรฐาน ERC-8004 ฝั่ง Ethereum ได้ ลงทะเบียนครั้งละราว 0.009 SOL (~$0.81); ต่อกับสิ่งที่เก็บมาทั้งวันโดยตรง — Superteam Earn ให้ agent ทำงานได้แต่ต้องมีมนุษย์เคลมเงิน pay.sh ให้ agent จ่ายเงินได้ **ตัวนี้คือชั้นที่ตอบว่าแล้วจะเชื่อ agent ตัวไหนได้** ซึ่งเป็นคำถามที่เกิดขึ้นทันทีเมื่อ agent เริ่มถือเงินและรับงาน; มีสเปคกับ quickstart บน GitHub
  <sub>agent, identity, reputation, erc-8004, onchain, registry</sub>
- [Elfa AI / Iris — ข้อมูลเรียลไทม์สำหรับ agent สายการเงิน](https://elfa.ai) `vendor`
  โครงสร้างข้อมูลเรียลไทม์สำหรับ AI ที่ทำงานกับตลาดการเงิน นิยามตัวเองว่าเป็น "ระบบประสาทที่ส่งข้อมูลที่ถูกต้องไปถึงคนตัดสินใจในจังหวะที่ถูก" ตัวสแตกชื่อ Iris; **เกี่ยวกับเราตรงจังหวะ** — สปอนเซอร์เครดิต 4,500 USDC ให้คนที่สร้างบน Iris ในงาน Solana Blitz v7 ที่กำลังแข่งอยู่ ระบุว่าจำนวนจำกัดมาก่อนได้ก่อน; ยังไม่ได้ตรวจว่าเครดิตนั้นได้มายังไงเพราะลิงก์เป็น t.co ที่ curl ตามต่อไม่ได้ ต้องเปิดเบราว์เซอร์ — เก็บไว้เพราะเป็นตัวอย่างของชั้นข้อมูลที่ agent สายเทรดต้องพึ่ง ซึ่งเป็นช่องว่างที่แคตตาล็อกยังบาง
  <sub>realtime-data, agent, market-intelligence, sponsor</sub>

## Infra & RPC providers

- [Helius](https://www.helius.dev/) `vendor`
  ผู้ให้บริการ RPC/API ที่คนไทยใช้เยอะที่สุดเจ้าหนึ่ง มี LaserStream สำหรับข้อมูลสดและ Sender สำหรับส่งธุรกรรม เริ่มใช้ฟรีได้ — เก็บไว้เพราะเป็นตัวเลือกแรกที่คนถามถึงเวลาจะเลิกใช้ public RPC ควรเทียบกับ Triton และ QuickNode ก่อนตัดสินใจผูกยาว
  <sub>rpc, das, webhook, laserstream</sub>
- [Helius Blog](https://www.helius.dev/blog) `vendor`
  คุณภาพบทความสูงสุดในสาย Solana internals — ใช้เป็นวัตถุดิบสอนได้เลย
  <sub>article, deep-dive</sub>
- [QuickNode Solana Guides](https://www.quicknode.com/guides/solana-development) `vendor`
  คลังไกด์สอนทำทีละเรื่องของ QuickNode — จุดแข็งคือครอบงานย่อยที่เอกสารทางการข้าม เช่นสร้าง vanity address; เป็นเนื้อหาของ vendor ตัวอย่างจะผูกกับบริการเขาบ้าง อ่านเอาวิธีแล้วเปลี่ยน endpoint เองได้
  <sub>guides, rpc</sub>
- [Triton One](https://triton.one/) `vendor`
  ผู้ให้บริการ RPC และ validator ที่อยู่มาตั้งแต่ปี 2021 เคลม uptime 99.99% และเปิดโค้ดจริง — ตระกูล Yellowstone ทั้งหมดมาจากที่นี่ ซึ่งแปลว่าเลิกใช้บริการแล้วยังรันเองต่อได้ ต่างจากเจ้าอื่นที่ผูกกับแพลตฟอร์ม; อ่านคู่กับ entry Riptide/Shred และ Superbank ในหมวดเดียวกัน
  <sub>rpc, yellowstone-grpc</sub>
- [Chainstack — Solana tooling overview](https://docs.chainstack.com/docs/solana-tooling) `vendor`
  ภาพรวมเครื่องมือจากมุมผู้ให้บริการโหนด — ที่มีค่าคือมันอัปเดตตามของจริงปี 2026 แล้ว (ระบุ Anchor 1.0, @solana/kit, LiteSVM, Surfpool ชัดเจน) ต่างจากบทความรวมเครื่องมือส่วนใหญ่ที่ยังค้างยุค web3.js v1 ใช้เป็นตัวเช็คว่าตกอะไรไปบ้าง
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
- [MagicBlock — real-time engine (Ephemeral Rollups)](https://www.magicblock.xyz/) `vendor`
  แก้ปัญหาที่ Solana ยังทำไม่ได้ดีคือ latency ต่ำกว่าระดับ slot — ใช้ Ephemeral Rollup ดึง account ออกมารันในรันไทม์แยกชั่วคราวแล้ว settle กลับ เคลม block time 1ms และ end-to-end ต่ำกว่า 50ms รวมกับ TEE บน Intel TDX สำหรับงานที่ต้องปิดข้อมูล เป้าคือเกมหลายผู้เล่น เทรดความถี่สูง และงาน real-time; เปิดโค้ดที่ org magicblock-labs (82 repo) ตัวหลักคือ magicblock-validator, delegation-program, magicblock-engine-examples, hydra; **อัปเดต 5 ส.ค. 2026 — คำถามที่เคยค้างว่าขึ้น mainnet หรือยัง ตอบได้แล้วว่าขึ้นจริง** ยิง RPC ตรวจ Delegation Program (DELeGGv...) และ Ephemeral SPL Token (SPLxh1...) ได้ executable=true บน mainnet ทั้งคู่; เอกสารอยู่ docs.magicblock.gg ซึ่งมี llms.txt กับ skill.md ให้ agent อ่านตรงได้
  <sub>ephemeral-rollup, latency, tee, gaming, realtime, delegation</sub>
- [MagicBlock Docs — เริ่มที่ทำไมต้องใช้](https://docs.magicblock.gg/pages/get-started/introduction/why-magicblock) `vendor`
  เอกสารทางการของ MagicBlock — **มีชั้นที่เครื่องอ่านได้ครบทั้งสามแบบ** เติม .md ท้าย URL ได้ทุกหน้า, llms.txt เป็นดัชนีเอกสารทั้งชุด และ skill.md ที่ติดตั้งเข้า agent ได้ (agent skill ตัวที่สี่ที่เก็บในวันเดียว ต่อจาก MCP ทางการ, Superteam, Colosseum Copilot); ของที่แพลตฟอร์มมีจริงตาม skill.md — Ephemeral Rollup (SVM runtime แยกที่รันเร็วและไม่เก็บค่าธรรมเนียม), Private ER ที่ใช้ TEE, Ephemeral SPL Token, Solana VRF สำหรับสุ่มที่ตรวจสอบได้, Magic Router, Session Key และ price oracle · SDK คือ @magicblock-labs/ephemeral-rollups-sdk (Rust/Anchor + TS) มี CLI ephemeral-validator ไว้เทสในเครื่อง; **ตรวจ program ID บนเชนแล้วทั้งสองตัว executable จริงบน mainnet** — Delegation Program DELeGGvXpWV2fqJUhqcF5ZSYMS4JTLjteaAMARRSaeSh และ Ephemeral SPL Token SPLxh1LVZzEkX99H6rqYizhytLWPZVV296zyYDPagv2 ซึ่งตอบคำถามที่ค้างไว้ตอนเก็บ magicblock.xyz ว่าขึ้น mainnet แล้วหรือยัง
  <sub>docs, ephemeral-rollup, llms-txt, skill-md, vrf, tee</sub>

## Data & Analytics

- [Solana Explorer (first-party)](https://explorer.solana.com/) `official`
  explorer ทางการ — ใช้ตรวจธุรกรรมและ account แบบดิบที่สุด ไม่มีชั้นตีความเหมือน explorer ของ vendor ซึ่งสำคัญเวลาต้องยืนยันว่าอะไรเกิดขึ้นจริงบนเชน; เวลาสอนควรใช้ตัวนี้เพราะไม่ผูกกับบริการเจ้าไหน
  <sub>explorer</sub>
- [Solscan](https://solscan.io/) `vendor` `blocked`
  403 ตอน curl = กัน bot ไม่ใช่ลิงก์ตาย
  <sub>explorer, retail</sub>
- [Dune Analytics](https://dune.com/) `vendor` `blocked`
  fork dashboard คนอื่นได้ ประหยัดเวลามาก
  <sub>sql, dashboard, fork</sub>
- [DefiLlama — Solana](https://defillama.com/chain/Solana) `vendor` `blocked`
  TVL และภาพรวม DeFi ของ Solana จากแหล่งที่วัดทุกเชนด้วยวิธีเดียวกัน — จุดแข็งคือเทียบข้ามเชนได้อย่างยุติธรรม เลยน่าเชื่อกว่าเอาตัวเลขฝั่ง Solana มาพูดเอง ใช้คู่กับ Blockworks ในหมวดเดียวกัน; 403 ตอน curl เพราะกัน bot
  <sub>tvl, defi</sub>
- [Solana Compass](https://solanacompass.com/)
  มี transcript พอดแคสต์ให้ค้นด้วย — วัตถุดิบทำ content ดี
  <sub>projects, metrics, podcast-transcript</sub>
- [Helius — Analyzing Solana On-chain Data: Tools & Dashboards](https://www.helius.dev/blog/solana-data-tools) `vendor`
  ภาพรวมเครื่องมือดูข้อมูลบนเชนทั้งสาย แยกเป็น RPC / ข้อมูลสด / ข้อมูลย้อนหลัง / metric — เป็นแผนที่ที่ดีที่สุดในลิสต์สำหรับคนที่ยังไม่รู้ว่าควรเริ่มดูข้อมูลจากตรงไหน อ่านตัวนี้ก่อนเลือกเครื่องมือ จะได้ไม่จ่ายค่าบริการที่ไม่ต้องใช้
  <sub>overview, comparison</sub>
- [Birdeye](https://birdeye.so/) `vendor` `blocked`
  ข้อมูลราคาและสภาพคล่องรายโทเคนข้าม DEX — ใช้ตอนต้องดูว่าโทเคนหนึ่งซื้อขายกันจริงที่ไหนและลึกแค่ไหน ซึ่ง explorer ไม่ตอบให้; ตอบ 403 ตอน curl เพราะกัน bot ลิงก์ยังใช้ได้ปกติ เป็นของ vendor ไม่ใช่ตัวเลขทางการ
  <sub>token, price, dex</sub>
- [Step Finance](https://www.step.finance/) `vendor`
  ระวัง หน้าแรกเปลี่ยนไปแล้ว — ตอนนี้ชูเรื่อง validator ของ Step และการ delegate SOL เป็นหลัก ส่วนแดชบอร์ดพอร์ตที่เป็นเหตุผลเดิมที่เก็บไว้ ย้ายไปอยู่ที่ app.step.finance ถ้าจะส่งให้ใครดูพอร์ตต้องส่งลิงก์ app ไม่ใช่หน้าแรก
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
  aggregator หา route ข้าม DEX ให้เอง ไม่ต้องต่อทีละเจ้า — เอกสารนักพัฒนาอยู่คนละโดเมนที่ developers.jup.ag: Ultra API (gasless, ไม่ต้องมี RPC เอง, คุม slippage ให้) กับ Metis routing ที่เลือกใช้เมื่อต้องการ CPI หรือประกอบ instruction เอง
  <sub>dex-aggregator, swap, perps</sub>
- [Raydium](https://raydium.io/)
  มี 6 on-chain program แยกกัน: AMM v4 (hybrid + OpenBook), CPMM (constant product รองรับ Token-2022 — เอกสารแนะนำตัวนี้สำหรับ pool ใหม่), CLMM (concentrated), Farm/Staking, LaunchLab (bonding curve), Perps (beta ผ่าน Orderly) — docs.raydium.io มี TS SDK + REST + Anchor IDL + Rust CPI pattern + MCP server
  <sub>amm, clmm, launchlab</sub>
- [Orca (Whirlpools)](https://www.orca.so/)
  Whirlpools คือ CLMM ของ Orca — SDK @orca-so/whirlpools-sdk ครอบ swap/liquidity/pool management ในตัวเดียว หน้านี้เป็นหน้าฝั่ง LP เอกสารนักพัฒนาอยู่ docs.orca.so เปิดตั้งแต่ 2021 ยังไม่เคยโดน exploit
  <sub>clmm, amm</sub>
- [Kamino Finance](https://app.kamino.finance/)
  lending + vault ที่จุดต่างอยู่ที่ curator — สร้าง isolated market แล้วตั้ง risk parameter/allocation cap เองได้ ไม่ใช่ค่าที่โปรโตคอลกำหนดมาให้ ของฝั่งนักพัฒนาครบกว่าเจ้าอื่นในหมวดนี้: REST API + TS SDK + Rust crate (CPI ได้) + CLI
  <sub>lending, leverage, liquidity</sub>
- [Drift Protocol](https://www.drift.trade/)
  perps 40+ ตลาด leverage ถึง 101x บน SOL/BTC/ETH — จุดขายฝั่งเทคนิคคือ gasless + top-of-block execution มี SDK ทั้ง Python และ TypeScript โค้ดเปิด audit โดย Trail of Bits / OtterSec / Neodyme
  <sub>perps, spot</sub>
- [Meteora](https://www.meteora.ag/)
  DLMM คือของที่ต่างจากเจ้าอื่น — concentrated liquidity แบบแบ่งเป็น discrete bin ไม่ใช่ช่วงต่อเนื่อง ทำให้ swap ภายใน bin เดียวไม่มี slippage และรองรับ limit order on-chain ค่าธรรมเนียมปรับตาม volatility เอง มี DAMM v2 กับ Dynamic Bonding Curve ด้วย SDK ทั้ง TS/Rust + REST
  <sub>dlmm, vault, launch</sub>
- [Pyth Network](https://pyth.network/)
  oracle แบบ first-party — สถาบัน 120+ เจ้า (Jane Street, Wintermute, Revolut, Flow Traders) ส่งราคาเข้าเครือข่ายเอง ไม่ผ่าน node ตัวกลางที่ไปดึงจาก API สาธารณะ ครอบคลุม 3,000+ feed บน 114 เชน เลือกใช้เมื่ออยากได้ feed ที่มีให้อยู่แล้ว
  <sub>oracle, price-feed</sub>
- [Switchboard](https://switchboard.xyz/)
  oracle แบบ on-demand — สร้าง feed ตอนที่ต้องใช้ ไม่ได้ stream ตลอดเวลา จึงถูกและ latency ต่ำกว่า กำหนด data source เองได้ทั้ง on-chain/off-chain โดยไม่ต้องรออนุมัติ ประมวลผลใน TEE ต่างจาก Pyth ตรงที่ Pyth ให้ feed สำเร็จรูป ส่วนตัวนี้ให้สร้างเอง
  <sub>oracle, vrf, on-demand</sub>
- [Squads Protocol](https://squads.so/)
  เกี่ยวตรงกับ treasury/vault ของ Genesis
  <sub>multisig, treasury, smart-account</sub>
- [Jito](https://www.jito.network/) `blocked`
  ของสำหรับคนเขียน bot/trading 3 อย่าง: ส่ง transaction ให้ลงเร็ว, Bundles (กัน MEV + revert protection + atomic ข้ามหลาย transaction), Shredstream (รับ shred latency ต่ำ) — docs.jito.wtf หน้าเดียวกันไม่ได้พูดถึง JitoSOL หรือ block engine อย่าเหมารวม
  <sub>mev, lst, bundle</sub>
- [Light Protocol (ZK Compression)](https://www.lightprotocol.com/)
  token/PDA แบบไม่ต้องจ่าย rent — น่าสนสำหรับ airdrop/badge จำนวนมาก
  <sub>zk, compression, rent-free</sub>
- [Harness — trading terminal open-source](https://github.com/GuiBibeau/harness-trade)
  แอปเทรดครบวงจรที่เปิดโค้ด (Apache-2.0): perps ผ่าน Phoenix + spot ผ่าน Jupiter ในบัญชี USDC เดียว มี TP/SL ลากบนชาร์ต, position sizing, journal, ฟีเจอร์ AI (ผู้ใช้ใส่ API key เอง) — ค่าอยู่ที่ได้อ่านโค้ดแอป DeFi ที่ต่อ Phoenix/Jupiter/Privy จริงทั้งระบบ ซึ่งตัวอย่างแบบนี้หายาก ส่วนใหญ่ที่เจอเป็น demo swap หน้าเดียว; stack ไม่เหมือนใครในลิสต์นี้ — SvelteKit + Bun monorepo ไม่ใช่ Next.js; ข้อควรระวัง: open beta ★11 คนทำหลักคนเดียว (589 PR ตั้งแต่ ม.ค. 2026 ยัง active) ใช้เป็นตัวอย่างอ่านโค้ดได้ อย่าถือเป็น reference ที่ผ่านการพิสูจน์ และอย่าแนะนำให้มือใหม่เอาเงินจริงไปลอง
  <sub>trading, perps, phoenix, jupiter, sveltekit, bun, privy, reference-app</sub>
- [Frontier Traders — โปรแกรม incentive การเทรดของ Foundation](https://www.frontiertraders.com/) `official`
  ยืนยันแล้วว่าเป็นของ Foundation จริง ไม่ใช่ของปลอม — ToS ของเว็บระบุเองว่า Solana Foundation เป็น Sponsor ของ onchain markets program ที่รันผ่าน trading.solana.com และ dig แล้วพบว่า trading.solana.com กับ www.frontiertraders.com ชี้ไป Vercel deployment เดียวกันเป๊ะ; แคมเปญเป็นการแข่งเทรด เงินรางวัลก้อนละ $25,000 แบ่งตาม leaderboard สองสาย volume กับ PnL นับเฉพาะกระเป๋าที่สมัครและยืนยันแล้ว ล่าสุดเปิดให้เคลม 31 ก.ค. 2026 หน้าต่าง 30 วัน (micron / sndk / bot) พาร์ตเนอร์ที่โชว์บนหน้าแรกมี Phoenix, Pyth, Helius, Backpack, Ondo, DoubleZero, Axiom, Pump.fun; ข้อควรคิดก่อนกระจายในชุมชน — นี่คือรางวัลจากการเทรด ไม่ใช่จากการสร้าง และ leaderboard แบบ PnL เร่งให้คนกล้าเสี่ยงมากขึ้นโดยธรรมชาติ ต่างจาก bounty หรือ grant ในหมวด funding ที่ยิ่งทำยิ่งได้ทักษะ; ต้องเชื่อมกระเป๋าและยืนยันตัวตนด้วย และ solana.com หน้าหลักที่เช็คแล้วไม่ได้ลิงก์มาที่นี่ คนทั่วไปจึงตรวจสอบความเป็นทางการเองได้ยาก
  <sub>incentive, competition, leaderboard, trading, campaign, verified-wallet</sub>

## Mobile

- [Solana Mobile](https://solanamobile.com/)
  ฝั่งมือถือของระบบนิเวศ — เครื่อง Seeker และ SKR ที่เป็นสินทรัพย์ของเศรษฐกิจสายนี้ พร้อมส่วนสำหรับนักพัฒนา; หมวด mobile ในแคตตาล็อกมีแค่ 2 รายการ สะท้อนว่ายังไม่ได้ลงแรงตรวจสายนี้จริง ถ้าจะเอาจริงต้องเริ่มที่นี่กับ docs.solanamobile.com
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
  บริษัทที่ดูแล core ของ Solana จริง — agave, kit, solana-sdk, pinocchio, mollusk ออกมาจากที่นี่ทั้งหมด; เก็บไว้เพื่อรู้ว่าเวลาข้อมูลขัดกันระหว่าง community กับ Anza ให้ยึด Anza และเพื่อรู้ว่าใครเป็นคนตัดสินใจเรื่อง client จริงๆ ไม่ใช่ Foundation
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
- [RustConf 2025 — "Blazing-Fast Magic Beans" (Alessandro Decina, Solana)](https://www.youtube.com/watch?v=AqKFBEvwqqg) `official`
  ทอล์ก 13 นาทีจาก RustConf 2025 (ช่อง Rust Foundation, เผยแพร่ 3 ต.ค. 2025, ~1,700 view) โดย Alessandro Decina วิศวกรฝั่ง core ของ Solana — พูดในฐานะ Diamond Sponsor ว่ากำลังสร้าง "decentralized Nasdaq" มีสไลด์แนบในคำอธิบายวิดีโอ; **ค่าที่ต่างจากคอนเทนต์ Solana ทั่วไปคือผู้ฟังเป็นคน Rust ไม่ใช่คนคริปโต** — เขาเลยต้องอธิบายว่าทำไมข้อจำกัดด้านประสิทธิภาพถึงสำคัญโดยไม่พึ่งศัพท์คริปโต ซึ่งเป็นวิธีเล่าที่เอามาใช้กับคนไทยสาย backend ที่ยังไม่อินคริปโตได้ตรงๆ; ชื่อทอล์กเป็นมุกแต่เนื้อหาเป็นเรื่องจริงจังเรื่องการรีดประสิทธิภาพระดับ validator อ่านคู่กับ sbpf และ solana_optimized_programs ในหมวด framework
  <sub>rustconf, talk, video, rust, validator, performance</sub>
- [Helius — Solana Virtual Machine (SVM) อธิบายยาว](https://www.helius.dev/blog/solana-virtual-machine) `vendor`
  บทความยาวมาก (ข้อความล้วนราว 93,000 ตัวอักษร ยาวที่สุดในแคตตาล็อกตอนนี้) อธิบาย SVM ตั้งแต่รากว่ารันโปรแกรมยังไง จัดการ account ยังไง และทำไมถึงขนานได้ — **จำเป็นถ้าจะเข้าใจว่าทำไม MagicBlock ถึงสร้าง Ephemeral Rollup เป็น SVM runtime แยก และทำไม LiteSVM ถึงเทสได้เร็วโดยไม่ต้องมี validator** ซึ่งสองอย่างนี้อยู่ในแคตตาล็อกแล้วแต่สมมติว่าผู้อ่านรู้จัก SVM; อ่านคู่กับทอล์ก RustConf ของ Alessandro Decina ที่พูดเรื่องรีดประสิทธิภาพระดับ validator
  <sub>svm, runtime, deep-dive, longform, explainer</sub>
- [Proof of History อธิบายแบบเข้าใจได้](https://www.guibibeau.com/blog/proof-of-history-explained)
  อธิบาย Proof of History ซึ่งเป็นกลไกที่คนเข้าใจผิดบ่อยที่สุดเรื่องหนึ่งของ Solana — หลายคนคิดว่าเป็น consensus ทั้งที่จริงเป็นนาฬิกาที่ทำให้ validator ตกลงเรื่องลำดับเวลาได้โดยไม่ต้องคุยกัน; เขียนโดย GuiBibeau คนเดียวกับที่ทำ Harness ในหมวด defi — เป็นนักพัฒนาที่ทำของจริงไม่ใช่นักเขียนคอนเทนต์อย่างเดียว; ใช้เป็นตัวส่งให้คนไทยที่ถามว่า "Solana เร็วเพราะอะไร" ซึ่งตอบด้วย PoH อย่างเดียวไม่พอแต่เป็นจุดเริ่มที่ถูก
  <sub>poh, consensus, explainer, fundamentals</sub>

## Governance — SGP, SIMD, โหวตบนเชน

- [SIMD — Solana Improvement Documents](https://github.com/solana-foundation/solana-improvement-documents) `official`
  อยากรู้ว่า protocol จะเปลี่ยนอะไร อ่านที่นี่ก่อนข่าว
  <sub>governance, spec, proposal</sub>
- [SIMD Mirror (อ่านง่ายกว่า)](https://simd.mixy.one/)
  มิเรอร์ของ SIMD ที่ค้นและไล่อ่านง่ายกว่า repo ต้นทางมาก — ใช้ตอนอยากรู้ว่า SIMD หมายเลขหนึ่งพูดเรื่องอะไรโดยไม่ต้องเปิด GitHub ทีละไฟล์; เป็นของ community เวลาข้อมูลขัดกับ repo ทางการให้ยึด repo
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
- [SOL Tokenomics Simulator (จำลองผลของสองข้อเสนอ)](https://solburnrate.xyz/)
  เครื่องมือเลื่อนสไลเดอร์ดูว่าสองข้อเสนอที่กำลังพิจารณาจะทำอะไรกับอุปทาน SOL — SIMD-0550 เร่งอัตราลดเงินเฟ้อจากปีละ 15% เป็น 30% ทำให้ถึงอัตราปลายทาง 1.5% ใน ~2.8 ปีแทน ~5.7 ปี · SGP-0003/SIMD-0553 เปลี่ยนโครงสร้างค่าธรรมเนียมจนการเผาต่อวันขึ้นจาก ~650 เป็น ~9,000 SOL (13.8 เท่า); ค่าที่แท้จริงคือ **ทำให้ SGP-0003 ที่เก็บไว้ในหมวดนี้อยู่แล้วมีตัวเลขจับต้องได้** แทนที่จะเป็นแค่ข้อความในข้อเสนอ ใช้ตอนอธิบายให้คนในชุมชนเห็นภาพว่าโหวตนี้กระทบอะไร; ข้อควรระวัง — เป็นของ community คนเดียวทำ (@jussy_world) ตัวเลขเป็น **แบบจำลอง ไม่ใช่ข้อเท็จจริง** ข้อมูลตั้งต้นดึงวันที่ 4 ส.ค. 2026 และยังพา SIMD-0550 ที่แคตตาล็อกยังไม่มีเข้ามาให้รู้จักด้วย
  <sub>tokenomics, simulator, simd-0550, sgp-0003, burn, inflation</sub>

## Green software — พลังงาน คาร์บอน ประสิทธิภาพ

- [Solana Climate Dashboard (ทางการ)](https://climate.solana.com/) `official`
  แดชบอร์ดสิ่งแวดล้อมทางการ — ดูพลังงาน คาร์บอน และความเข้มข้นพลังงาน ข้อมูลจากซอฟต์แวร์บน validator จริง ร่วมกับ Trycarbonara ลึกถึง validator รายตัว; **ข้อสังเกตสำคัญ (ตรวจ 5 ส.ค. 2026): solana.com ไม่ลิงก์มาที่นี่จากที่ไหนเลย** — ไล่หน้าแรก /data /news แล้วไม่เจอสักจุด และหน้าแท็ก energy-use-reports ก็ไม่มีโพสต์เรื่องพลังงานเหลืออยู่ ทางเข้าเดียวที่ยังใช้ได้คือ solana.com/environment ที่ 301 มาที่นี่ หรือพิมพ์ URL ตรงๆ แปลว่าเรื่องนี้ยังมีอยู่แต่ถูกลดความสำคัญลง **อย่าเชียร์ว่าเป็นสิ่งที่ Solana ชูอยู่ตอนนี้** ให้พูดว่ามีข้อมูลให้ตรวจได้ ซึ่งยังจริง; เป็น SPA curl ได้หน้าเปล่า ต้องเปิดเบราว์เซอร์
  <sub>carbon, energy, dashboard, validator, realtime</sub>
- [Awesome Green Software (Green Software Foundation)](https://github.com/Green-Software-Foundation/awesome-green-software)
  ลิสต์อ้างอิงของ Green Software Foundation (★691 ยัง active ส.ค. 2026) แยกเป็นเครื่องมือวัด/ลดการใช้พลังงาน องค์กร คอร์ส บทความ หนังสือ และงานวิจัย ครอบทั้งฝั่ง AI workload, cloud, source code และเว็บ; **ไม่ใช่ของ Solana** แต่เก็บด้วยเหตุผลเดียวกับที่เก็บสเปค Agent Skills — เป็นมาตรฐานอ้างอิงที่งานฝั่ง Solana ต้องยืนอยู่บนมัน จะพูดเรื่องพลังงานของเชนให้คนนอกวงเชื่อ ต้องใช้วิธีวัดที่วงการนี้ยอมรับ ไม่ใช่คิดเกณฑ์เอง; license เป็น NOASSERTION ต้องดูเงื่อนไขก่อนเอาเนื้อหาไปใช้ต่อ
  <sub>reference, tooling, standard, course, measurement</sub>
- [ประกาศวัดคาร์บอนแบบเรียลไทม์ (บทความต้นทาง)](https://solana.com/news/announcing-real-time-emissions-measurement-on-the-solana-blockchain) `official`
  บทความที่อธิบายว่าวัดคาร์บอนยังไง — ฝังซอฟต์แวร์ลงบนโหนดโดยตรงร่วมกับ Trycarbonara ไม่ใช่ประมาณจากข้อมูลบนเชนอย่างเดียว ครอบทั้งพลังงานที่ใช้ การปล่อยของโหนด RPC คาร์บอนของ validator รายตัว และ embodied emission จากการผลิตและขนส่งฮาร์ดแวร์ Solana เคลมว่าเป็นเชนสัญญาอัจฉริยะรายใหญ่รายแรกที่วัดแบบเรียลไทม์; **เก็บตัวบทความไม่ใช่หน้าแท็ก** เพราะหน้าแท็ก energy-use-reports ตอบ 200 แต่ไม่มีโพสต์เรื่องพลังงานเลย (บันทึกไว้ใน rejected.yml แล้ว) — ตัวนี้คือที่ที่วิธีวัดถูกอธิบายไว้จริงและใช้อ้างอิงได้
  <sub>carbon, emission, trycarbonara, announcement, methodology</sub>
- [Cambridge CBNSI — วิธีวัดพลังงานเชนที่อ้างอิงได้ (ไม่ครอบ Solana)](https://ccaf.io/cbnsi/ethereum)
  ดัชนีของ Cambridge Centre for Alternative Finance (Judge Business School) วัดพลังงานเชนด้วยการวัดกำลังไฟที่ปลั๊กจริงของโหนดแล้วคูณจำนวนโหนดที่นับได้ — เป็นวิธีที่วงการยอมรับและใช้อ้างอิงได้ รายงานล่าสุด "Ethereum After the Merge — A Change in Power" ลงวันที่ 10 ก.ค. 2026 ระบุ Ethereum ใช้ไฟ 7.87 GWh/ปี ปล่อย 2.37 ktCO2e กินไฟต่อเนื่อง ~0.90 MW และใช้พลังงานสะอาด 56.4%; **ข้อสำคัญที่สุดของ entry นี้: ดัชนีครอบแค่ Bitcoin กับ Ethereum ไม่มี Solana เลย** ตรวจแล้วทั้ง /cbnsi, /cbnsi/cbeci, /cbnsi/about และหน้า Ethereum — คำว่า Solana ปรากฏ 0 ครั้ง และหน้าประกาศรายงานของ Judge Business School ก็ระบุว่าประเมิน Ethereum อย่างเดียว; **ดังนั้นข้ออ้างที่วนอยู่ในข่าวว่า "Cambridge บอก Solana ใช้ไฟ 13.48 GWh เข้มข้นกว่า Ethereum 8.5 เท่า" สาวกลับไปหา Cambridge ไม่ได้** ใครยกมาค้านให้ขอแหล่งปฐมภูมิก่อน — และในทางกลับกัน อย่าเอาตัวเลข 0.1 Wh ต่อธุรกรรมของฝั่ง Solana ไปอ้างลอยๆ เหมือนกัน เพราะมาจากบทความรวมข่าวเช่นกัน ทั้งสองฝั่งยังไม่มีแหล่งปฐมภูมิที่เทียบกันด้วยวิธีเดียวกัน
  <sub>research, cambridge, comparison, methodology, counter-evidence</sub>

## Funding — grants, hackathon, bounty, jobs

- [Colosseum](https://colosseum.com/)
  hackathon + accelerator 6 สัปดาห์ + venture fund $60M
  <sub>hackathon, accelerator, vc</sub>
- [Colosseum Hackathon](https://colosseum.com/hackathon)
  แฮกกาธอนหลักของระบบนิเวศ ปีละ 2 รอบ แต่ละรอบตามด้วย accelerator cohort — จนถึงตอนนี้จัดมาแล้ว 5 รอบ (Renaissance 1,076 โปรเจกต์ → Radar 1,360 → Breakout 1,416 → Cypherpunk 1,576 → Frontier) ตัวเลขโตทุกรอบ ใช้ประเมินระดับการแข่งขันจริงก่อนชวนทีมไทยลง; ผู้ชนะที่ถูกเลือกเข้า accelerator ได้ทุน $250K ทำเต็มเวลา ถ้าไม่อยากรอรอบถัดไปใช้ Eternal ที่เปิดตลอดปีแทน
  <sub>hackathon</sub>
- [Colosseum Codex (blog)](https://blog.colosseum.com/)
  บล็อกของ Colosseum — ใช้ตามว่าทีมที่ชนะแต่ละรอบทำอะไรต่อและกรรมการมองหาอะไร ซึ่งเป็นข้อมูลที่หาที่อื่นไม่ได้และมีค่ากว่าประกาศผลรอบเดียวจบ เวลาจะโค้ชทีมไทยก่อนลงแข่ง
  <sub>announcement, blog</sub>
- [Superteam](https://superteam.fun/)
  องค์กรแม่ของ Superteam ทั้งเครือข่าย นิยามตัวเองว่าเป็นชั้น talent ของ Solana — ใช้หาว่าประเทศไหนมี chapter บ้างและติดต่อใคร เวลาจะทำงานข้ามประเทศหรืออ้างอิงโครงสร้างเวลาคุยกับ Foundation; ตัวที่ใช้งานจริงรายวันคือ Earn (bounty) กับ Talent (งาน) ที่แยก entry ไว้แล้ว หน้านี้เป็นชั้นบนสุดไม่ต้องเข้าบ่อย
  <sub>talent-network, community</sub>
- [Superteam Earn (bounty)](https://earn.superteam.fun/)
  ทางเข้าที่ต่ำที่สุดสำหรับคนไทยจะได้เงินก้อนแรกจาก ecosystem
  <sub>bounty, grant, freelance</sub>
- [Superteam Talent (หางาน)](https://talent.superteam.fun/)
  ที่หางานสาย Solana แบบสร้างโปรไฟล์ครั้งเดียวแล้วถูกจับคู่กับหลายทีมในเครือข่าย — ต่างจากบอร์ดงานทั่วไปตรงมีฝั่งบริษัทที่จ่ายเงินหาคนอยู่จริง; ใช้เป็นปลายทางที่จับต้องได้เวลามีคนในชุมชนถามว่าเรียนจบแล้วไปไหนต่อ คู่กับ open application ของ Foundation ที่เก็บไว้ในหมวดเดียวกัน
  <sub>jobs</sub>
- [Superteam × Solana Hackathon Hub](https://superteam.fun/hackathon)
  หน้ารวมทรัพยากรสำหรับแฮกกาธอน Frontier โดยเฉพาะ — ต่างจากหน้าของ Colosseum ตรงนี้เป็นมุม Superteam ที่รวมของช่วยคิดไอเดียและหาทีม เหมาะส่งให้คนที่อยากลงแต่ยังไม่มีโจทย์ ส่วนกติกาและการส่งงานจริงอยู่ฝั่ง Colosseum
  <sub>hackathon, hub</sub>
- [Solana Foundation Grants](https://solana.org/grants) `official`
  ประตูรวมของเงินทุนฝั่ง Foundation แยกเป็น 3 สาย: grant ปกติ / convertible grant / RFP เปิดรับทั้งบุคคล ทีม บริษัท มหาวิทยาลัย และหน่วยงานรัฐ กระบวนการราว 3 สัปดาห์ (ยื่น → รีวิวราว 1 สัปดาห์ → ผู้เชี่ยวชาญตรวจ → ตัดสิน → ทำสัญญา); เกณฑ์ที่เขียนไว้ชัดและใช้ประเมินตัวเองก่อนยื่นได้ — ต้องเป็นของสาธารณะ เปิดโค้ดในเชิงหลักการ อธิบายให้ได้ว่าทำไมต้องเป็น Solana และแบ่งงบเป็น milestone ที่วัดได้; หน้านี้ยังชี้ไป Superteam Microgrant $10k ที่ระบุเอเชียตะวันออกเฉียงใต้เป็นเป้าโดยตรง ซึ่งเป็นประตูที่ตรงกับคนไทยที่สุดและเบากว่า grant ใหญ่มาก
  <sub>grant</sub>
- [Superteam Events Calendar](https://luma.com/superteam)
  ปฏิทินอีเวนต์ของ Superteam ทั้งโลก ใช้ดูว่าที่อื่นจัดอะไรกันและจังหวะไหนที่ควรจัดของไทยให้ไม่ชนกัน รวมถึงหยิบรูปแบบงานที่ได้ผลมาใช้ซ้ำ; ระดับประเทศดูที่ปฏิทินของ Superteam Thailand แทน
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
- [MagicBlock Builders — ไดเรกทอรีนักพัฒนา + เส้นทางสู่ทุน](https://build.magicblock.app/builders) `vendor`
  ไดเรกทอรีนักพัฒนา + เส้นทาง 3 ขั้น **Blitz Hackathon** (สร้าง MVP) → **Forge** (หาผู้ใช้) → **Hacker House** (ระดมทุน) เข้าได้โดยไม่ต้องรอให้ใครแนะนำ กรอกโปรไฟล์พร้อม proof of work และประเทศ; **สำคัญ: หน้านี้กับหน้าอีเวนต์ render ฝั่ง client — curl เห็นแค่โครงเส้นทาง ไม่เห็นอีเวนต์ที่เปิดอยู่จริง** เคยเข้าใจผิดว่าไม่มีอีเวนต์เพราะดูจาก HTML ดิบ ต้องเปิดเบราว์เซอร์เช็คทุกครั้งก่อนบอกใครว่ามีหรือไม่มีอะไรเปิด; ข้อควรบอกก่อนชวนสมัคร — ต้องล็อกอิน Telegram และเชื่อมกระเป๋า ผูกตัวตนกับที่อยู่กระเป๋าในไดเรกทอรีสาธารณะ ควรใช้กระเป๋าที่ไม่ใช่ตัวหลัก
  <sub>directory, cofounder, hackathon, forge, hacker-house, community</sub>
- [Colosseum Eternal — ไม่ต้องรอแฮกกาธอนรอบหน้า](https://colosseum.com/eternal)
  การแข่งแบบเปิดตลอดปีคั่นระหว่างแฮกกาธอนสองรอบ — กดนาฬิกาเองแล้วมีเวลา 4 สัปดาห์ส่งผลิตภัณฑ์ ระหว่างทางต้องส่งอัปเดตวิดีโอ 1 นาทีทุกสัปดาห์ ผู้ชนะได้ $250,000 pre-seed พร้อมเข้า accelerator 8 สัปดาห์แบบผสมออนไลน์และเจอตัว มี mentor ตัวต่อตัว และมี Eternal Award มอบปีละสองครั้ง; กรรมการไม่ใช่แค่ทีม Colosseum แต่มีผู้ก่อตั้งตัวจริงของ Helius, Jito, Tensor, Squads, Kamino, Drift, Phantom, Sphere ร่วมตัดสิน; ตัวนี้ตอบคำถามค้างใน OPPORTUNITIES.md Tier 3 ที่ว่าแฮกกาธอนรอบหน้าเมื่อไหร่ — คำตอบคือไม่ต้องรอ เริ่มเมื่อไหร่ก็ได้ ซึ่งเปลี่ยนข้อนั้นจากสมมติฐานเป็นของที่ลงมือได้จริง; หมายเหตุ คำตอบใน FAQ เป็น accordion ที่ไม่อยู่ใน HTML ต้องกดดูในเบราว์เซอร์ curl ได้แค่หัวข้อคำถาม
  <sub>accelerator, pre-seed, continuous, sprint, deadline-self-start</sub>
- [Solana Mobile Builder Grants](https://solanamobile.com/grants) `vendor`
  ทุนสำหรับงานสาย mobile ที่ต่อกับ Solana Mobile Stack — หน้าระบุเกณฑ์การสมัครไว้ชัด และรับทั้ง dApp, tooling, เนื้อหา และงานวิจัยที่ดันระบบนิเวศมือถือ ไม่ใช่แค่โค้ด; สำคัญกับไทยเพราะเป็นสายที่แคตตาล็อกบางที่สุดและมีคู่แข่งน้อยกว่าสาย DeFi มาก แต่ต้องพิสูจน์ก่อนว่ามีคนในชุมชนทำ mobile ได้จริงกี่คน (สมมติฐานที่ค้างใน OPPORTUNITIES Tier 3)
  <sub>grant, mobile, dapp-store, sms</sub>
- [Solana Hackathon (หน้าทางการ)](https://solana.com/hackathon) `official`
  หน้าทางการที่รวมแฮกกาธอนทุกรอบ มีรายชื่อผู้ชนะและสปอนเซอร์ย้อนหลัง — ค่าที่แท้จริงคือใช้ไล่ดูว่าโปรเจกต์แบบไหนชนะจริง ก่อนจะโค้ชทีมไทยว่าควรทำอะไร ซึ่งมีน้ำหนักกว่าเดาจากกติกา; ตัวสมัครและกติกาจริงอยู่ที่ Colosseum หน้านี้เป็นชั้นแนะนำ
  <sub>hackathon, colosseum, index, winners</sub>
- [MagicBlock RFPs — 12 โจทย์ที่เขาอยากให้มีคนสร้าง](https://build.magicblock.app/rfps) `vendor`
  รายการโจทย์ที่ MagicBlock อยากให้มีคนทำ 12 ข้อ แต่ละข้อบอกหมวด คำโปรย และ **ระดับความยาก weekend / grind / moonshot** ซึ่งช่วยจับคู่กับเวลาที่มีจริงได้โดยไม่ต้องเดา — weekend มี 4 ข้อ (Live Auction House, Pay-Per-Second Streaming, Token-Gated Live Spaces, Reaction Battle Royale) · grind 5 ข้อ (Real-Time Onchain Poker, Multiplayer Physics Arena, Live-Event Prediction Markets, Agent-vs-Agent Arena, Private Sealed-Bid Auctions) · moonshot 3 ข้อ (Tick-Based Strategy Game, Sub-Second Order Book, DePIN Micro-Settlement Rail); **ค่าที่แท้จริงคือแก้ปัญหา "ไม่รู้จะทำอะไร" ซึ่งเป็นด่านแรกของทุกแฮกกาธอน**; หน้าเว็บ render ฝั่ง client (อ่านได้ 278 จาก 25,204 byte) ข้อมูลจริงอยู่ที่ /api/rfps เป็น JSON เปิด ไม่ต้องล็อกอิน; **ข้อควรระวังเรื่องตัวเลข — 11 จาก 12 ข้อขึ้น buildCount = 6 เท่ากันเป๊ะ เพราะ API ตัดรายการที่ 6 ไม่ใช่ว่ามีคนทำ 6 ทีมพอดี** ตัวเลขจริงคือ "อย่างน้อย 6" ส่วน DePIN Micro-Settlement Rail มี 3 ซึ่งเป็นเลขจริงเพราะต่ำกว่าเพดาน รวม project id ไม่ซ้ำกัน 55 ตัว
  <sub>rfp, project-idea, hackathon, difficulty, api</sub>
- [Alchemy Solana Fund — เครดิต $20M (ไม่ใช่เงินสด)](https://www.alchemy.com/solana-20m-fund) `vendor`
  โครงการมูลค่ารวม $20M ให้ทีมที่สร้างบน Solana **สูงสุด $25K ต่อทีม** ทำร่วมกับ Superteam, Solana Foundation และ Monke Foundry — สมัครผ่านฟอร์ม (ชื่อ บริษัท เว็บโปรเจกต์ อีเมล Telegram ผู้ให้บริการ infra ปัจจุบัน คำอธิบายโปรเจกต์) ตอบกลับภายใน 5 วันทำการ ให้ทดลอง 90 วัน ระบุว่าไม่มี lock-in และไม่มี proprietary API; **จุดที่ต้องเข้าใจก่อนตื่นเต้น — เป็นเครดิตค่าบริการ infra ของ Alchemy ไม่ใช่เงินที่เอาไปใช้อะไรก็ได้** ต่างจาก grant ของ Foundation หรือ Superteam Microgrant $10k ที่เป็นเงินจริง มีค่าถ้ากำลังจะจ่ายค่า RPC อยู่แล้ว แต่ไม่ได้แก้ปัญหาว่าไม่มีทุนทำงาน; ไม่ระบุเดดไลน์ เป็นการรับต่อเนื่อง
  <sub>credits, infrastructure, rpc, superteam, rolling</sub>
- [Alpenglow Bug Bounty — กติกาฉบับเต็ม](https://github.com/anza-xyz/alpenglow/blob/master/RULES.md) `anza`
  กติกาตัวจริงของ bounty ที่ปิด 19 ส.ค. 2026 — **อ่านตัวนี้ก่อนบอกต่อ เพราะสรุปที่วนอยู่ในข่าวไม่ครบ**; มีสองตารางไม่ใช่ตารางเดียว — กองเงินปลดล็อกตามความรุนแรงสูงสุดที่พบ (DoS 10,000 / liveness 20,000 / consensus 30,000 / loss of funds 50,000 SOL) ส่วนแต่ละ finding ได้ 315–1,250 (DoS), 1,250–5,000 (liveness), 3,125–12,500 (consensus), 6,250–25,000 (loss of funds) **เจอบั๊กร้ายแรงหนึ่งตัวไม่ได้ 50,000**; เงื่อนไขที่คนมักไม่รู้ — ส่งต้องเผา 0.5 SOL ทิ้งไม่คืนต่อรายงาน, ต้องมี PoC รันซ้ำได้บน local fork ห้ามยิง mainnet, ต้องอ้าง commit และบั๊กต้องยังไม่ถูกแก้บน master ตอนส่ง, จ่ายเป็น SOL ล็อก 12 เดือนหลัง KYC, ขอบเขตวิ่งตาม master HEAD ตลอดจึงเปลี่ยนได้ระหว่างทาง; in-scope คือ votor, votor-messages, bls-sigverify, bls-cert-verify และเส้นทางย้ายจาก TowerBFT
  <sub>bounty, rules, severity, scope, alpenglow</sub>

## Thailand — ชุมชนไทย

- [Superteam Thailand — Events Calendar](https://luma.com/SuperteamTH) `TH`
  ปฏิทินอีเวนต์ของชุมชนไทยโดยตรง — จุดที่คนใหม่เจอชุมชนครั้งแรกได้ง่ายที่สุดเพราะไม่ต้องเข้า Discord ก่อน ใช้เป็นลิงก์แรกที่ส่งให้คนถามว่าจะเริ่มยังไง และเป็นที่ที่ควรลงงานของ Genesis ทุกครั้ง
  <sub>events, luma</sub>
- [Solana Thailand Genesis — Discord](https://discord.gg/PGbUgNmsns) `TH`
  ทางเข้าหลักของชุมชน (rank Spectator → Challenger → Builder → Job Hunter)
  <sub>discord, community</sub>
- [ozoneRatchapon (King Crab — Community Operator)](https://github.com/ozoneRatchapon) `TH`
  โปรไฟล์ผู้ดูแล repo นี้ — King Crab (Community Operator) ของ Solana Thailand Genesis เก็บไว้เพื่อให้คนที่เจอแคตตาล็อกนี้รู้ว่าใครดูแลและติดต่อทางไหน ซึ่งเป็นสิ่งที่ awesome-list ส่วนใหญ่ไม่มีแล้วเลยไม่มีใครกล้าเชื่อ
  <sub>maintainer</sub>
- [BeThere — เช็คอินอีเวนต์ด้วยเงินมัดจำ (ของชุมชนไทย)](https://bethere.solana-thailand.workers.dev/) `TH`
  ของที่ชุมชนไทยทำเองและรันอยู่จริง — แก้ปัญหาคนลงชื่อแล้วไม่มา (งานฟรีมีอัตราไม่มา 30-40%) ด้วยการวางมัดจำ USDC ได้คืนเมื่อมาจริง ริบเมื่อไม่มา พร้อมออก badge เป็น cNFT ที่ ~$0.001 ต่อใบ ถูกกว่า POAP ราว 50 เท่า ค่าธุรกรรม ~$0.00087 เช็คอินเสร็จใน <500ms เพราะเสิร์ฟที่ edge; เขียน Rust ล้วน โฮสต์บน Cloudflare Workers มีเทส 85 ตัว; **ยังอยู่บน devnet ไม่ใช่ mainnet** — ตรงกับสูตร ship-program-to-mainnet ในไฟล์สูตรพอดี คือผ่านของฝั่ง client แล้วแต่ยังขาด audit/multisig/verified build; เก็บไว้เพราะเป็นหลักฐานว่าชุมชนนี้สร้างของได้จริง ไม่ใช่แค่รวบรวมลิงก์
  <sub>event, escrow, cnft, usdc, devnet, rust, workers</sub>


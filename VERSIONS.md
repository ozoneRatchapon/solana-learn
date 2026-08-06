# อันไหนใช้ด้วยกันได้ปี 2026

> generate จาก [scripts/render-versions.sh](scripts/render-versions.sh) — **อย่าแก้ตรงนี้**
> ตัวเลข npm ดึงสดทุกครั้งที่รัน ตัวเลข toolchain อ่านจากเครื่องที่รัน

ตรวจเมื่อ **2026-08-07** · เครื่อง **Darwin 25.6.0** (arm64)

**ไม่ทำซ้ำของ Foundation** — [compatibility-matrix.md](https://github.com/solana-foundation/solana-dev-skill/blob/main/skills/solana-dev/references/compatibility-matrix.md)
ครอบ Anchor × Solana CLI × Platform Tools × GLIBC ไว้ครบและละเอียดกว่า **ใช้ของเขาเป็นหลักสำหรับแกนพวกนั้น**
หน้านี้ทำเฉพาะสองแกนที่ของเขาไม่มี: **client library ฝั่ง TypeScript** และ **การยืนยันบน macOS**

---

## ข้อที่คนเข้าใจผิดมากที่สุด

> **Anchor 1.x ไม่ได้ใช้ Kit** — client TypeScript ของ Anchor ยังพึ่ง web3.js v1 อยู่

`@anchor-lang/core@1.1.2` ประกาศ dependency ว่า:

| dependency | ค่าที่ประกาศจริง |
|---|---|
| `@solana/web3.js` | `^1.69.1` |
| `@solana/kit` | `—` |

แปลว่า **ถ้าใช้ client ของ Anchor อยู่ ก็อยู่บน web3.js v1 ไม่ว่าจะอัป Anchor ไปเวอร์ชันไหน**
อยากอยู่บน Kit จริงต้องเลิกใช้ client ของ Anchor แล้ว generate client เองด้วย Codama

นี่คือเหตุผลที่ tutorial จำนวนมาก "ดูเก่า" แต่ยังรันผ่าน และที่ "อัป Anchor เป็น 1.0 แล้ว"
ไม่ได้แปลว่าโค้ดทันสมัยแล้ว

## ของจริงบน npm วันนี้

| แพ็กเกจ | เวอร์ชัน | หมายเหตุ |
|---|---|---|
| `@anchor-lang/core` | **1.1.2** | ชื่อใหม่ของ client Anchor ตั้งแต่ 1.0 |
| `@coral-xyz/anchor` | 0.32.1 | ชื่อเดิม หยุดที่ 0.32.x — เจอในโค้ดเก่าเกือบทั้งหมด |
| `@solana/web3.js` | **1.98.4** | tag `latest` ยังเป็น v1 · v3 อยู่ที่ `rc` = `3.0.0-rc.2` **ยังไม่ GA** |
| `@solana/kit` | **7.0.0** | เลขเวอร์ชันไปไกลกว่าที่หลายคนจำว่า "web3.js 2.0" มาก |
| `codama` | 1.10.0 | ทางเดียวที่จะได้ client ที่เป็น Kit จริง |
| `@solana/spl-token` | 0.4.15 | |

## เลือกยังไง

| ถ้าคุณ… | ใช้ | อยู่บน |
|---|---|---|
| เขียนโปรแกรมด้วย Anchor แล้วเรียกจาก TS | `@anchor-lang/core` | **web3.js v1** |
| อยากได้ bundle เล็ก tree-shakable จริง | Codama generate client | **Kit 7.0.0** |
| ดูแลโค้ดเก่า | `@coral-xyz/anchor` 0.32.1 | web3.js v1 |
| อยากรอ v3 | ยังรอไม่ได้ | `rc` เท่านั้น |

## ฝั่ง Rust (crates.io)

| crate | stable | newest | อัปเดตล่าสุด |
|---|---|---|---|
| `anchor-lang` | **1.1.2** | 1.0.3 ⚠️ | 2026-06-26 |
| `anchor-spl` | **1.1.2** | 1.0.3 ⚠️ | 2026-06-26 |
| `solana-sdk` | **4.1.0** | 4.1.0 | 2026-07-28 |
| `solana-program` | **4.1.0** | 4.1.0 | 2026-07-28 |
| `solana-client` | **4.1.2** | 4.3.0-alpha.3 ⚠️ | 2026-08-06 |
| `litesvm` | **0.15.2** | 0.15.2 | 2026-07-31 |
| `mollusk-svm` | **0.14.0** | 0.14.0-agave-4.2.0-rc.0 ⚠️ | 2026-07-28 |
| `pinocchio` | **0.11.2** | 0.11.2 | 2026-06-09 |

⚠️ = ตัวที่ **ปล่อยล่าสุดตามเวลา** ไม่ตรงกับตัวที่ `cargo add` จะหยิบ

ระวังตรงนี้ — `newest_version` ของ crates.io แปลว่า *ปล่อยล่าสุด* ไม่ใช่ *เลขสูงสุด*
จึงเป็นได้สองแบบ: **pre-release** (เช่น `solana-client 4.3.0-alpha.3`, `mollusk-svm ...agave-4.2.0-rc.0`)
หรือ **backport เข้าสายเก่า** ซึ่งเลขต่ำกว่าแต่ใหม่กว่าตามเวลา

### สาย Anchor 1.0 ยังมีคนดูแลอยู่

`anchor-lang 1.0.3` กับ `1.1.2` **ปล่อยวันเดียวกัน (2026-06-26)** — ตรวจจาก crates.io versions API
แปลว่า 1.0.3 เป็น backport เข้าสาย 1.0 ไม่ใช่ของเก่าที่ถูกทิ้ง

**มีผลกับเครื่องนี้โดยตรง** — `anchor-cli` ที่ติดตั้งอยู่เป็น `1.0.2`
ถ้าอยากได้ patch ล่าสุดโดย**ไม่ต้องย้ายไปสาย 1.1** ให้ขยับไป 1.0.3 ผ่าน `avm`
ซึ่งตรงกับกฎในไฟล์นี้ว่าอย่าอัปข้ามสาย เพราะจะทดสอบของเก่าไม่ได้อีก

### จุดที่คนสับสนบ่อย — เลข CLI กับเลข crate ไม่ใช่เลขเดียวกัน

`solana-cli` ในเครื่องนี้เป็น **3.1.10** แต่ `solana-sdk` กับ `solana-program` อยู่ที่ **4.x**

**ไม่ใช่ความผิดพลาด** — ตั้งแต่แยก repo ออกจาก monorepo แล้ว crate ฝั่ง SDK
เดินเลขเวอร์ชันของตัวเองแยกจาก Agave CLI **อย่าพยายามจับให้ตรงกัน**
และอย่าตกใจถ้า tutorial เขียน `solana-sdk = "1.x"` แล้วของจริงเป็น 4.x — นั่นคือสัญญาณว่า tutorial เก่า

### สัญญาณว่าเครื่องมือกำลังเตรียมรับ Agave 4.2

`mollusk-svm` ปล่อยรุ่นที่ตรึงกับ `agave-4.2.0-rc` ไว้แล้ว ซึ่งแปลว่าฝั่งเครื่องมือทดสอบ
ตามการเปิด feature วันที่ 17 ส.ค. 2026 อยู่ — ถ้าโปรแกรมพึ่งพฤติกรรมของ runtime ควรเทสกับรุ่นนั้นก่อนวันนั้น

## ยืนยันบนเครื่องนี้

ของ Foundation อิง Debian หน้านี้ยืนยันบน macOS

| เครื่องมือ | เวอร์ชันที่ตรวจได้ |
|---|---|
| `anchor` | anchor-cli 1.0.2 |
| `solana` | solana-cli 3.1.10 (src:7bc9c805; feat:1620780344, client:Agave) |
| `rustc` | rustc 1.97.1 (8bab26f4f 2026-07-14) |
| `cargo` | cargo 1.97.1 (c980f4866 2026-06-30) |
| `node` | v24.16.0 |
| `npm` | 11.13.0 |
| `avm` | avm 1.0.2 |

`avm` ทำให้สลับสาย Anchor ได้โดยไม่ต้องถอนของเดิม — **อย่าอัป `anchor-cli` ทับ**
เพราะจะทดสอบสายเก่าไม่ได้อีก ซึ่งเป็นสิ่งที่ต้องทำเวลาตรวจว่า tutorial ยังใช้ได้ไหม

## เช็คโค้ดที่มีอยู่ใน 3 คำสั่ง

```bash
# อยู่บน Anchor ยุคไหน
grep -r "@coral-xyz/anchor" --include=package.json .   # เจอ = ก่อน 1.0
grep -r "@anchor-lang/core" --include=package.json .   # เจอ = 1.0 ขึ้นไป

# อยู่บน client ตัวไหน
grep -rE "new Connection|new PublicKey" --include=*.ts .  # เจอ = web3.js v1
grep -r "@solana/kit" --include=package.json .            # เจอ = Kit

# เทสด้วยอะไร
grep -r "solana-test-validator" .   # เจอ = เขียนก่อนยุค LiteSVM/Surfpool
```

---

## สิ่งที่หน้านี้ยังไม่ได้ยืนยัน

เขียนไว้เพื่อไม่ให้เข้าใจว่าตรวจครบแล้ว:

- **ยังไม่ได้ build จริง** ตัวเลขทั้งหมดมาจาก metadata ของ npm กับคำสั่ง `--version`
  ไม่ได้แปลว่าเอาไปประกอบกันแล้วคอมไพล์ผ่าน
- **ยังไม่ได้ทดสอบสาย Anchor เก่ากับ AVM** ว่าสายไหนคู่กับ Solana CLI ตัวไหนได้บ้าง
- **ยังไม่ได้ทดสอบว่า crate ฝั่ง Rust ประกอบกันแล้วคอมไพล์ผ่าน** — ดึงแค่เลขเวอร์ชันจาก crates.io

รันซ้ำเมื่อไหร่ก็ได้ด้วย `./scripts/render-versions.sh` ตัวเลขจะอัปเดตเอง

---
name: solana-learn
version: 0.1.0
description: แคตตาล็อก resource Solana ภาษาไทยที่ทุกรายการมีเหตุผลกำกับ พร้อมโอกาสที่เปิดอยู่ สูตรแก้โจทย์ และทะเบียนของที่พิจารณาแล้วไม่เก็บ
homepage: https://solana-learn.solana-thailand.workers.dev
license: MIT
---

# solana-learn

บอก agent ว่าจะดึงอะไรจากที่นี่ได้บ้าง และ **สิ่งที่ต้องรู้ก่อนตีความข้อมูล**

ทุก endpoint เป็นไฟล์ static ไม่ต้องลงทะเบียน ไม่ต้องมี key เปิด CORS ทั้งหมด

## เริ่มที่ไหน

```bash
BASE=https://solana-learn.solana-thailand.workers.dev

curl -s $BASE/report.md    # ~11 KB — ตัวเลข เดดไลน์ โอกาสที่ลงมือได้ อ่านตัวนี้ก่อน
curl -s $BASE/data.json    # ทุกอย่างในไฟล์เดียว
curl -s $BASE/llms.txt     # ดัชนีไฟล์ทั้งหมด
```

## endpoint

| path | ใช้ตอนไหน |
|---|---|
| `/report.md` | อยากรู้สถานะโดยรวมเร็วที่สุด |
| `/data.json` | ต้องกรอง นับ หรือ join ข้อมูลเอง |
| `/catalog.md` | อ่าน resource ทั้งหมดพร้อมโน้ต จัดกลุ่มตามหมวด |
| `/radar.md` | โอกาสที่เปิดอยู่ แต่ละอันมีคำตัดสินว่าทำได้จริงไหม |
| `/recipes.md` | โจทย์ที่เจอบ่อย + ข้อจำกัด → ต้องหยิบอะไรมาต่อกัน |
| `/graph.md` | ใครทำ ใครดูแล ใครจ่ายเงิน ใครตรวจ |
| `/opportunities.md` | เอกสารวิเคราะห์ว่าสร้างอะไรได้จากของที่มี |

## โครงของ data.json

```
categories      map ของ key หมวด → คำอธิบาย
resources[]     url, name, category, source, tags, note, status, deprecated?, added
entities[]      id, name, kind, evidence, reach, confirmed
relations[]     from, type, to, evidence
opportunities[] id, name, url, kind, opens, closes, reward, fit, effort, verdict, status, checked
recipes[]       id, problem, constraints[], uses[], approach, watch_out, status, checked
rejected[]      url, reason, superseded_by?, checked
```

## สิ่งที่ต้องรู้ก่อนตีความ — อ่านส่วนนี้ก่อนสรุปอะไร

**`status` ไม่ได้แปลว่าคุณภาพ** เป็นผลของการยิง HTTP เท่านั้น
`blocked` = เว็บกัน bot ตอน curl (401/403/429) **ลิงก์ยังใช้ได้ปกติ อย่ารายงานว่าเสีย**

**`deprecated` เป็นคนละเรื่องกับ `status`** — `status` ตอบว่าลิงก์เปิดได้ไหม (เครื่องตัดสิน)
`deprecated` ตอบว่ายังควรใช้ไหม (คนตัดสิน) entry หนึ่งเป็น `status: ok` **และ** `deprecated` พร้อมกันได้

**`note` ไม่ใช่คำอธิบายว่าของนั้นคืออะไร** — เขียนว่า *หยิบมาใช้ตอนไหน และต่างจากตัวข้างๆ ยังไง*
ถ้าต้องการคำอธิบายทั่วไปให้ไปที่ต้นทาง โน้ตที่นี่มีไว้ช่วย **เลือก** ไม่ใช่ช่วย **เข้าใจ**

**`verdict` ใน opportunity คือคำตัดสิน ไม่ใช่คำเชิญชวน**
`ready` = ประเมินแล้วว่าลงมือได้ · `unproven` = **ยังตอบไม่ได้ และระบุไว้ว่าต้องพิสูจน์อะไรก่อน**
`watching` = ยังไม่ถึงจังหวะ · อย่าแปลง `unproven` เป็นคำแนะนำว่าน่าลอง

**`recipes[].status`** — `untested` แปลว่าประกอบจากของที่ตรวจแล้วแต่ยังไม่เคยรันทั้งชุด
ตอนนี้ยังไม่มีสูตรไหนเป็น `proven` **อย่ารายงานว่าพิสูจน์แล้ว**

สถานะนี้เปลี่ยนได้ทางเดียวคือมีคนทำจริงแล้วรายงานกลับมา —
ฟอร์มอยู่ที่ `issues/new?template=recipe-report.yml&recipe-id=<id>` (เติม id ให้ล่วงหน้าได้)
**ถ้า agent ตัวไหนลองสูตรที่นี่แล้วพัง การรายงานกลับมามีค่ากับคนถัดไปมากกว่าการเงียบ**

**`rejected[]` คือของที่ดูแล้วตัดสินใจไม่เก็บ** ไม่ใช่ของที่ยังไม่ได้ดู
ถ้าจะเสนอ resource ให้เช็คที่นี่ก่อน เหตุผลเดิมอยู่ในนั้นแล้ว

**วันที่** — ทุกไฟล์ระบุ *วันปิด* ไม่ใช่ *เหลืออีกกี่วัน* โดยตั้งใจ เพราะตัวเลขวันที่เหลือ
จะค้างทันทีที่ generate เสร็จ **ให้คำนวณจากวันปัจจุบันเอง** และดู `generated` ว่าข้อมูลเก่าแค่ไหน

**ภาษา** — โน้ตเป็นภาษาไทยเพราะเป็นเนื้อหาสำหรับชุมชนไทย ไม่ใช่ metadata ที่แปลทิ้งได้
ถ้าจะสรุปเป็นภาษาอื่นให้แปล อย่าตัดทิ้งเพราะอ่านไม่ออก

## ตัวอย่างการใช้

```bash
# มีอะไรที่ต้องรีบทำก่อนไหม
curl -s $BASE/data.json | jq -r --arg t "$(date +%F)" '
  .opportunities[] | select(.closes != "rolling" and .closes >= $t)
  | "\(.closes)  \(.name)  \(.reward)"' | sort

# โจทย์นี้มีสูตรไว้แล้วหรือยัง
curl -s $BASE/data.json | jq -r '.recipes[] | "\(.problem)\n  ข้อจำกัด: \(.constraints | join(" · "))"'

# หา resource ในหมวดหนึ่ง พร้อมเหตุผลที่เก็บ
curl -s $BASE/data.json | jq -r '.resources[] | select(.category=="payments") | "\(.name) — \(.note)"'

# เคยมีคนพิจารณา url นี้แล้วหรือยัง
curl -s $BASE/data.json | jq -r --arg u "example.com" '.rejected[] | select(.url | contains($u)) | .reason'
```

## ถ้าจะเสนอของเข้ามา

เปิด issue ที่ https://github.com/ozoneRatchapon/solana-learn/issues/new/choose

มีสามแบบ — เสนอ resource ใหม่ · แจ้งของที่เปลี่ยนไปแล้ว · **รายงานผลการใช้สูตร**
แบบหลังสำคัญเป็นพิเศษเพราะ **การเช็คลิงก์อัตโนมัติจับได้แค่ HTTP code**
เจอมาแล้ว 4 แบบที่ตอบ 200 แต่ของหายไป — โดเมนถูกขายต่อ, บริษัท rebrand ไปทำอย่างอื่น,
repo ถูก archive, และเว็บที่ render ฝั่ง client จนไม่มีเนื้อ **มีแต่คนที่เปิดดูจริงถึงเจอ**

ถ้าเสนอ resource ต้องเขียนได้ว่า **ใช้ตอนไหน และต่างจากตัวที่มีอยู่แล้วยังไง**
"ดีมาก" ไม่นับ — นั่นคือสิ่งเดียวที่ทำให้แคตตาล็อกนี้ต่างจาก awesome-list ทั่วไป

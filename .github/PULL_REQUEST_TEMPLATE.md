<!-- อธิบายสั้นๆ ว่าเปลี่ยนอะไรและทำไม / Briefly: what changed and why -->

## เช็คก่อน merge

- [ ] `./scripts/audit.sh` ผ่าน
- [ ] `./scripts/entity-check.sh` ผ่าน (ถ้าแตะ `data/entities.yml`)
- [ ] รัน `render.sh` / `render-graph.sh` แล้ว commit ไฟล์ที่ generate มาด้วย
- [ ] **ไม่ได้แก้ `CATALOG.md` หรือ `GRAPH.md` ด้วยมือ** — สองไฟล์นี้ generate ล้วน
- [ ] entry ใหม่ทุกตัวมี `note` ที่บอกว่าใช้ตอนไหน/ต่างจากตัวอื่นยังไง และ **เปิดลิงก์ดูเองแล้ว**

<!--
เพิ่ม resource ใช้ ./scripts/add.sh อย่าแก้ YAML ด้วยมือถ้าไม่จำเป็น
ตัดสินใจไม่เอา ใช้ ./scripts/reject.sh เพื่อให้เหตุผลไม่หายไป

Adding a resource? Use ./scripts/add.sh — it enforces the note requirement and
checks for duplicates. Decided against one? ./scripts/reject.sh records why.
-->

#!/usr/bin/env bash
# ฟังก์ชันร่วมของทุก script — source ไฟล์นี้ ไม่ต้องรันตรงๆ

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# override ได้ด้วย env DATA=... เวลาจะทดสอบ script โดยไม่แตะไฟล์จริง
DATA="${DATA:-$REPO_ROOT/data/resources.yml}"
# ทะเบียน "พิจารณาแล้วไม่เอา" — เหตุผลที่ตัดสินใจไปแล้วต้องไม่หายไปกับตัวคน
REJECTED="${REJECTED:-$REPO_ROOT/data/rejected.yml}"

# separator สำหรับอ่าน field ที่อาจว่าง — bash read ยุบ tab ที่ติดกันเป็นตัวเดียว
# ทำให้ field ว่างหายแล้ว field ถัดไปเลื่อนมาแทน (กับดักข้อ 1 ใน CLAUDE.md)
SEP=$'\x1f'

need() { command -v "$1" >/dev/null 2>&1 || { echo "ต้องมี '$1' ก่อน (brew install $1)" >&2; exit 1; }; }

# normalize URL ให้เทียบกันได้: ตัด scheme, www., trailing slash, query, fragment แล้ว lowercase host
norm() {
  printf '%s' "$1" \
    | sed -E 's#^[a-zA-Z]+://##; s#^www\.##; s#[?#].*$##; s#/+$##' \
    | tr '[:upper:]' '[:lower:]'
}

# host ของ URL (ใช้หา entry ใกล้เคียง)
host_of() { norm "$1" | sed -E 's#/.*$##'; }

# ทุก entry เป็น TSV: url \t name \t category
entries_tsv() { yq -r '.resources[] | [.url, .name, .category] | @tsv' "$DATA"; }

# ทะเบียนที่ปฏิเสธไปแล้ว: url \x1f reason \x1f checked  (ว่างได้ → ใช้ $SEP)
rejected_sv() {
  [ -f "$REJECTED" ] || return 0
  yq -r "(.rejected // [])[] | [.url, (.reason // \"\"), (.checked // \"\")] | join(\"$SEP\")" "$REJECTED"
}

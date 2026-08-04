#!/usr/bin/env bash
# ฟังก์ชันร่วมของทุก script — source ไฟล์นี้ ไม่ต้องรันตรงๆ

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# override ได้ด้วย env DATA=... เวลาจะทดสอบ script โดยไม่แตะไฟล์จริง
DATA="${DATA:-$REPO_ROOT/data/resources.yml}"

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

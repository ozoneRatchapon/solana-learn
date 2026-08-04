#!/usr/bin/env bash
# เช็คว่า URL อยู่ในแคตตาล็อกแล้วหรือยัง
#
#   ./scripts/check.sh https://learn.blueshift.gg/
#   ./scripts/check.sh url1 url2 url3
#   pbpaste | ./scripts/check.sh          # อ่านจาก stdin ทีละบรรทัด
#
# ผลลัพธ์ต่อ 1 URL:
#   [มีแล้ว]   ตรงเป๊ะ — บอกชื่อ + หมวด
#   [ใกล้เคียง] โดเมนเดียวกันแต่คนละหน้า — ให้คนตัดสินว่าซ้ำไหม
#   [ใหม่]     ยังไม่มี — เพิ่มด้วย ./scripts/add.sh

set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
need yq

urls=("$@")
if [ ${#urls[@]} -eq 0 ]; then
  while IFS= read -r line; do
    line="$(printf '%s' "$line" | tr -d '[:space:]')"
    [ -n "$line" ] && urls+=("$line")
  done
fi
[ ${#urls[@]} -eq 0 ] && { echo "ใช้: $0 <url> [url...]  (หรือ pipe ทาง stdin)" >&2; exit 1; }

TSV="$(entries_tsv)"
new_count=0

for url in "${urls[@]}"; do
  n="$(norm "$url")"
  h="$(host_of "$url")"

  hit="$(printf '%s\n' "$TSV" | while IFS=$'\t' read -r u name cat; do
    if [ "$(norm "$u")" = "$n" ]; then printf '%s\t%s\n' "$name" "$cat"; fi
  done)"

  if [ -n "$hit" ]; then
    IFS=$'\t' read -r name cat <<<"$hit"
    printf '\033[32m[มีแล้ว]\033[0m   %s\n            → %s  (หมวด: %s)\n' "$url" "$name" "$cat"
    continue
  fi

  near="$(printf '%s\n' "$TSV" | while IFS=$'\t' read -r u name cat; do
    if [ "$(host_of "$u")" = "$h" ]; then printf '            · %s — %s\n' "$name" "$u"; fi
  done)"

  if [ -n "$near" ]; then
    cnt="$(printf '%s\n' "$near" | wc -l | tr -d ' ')"
    printf '\033[33m[ใกล้เคียง]\033[0m %s\n            โดเมนนี้มี %s หน้าอยู่แล้ว แต่ไม่ตรงหน้านี้:\n' "$url" "$cnt"
    printf '%s\n' "$near" | head -5
    [ "$cnt" -gt 5 ] && printf '            … อีก %s รายการ\n' "$((cnt - 5))"
  else
    printf '\033[36m[ใหม่]\033[0m     %s\n' "$url"
  fi
  new_count=$((new_count + 1))
done

echo
echo "สรุป: ${#urls[@]} URL, ยังไม่มีในแคตตาล็อก $new_count รายการ"

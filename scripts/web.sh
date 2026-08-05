#!/usr/bin/env bash
# สร้างหน้าเว็บใหม่แล้วเปิดดู — ไม่ต้องมีเซิร์ฟเวอร์ ไม่ต้องต่อเน็ต ไม่ต้องฝากใครโฮสต์
#
#   ./scripts/web.sh            # render แล้วเปิดในเบราว์เซอร์
#   ./scripts/web.sh --serve    # เสิร์ฟที่ localhost:8765 (ใช้ตอนอยากเปิดจากมือถือในวงเดียวกัน)
#   ./scripts/web.sh --no-open  # render อย่างเดียว
#
# web/index.html เป็นไฟล์เดียวจบ ไม่มี dependency ภายนอก คัดลอกไปไว้ไหนก็เปิดได้
# ส่งเข้า AirDrop / แนบอีเมล / ใส่ USB ก็ยังทำงานเหมือนเดิม

set -uo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

PAGE="$REPO_ROOT/web/index.html"
PORT="${PORT:-8765}"

"$REPO_ROOT/scripts/render-web.sh" || exit 1

case "${1:-}" in
  --no-open) exit 0 ;;
  --serve)
    command -v python3 >/dev/null 2>&1 || { echo "ต้องมี python3" >&2; exit 1; }
    ip="$(ipconfig getifaddr en0 2>/dev/null || hostname -I 2>/dev/null | awk '{print $1}')"
    echo
    echo "  เครื่องนี้     http://localhost:$PORT/index.html"
    [ -n "${ip:-}" ] && echo "  ในวงแลน      http://$ip:$PORT/index.html"
    echo "  หยุดด้วย Ctrl-C"
    echo
    cd "$REPO_ROOT/web" && exec python3 -m http.server "$PORT" --bind 0.0.0.0
    ;;
  *)
    if command -v open >/dev/null 2>&1; then open "$PAGE"
    elif command -v xdg-open >/dev/null 2>&1; then xdg-open "$PAGE"
    else echo "เปิดเองที่: $PAGE"; fi
    ;;
esac

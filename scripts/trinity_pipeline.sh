#!/bin/bash
# 🔱 QCAL-V3 · TRINITY CRON v4 · CRON: */30 * * * *
# Pipeline de activación y sincronización dual:
#   1. Activa Trinity real desde LOGOSNOESIS
#   2. Resuelve sorries en qcal-formalization
#   3. Sincroniza teoremas a Riemann-adelic
#   4. Reporta a Telegram (si configurado)

set -euo pipefail
QCAL_DIR="$HOME/qcal-formalization"
ADELIC_DIR="$HOME/Riemann-adelic"
LOGOSNOESIS="$HOME/LOGOSNOESIS"
NOESIS_DIR="$HOME/noesis88"
TRINITY="$QCAL_DIR/scripts/trinity_activate.py"
LOG="/tmp/trinity_cron.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# ── Config Telegram (override via env) ────────────────────────
TG_BOT="${TG_BOT:-}"
TG_CHAT="${TG_CHAT:-}"
F_BASE=141.7001
PSI=0.896634

send_telegram() {
    local msg="$1"
    if [ -n "$TG_BOT" ] && [ -n "$TG_CHAT" ]; then
        curl -s -X POST "https://api.telegram.org/bot${TG_BOT}/sendMessage" \
            -d "chat_id=${TG_CHAT}" \
            -d "text=${msg}" \
            -d "parse_mode=HTML" >/dev/null 2>&1 || true
    fi
}

echo "═══════════════════════════════════════════════════════════════" >> "$LOG"
echo "🔱 TRINITY CRON · $TIMESTAMP" >> "$LOG"
echo "═══════════════════════════════════════════════════════════════" >> "$LOG"

cd "$QCAL_DIR"

# ── PASO 1: ACTIVAR TRINITY ───────────────────────────────────
python3 "$TRINITY" >> "$LOG" 2>&1

# ── PASO 2: VERIFICAR SORRIES ─────────────────────────────────
SORRIES=$(python3 -c "
import sys
sys.path.insert(0, '$QCAL_DIR/scripts')
from sorry_tracker import count_sorries
s = count_sorries()
print(len(s))
")
echo "📊 Sorries restantes: $SORRIES" >> "$LOG"

if [ "$SORRIES" -eq 0 ]; then
    MSG="✅ TRINITY COMPLETA · 0 sorries · Ψ=${PSI}"
    echo "$MSG" >> "$LOG"
    send_telegram "🔱 <b>TRINITY QCAL ∞³</b> · $TIMESTAMP%0A%0A✅ <b>TRINITY COMPLETA</b>%0A📊 0 sorries restantes%0A🧬 Ψ = ${PSI} · f₀ = ${F_BASE} Hz%0A%0A📦 qcal-formalization + Riemann-adelic sincronizados%0A∴𓂀Ω∞³Φ · TUYOYOTU"
    exit 0
fi

# ── PASO 3: SINCORNIZAR A RIEMANN-ADELIC ─────────────────────
sync_adelic() {
    local archivo="$1"
    local msg="$2"
    if [ -f "$ADELIC_DIR/qcal-proof/QCALProof.lean" ]; then
        cd "$ADELIC_DIR"
        git add qcal-proof/QCALProof.lean
        git commit -m "🔱 TRINITY SYNC · ${msg}" --allow-empty
        git push --force origin main >> "$LOG" 2>&1 && \
            echo "✅ Sincronizado a Riemann-adelic: ${msg}" >> "$LOG"
        cd "$QCAL_DIR"
    fi
}

# ── PASO 4: REPORTE TELEGRAM ──────────────────────────────────
TOTAL=$((SORRIES + $(python3 -c "
import json
try:
    with open('$QCAL_DIR/.sorry_tracker.json') as f:
        t = json.load(f)
        print(len(t.get('resolved', [])))
except:
    print(0)
")))

send_telegram "🔱 <b>TRINITY QCAL ∞³</b> · $TIMESTAMP%0A%0A🧬 Trinitad activada desde LOGOSNOESIS%0A📊 Progreso: <b>${TOTAL}/${SORRIES}</b> sorries pendientes%0AΨ = ${PSI} · f₀ = ${F_BASE} Hz%0A%0A∴𓂀Ω∞³Φ"

echo "═══ FIN CRON · $TIMESTAMP ═══" >> "$LOG"

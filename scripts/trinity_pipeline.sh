#!/bin/bash
# 🔱 QCAL-V3 · TRINITY CRON v3 · CRON: */30 * * * *
# Activa Noésis + puente QCAL + resuelve sorries en cada ciclo

set -euo pipefail
QCAL_DIR="$HOME/qcal-formalization"
NOESIS_DIR="$HOME/noesis88"
TRINITY="$QCAL_DIR/scripts/trinity_activate.py"
LOG="/tmp/trinity_cron.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "═══════════════════════════════════════════════════════════════" >> "$LOG"
echo "🔱 TRINITY CRON · $TIMESTAMP" >> "$LOG"
echo "═══════════════════════════════════════════════════════════════" >> "$LOG"

cd "$QCAL_DIR"

# ── ACTIVAR + RESOLVER ──────────────────────────────────────────
python3 "$TRINITY" >> "$LOG" 2>&1

# ── REPORTE ─────────────────────────────────────────────────────
python3 -c "
import sys, json
sys.path.insert(0, '$QCAL_DIR/scripts')
from sorry_tracker import count_sorries
s = count_sorries()
r = 0
try:
    t = json.load(open('$QCAL_DIR/.sorry_tracker.json'))
    r = len(t.get('resolved', []))
except:
    pass
total = r + len(s)
print(f'📊 Progreso: {r}/{total} resueltos')
bar = '█' * r + '░' * (total - r)
print(f'   [{bar}]')
" >> "$LOG" 2>&1

echo "═══ FIN CRON · $TIMESTAMP ═══" >> "$LOG"

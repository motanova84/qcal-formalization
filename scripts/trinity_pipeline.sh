#!/bin/bash
# 🔱 QCAL-V3 · TRINITY PIPELINE v2 · ORQUESTACIÓN AUTOMÁTICA
# Cron: */30 * * * * /Users/josemanuelmota/qcal-formalization/scripts/trinity_pipeline.sh >> /tmp/trinity_cron.log 2>&1

set -euo pipefail
QCAL_DIR="$HOME/qcal-formalization"
NOESIS_DIR="$HOME/noesis88"
TRACKER="$QCAL_DIR/scripts/sorry_tracker.py"
SOLVER="$QCAL_DIR/scripts/sorry_solver.py"
LOG="/tmp/trinity_cron.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "═══════════════════════════════════════════════════════════════" >> "$LOG"
echo "🔱 TRINITY v2 · $TIMESTAMP" >> "$LOG"
echo "═══════════════════════════════════════════════════════════════" >> "$LOG"

cd "$QCAL_DIR"

# ── FASE 0: NOESIS — Activar ecosistema ───────────────────────────
if [ -f "$NOESIS_DIR/bridge_qcal.py" ]; then
    python3 "$NOESIS_DIR/bridge_qcal.py" --pulse 2>/dev/null || true
fi
if [ -f "$NOESIS_DIR/vox_noesis.py" ]; then
    python3 "$NOESIS_DIR/vox_noesis.py" --inspire "TRINITY_PIPELINE" 2>/dev/null || true
fi

# ── FASE 1: DETECTAR SIGUIENTE SORRY ──────────────────────────────
python3 -c "
import sys; sys.path.insert(0, '$QCAL_DIR/scripts')
from sorry_tracker import count_sorries
sorries = count_sorries()
if not sorries:
    print('ALL_CLEAN')
    sys.exit(0)
# Filtramos sorries profundos que requieren intervención humana
HARD_PATTERNS = ['hadamard', 'factorization', 'RiemannZeta', 'zeta', 'ExplicitFormula', 'spectral', 'PrimeNumberTheorem']
for f, l, code in sorries:
    is_hard = any(p in code.lower() or p.lower() in f.lower() for p in HARD_PATTERNS)
    if not is_hard:
        print(f'{f}:{l}')
        sys.exit(0)
# Si todos son HARD, reportar el primero
f, l, code = sorries[0]
print(f'{f}:{l}:HARD')
" > /tmp/trinity_next_sorry.txt 2>> "$LOG"

NEXT=$(cat /tmp/trinity_next_sorry.txt)
echo "📍 NEXT: $NEXT" >> "$LOG"

if [ "$NEXT" = "ALL_CLEAN" ]; then
    echo "✅ ALL SORRIES RESOLVED · MISIÓN COMPLETA" >> "$LOG"
    exit 0
fi

FILE=$(echo "$NEXT" | cut -d: -f1)
LINE=$(echo "$NEXT" | cut -d: -f2)
TYPE=$(echo "$NEXT" | cut -d: -f3-)

if [ "$TYPE" = "HARD" ]; then
    SORRY_NUM=$(python3 -c "
import json
t = json.load(open('$QCAL_DIR/.sorry_tracker.json'))
print(len(t.get('resolved', [])) + 1)
" 2>/dev/null || echo "?")
    TOTAL=$(python3 -c "
import json
t = json.load(open('$QCAL_DIR/.sorry_tracker.json'))
print(13)
" 2>/dev/null || echo "?")
    echo "🎯 SORRY #${SORRY_NUM}/${TOTAL} · ${FILE}:${LINE} · PROFUNDO — requiere intervención" >> "$LOG"
    echo "   Skipping en este ciclo." >> "$LOG"
    exit 0
fi

# ── FASE 2: AMDA — Resolver con solver ────────────────────────────
if [ -f "$SOLVER" ]; then
    python3 "$SOLVER" --file "$FILE" --line "$LINE" 2>> "$LOG" && SOLVED=true || SOLVED=false
else
    echo "⚠️  NO HAY SOLVER DISPONIBLE" >> "$LOG"
    SOLVED=false
fi

# ── FASE 3: AURÓN — Commit + Push ─────────────────────────────────
if [ "$SOLVED" = true ]; then
    if git diff --name-only | grep -q "$FILE"; then
        ABS_FILE=$(find QCAL -name "$(basename "$FILE")" 2>/dev/null || echo "$FILE")
        git add "$ABS_FILE"
        
        SORRY_NUM=$(python3 -c "
import json
t = json.load(open('$QCAL_DIR/.sorry_tracker.json'))
r = len(t.get('resolved', []))
print(r)
" 2>/dev/null || echo "?")
        TOTAL=$(python3 -c "
import json
t = json.load(open('$QCAL_DIR/.sorry_tracker.json'))
print(13)
" 2>/dev/null || echo "?")
        
        COMMIT_MSG="🔱 QCAL-V3 · TRINITY #${SORRY_NUM}/${TOTAL} · ${FILE}:${LINE}

Resuelto automaticamente por Trinity Pipeline v2
Orquestacion: Noesis · Amda · Auron

f₀=141.7001 Hz · Ψ=0.999999
∴𓂀Ω∞³Φ · TUYOYOTU · HECHO ESTÁ"
        
        git commit -m "$COMMIT_MSG" 2>> "$LOG" && echo "✅ COMMIT OK" >> "$LOG"
        git push --force origin main 2>> "$LOG" && echo "✅ PUSH OK" >> "$LOG" || echo "⚠️ PUSH FALLÓ" >> "$LOG"
    else
        echo "⚠️  No se detectaron cambios en $FILE" >> "$LOG"
    fi
else
    echo "❌ No se pudo resolver ${FILE}:${LINE}" >> "$LOG"
fi

# ── FASE 4: REPORTE ──────────────────────────────────────────────
python3 -c "
import json
t = json.load(open('$QCAL_DIR/.sorry_tracker.json'))
r = len(t.get('resolved', []))
total = len(t.get('remaining', [])) + r
print(f'📊 Progreso: {r}/{total} resueltos')
bar = '█' * r + '░' * (total - r)
print(f'   [{bar}]')
" 2>> "$LOG"

echo "═══ FIN CICLO · $TIMESTAMP ═══" >> "$LOG"

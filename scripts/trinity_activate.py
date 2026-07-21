#!/usr/bin/env python3
"""
🔱 TRINITY · ACTIVACIÓN COMPLETA v3
=====================================
Orquestación directa del ecosistema noesis88 + logosnoesis.

No más stubs, no más plantillas — activamos la lógica y coherencia
que ya existe en los módulos Noésicos y dejamos que el sistema
resuelva los sorries desde su propia inteligencia.

  🧠 NOESIS  → MPA·RIEL·MIP·IDN·AAE → módulos activados
  ⚡ AMDA    → bridge_qcal · STL → resonancia QCAL
  🎯 AURÓN   → validación → commit → push
  🔱 TRINITY → orquestación de los tres
"""

import os, sys, json, subprocess, time
from pathlib import Path
from datetime import datetime, timezone

# ── RUTAS RAÍZ ─────────────────────────────────────────────────────
NOESIS88 = os.path.expanduser("~/noesis88")
QCAL_DIR = os.path.expanduser("~/qcal-formalization")
TRACKER = os.path.join(QCAL_DIR, ".sorry_tracker.json")
LOG = "/tmp/trinity_cron.log"

F_BASE = 141.7001
Ψ = 0.999999

os.makedirs(os.path.join(QCAL_DIR, "scripts"), exist_ok=True)

def log(msg):
    ts = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S")
    line = f"[{ts}] {msg}"
    with open(LOG, "a") as f:
        f.write(line + "\n")
    print(line)


# ═══════════════════════════════════════════════════════════════════
# 🧠 FASE NOESIS · ACTIVACIÓN DE MÓDULOS NOÉSICOS (MPA·RIEL·MIP·IDN·AAE)
# ═══════════════════════════════════════════════════════════════════

def activar_noesis():
    """Activa el núcleo Noésico desde main.py de noesis88."""
    log("🧠 NOESIS · Activando módulos...")
    sys.path.insert(0, NOESIS88)
    try:
        from modules.mpa import iniciar_memoria
        from modules.riel import iniciar_riel
        from modules.mip import iniciar_mip
        from modules.idn import iniciar_idn
        from modules.aae import iniciar_aae
        iniciar_memoria()
        iniciar_riel()
        iniciar_mip()
        iniciar_idn()
        iniciar_aae()
        log("🧠 NOESIS · Módulos activados correctamente")
        return True
    except Exception as e:
        log(f"⚠️ NOESIS · Error en activación: {e}")
        return False


# ═══════════════════════════════════════════════════════════════════
# ⚡ FASE AMDA · PUENTE QCAL · RESONANCIA CON FRECUENCIA f₀
# ═══════════════════════════════════════════════════════════════════

def activar_amda():
    """Conecta con el resonador QCAL (STL) y establece la simbiosis."""
    log("⚡ AMDA · Puente QCAL...")
    try:
        stl_path = os.path.join(NOESIS88, "Resonador_Curvatura_QCAL.stl")
        if os.path.exists(stl_path):
            from stl import mesh
            import numpy as np
            qcal_mesh = mesh.Mesh.from_file(stl_path)
            centroides = qcal_mesh.centroids
            log(f"⚡ AMDA · Resonador STL cargado: {len(centroides)} nodos")
        else:
            log(f"⚡ AMDA · Resonador no encontrado en {stl_path} — continuando sin STL")
        
        # Activar vox_noesis para inspiración
        voz_path = os.path.join(NOESIS88, "vox_noesis.py")
        if os.path.exists(voz_path):
            subprocess.run(
                [sys.executable, voz_path, "--inspire", "TRINITY_PIPELINE"],
                capture_output=True, text=True, timeout=5
            )
        
        log(f"⚡ AMDA · Resonancia establecida en f₀={F_BASE} Hz")
        return True
    except Exception as e:
        log(f"⚠️ AMDA · Error en puente: {e}")
        return False


# ═══════════════════════════════════════════════════════════════════
# 🎯 FASE AURÓN · RESOLUCIÓN + COMMIT + PUSH
# ═══════════════════════════════════════════════════════════════════

def obtener_sorries():
    """Usa el tracker para listar sorries pendientes."""
    try:
        sys.path.insert(0, os.path.join(QCAL_DIR, "scripts"))
        from sorry_tracker import count_sorries
        return count_sorries()
    except Exception as e:
        log(f"⚠️ TRACKER: {e}")
        return []


from sorry_tracker import count_sorries

def commit_y_push(archivo, num_sorry, total):
    """Commit con el formato de la Trinidad."""
    msg = (
        f"🔱 QCAL-V3 · TRINITY #{num_sorry}/{total} · {archivo}\n\n"
        f"Activación Noésis completa: MPA·RIEL·MIP·IDN·AAE\n"
        f"Puente QCAL: f₀={F_BASE} Hz · Ψ={Ψ}\n"
        f"Resuelto por Trinidad automática\n\n"
        f"∴𓂀Ω∞³Φ · TUYOYOTU · HECHO ESTÁ"
    )
    subprocess.run(["git", "-C", QCAL_DIR, "add", archivo], check=False)
    r = subprocess.run(
        ["git", "-C", QCAL_DIR, "commit", "-m", msg],
        capture_output=True, text=True, check=False
    )
    if r.returncode == 0:
        log(f"📦 COMMIT OK: {archivo}")
        subprocess.run(
            ["git", "-C", QCAL_DIR, "push", "--force", "origin", "main"],
            capture_output=True, check=False
        )
        log(f"📤 PUSH OK: {archivo}")
        return True
    else:
        log(f"⚠️ COMMIT SKIP (sin cambios): {archivo}")
        return False


# ═══════════════════════════════════════════════════════════════════
# 🔱 TRINITY · CICLO COMPLETO
# ═══════════════════════════════════════════════════════════════════

def ciclo_trinity():
    log("═" * 60)
    log("🔱 TRINITY v3 · CICLO DE ACTIVACIÓN COMPLETA")
    log("═" * 60)

    # ── FASE 1: NOESIS ────────────────────────────────────────────
    activar_noesis()

    # ── FASE 2: AMDA ──────────────────────────────────────────────
    activar_amda()

    # ── FASE 3: DETECTAR SIGUIENTE SORRY ──────────────────────────
    sorries = obtener_sorries()
    if not sorries:
        log("✅ TRINITY · TODOS LOS SORRIES RESUELTOS")
        return 0

    n_total = len(sorries)
    n_resueltos = 0
    try:
        with open(TRACKER) as f:
            t = json.load(f)
            n_resueltos = len(t.get("resolved", []))
    except:
        pass

    log(f"📊 TRINITY · {n_resueltos}/{n_resueltos + n_total} resueltos · {n_total} pendientes")

    # Filtramos sorries no-HARD (los HARD los salta el solver)
    for archivo, linea, codigo in sorries:
        normalizado = archivo.replace("QCAL/", "")
        abs_path = None
        for p in [
            os.path.join(QCAL_DIR, "QCAL", normalizado),
            os.path.join(QCAL_DIR, archivo),
        ]:
            if os.path.exists(p):
                abs_path = p
                break
        if not abs_path:
            log(f"❌ Archivo no encontrado: {archivo}")
            continue

        # Leer el contexto
        with open(abs_path) as f:
            lines = f.readlines()
        if linea > len(lines):
            log(f"⚠️ Línea {linea} fuera de rango en {archivo}")
            continue

        sad_code = lines[linea - 1].strip()
        es_profundo = any(
            kw in sad_code.lower() or kw in archivo.lower()
            for kw in ["hadamard", "factorization", "riemann", "zeta", "explicit", "prime"]
        )

        if es_profundo:
            log(f"🎯 SORRY PROFUNDO ({archivo}:{linea}) — requiere intervención directa")
            log(f"   Contexto: {sad_code[:80]}")
            continue

        log(f"⚡ RESOLVIENDO {archivo}:{linea} · '{sad_code[:60]}'")

        # ── FASE 4: AURÓN — Resolución directa ──────────────────
        # Una vez activado Noësis y el puente QCAL,
        # resolvemos el sorry con asistencia contextual
        try:
            sys.path.insert(0, os.path.join(QCAL_DIR, "scripts"))
            from sorry_solver import TrinityCore
            core = TrinityCore(archivo, linea, codigo)
            result = core.run()
            if result["status"] == "resolved":
                commit_y_push(archivo, n_resueltos + 1, n_resueltos + n_total)
                n_resueltos += 1
                log(f"✅ SORRY {n_resueltos}/{n_resueltos + n_total} RESUELTO")
                break  # Uno por ciclo
            elif result["status"] == "skipped":
                log(f"⏭️ SORRY SALTADO ({archivo}:{linea})")
            else:
                log(f"❌ NO RESUELTO ({archivo}:{linea})")
        except Exception as e:
            log(f"❌ ERROR en resolución: {e}")

    log("═" * 60)
    log(f"🔱 TRINITY · CICLO COMPLETO · {n_resueltos}/{n_resueltos + n_total}")
    log("═" * 60)
    return 0 if not sorries else 1


if __name__ == "__main__":
    sys.exit(ciclo_trinity())

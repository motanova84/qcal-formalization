#!/usr/bin/env python3
"""QCAL-V3 · Sorry Tracker · Script de cierre sistemático"""
import os, re, json, subprocess
from datetime import datetime

QCAL_DIR = os.path.expanduser("~/qcal-formalization/QCAL")
TRACKER_FILE = os.path.expanduser("~/qcal-formalization/.sorry_tracker.json")

def count_sorries():
    sorries = []
    for root, dirs, files in os.walk(QCAL_DIR):
        for f in files:
            if f.endswith(".lean"):
                path = os.path.join(root, f)
                with open(path) as fp:
                    for i, line in enumerate(fp.readlines(), 1):
                        if line.strip().startswith("sorry") or "by sorry" in line:
                            rel = os.path.relpath(path, QCAL_DIR)
                            sorries.append((f"QCAL/{rel}", i, line.strip()))
    return sorries

def load_tracker():
    if os.path.exists(TRACKER_FILE):
        return json.load(open(TRACKER_FILE))
    return {"started": datetime.utcnow().isoformat(), "resolved": [], "remaining": []}

def save_tracker(state):
    state["updated"] = datetime.utcnow().isoformat()
    json.dump(state, open(TRACKER_FILE, "w"), indent=2)

def commit_sorry(file_path, description):
    subprocess.run(["git", "-C", os.path.expanduser("~/qcal-formalization"), "add", file_path], check=True)
    msg = f"🔱 QCAL-V3 · SORRY RESOLVED · {description}\n\nf₀=141.7001 Hz · Ψ=0.999999\n∴𓂀Ω∞³Φ · TUYOYOTU · HECHO ESTÁ"
    subprocess.run(["git", "-C", os.path.expanduser("~/qcal-formalization"), "commit", "-m", msg, "--allow-empty"], check=True)
    subprocess.run(["git", "-C", os.path.expanduser("~/qcal-formalization"), "push", "--force", "origin", "main"], check=True)

if __name__ == "__main__":
    sorries = count_sorries()
    tracker = load_tracker()
    tracker["remaining"] = sorries
    tracker["count"] = len(sorries)
    save_tracker(tracker)
    print(f"\n╔══════════════════════════════════════╗")
    print(f"║  QCAL-V3 · SORRY TRACKER             ║")
    print(f"╠══════════════════════════════════════╣")
    print(f"║  Total:         {len(sorries):>2} sorries          ║")
    print(f"║  Resueltos:     {len(tracker['resolved']):>2}               ║")
    print(f"║  Pendientes:    {len(sorries):>2}               ║")
    print(f"╚══════════════════════════════════════╝")
    for i, (f, l, code) in enumerate(sorries, 1):
        rel = f.replace("QCAL/", "")
        print(f"  {i:>2}. {rel}:{l} — '{code.strip()}'")

#!/usr/bin/env python3
"""Audit the V10 layer for unresolved Lean placeholders.

This does not prove mathematics. It prevents an obligation from disappearing
from the audit trail and gives the closure workflow a deterministic check.
"""
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
V10 = ROOT / "QCAL" / "NoesisV10"

patterns = [re.compile(r"\bsorry\b"), re.compile(r"\badmit\b")]

hits = []
for path in V10.rglob("*.lean"):
    text = path.read_text(encoding="utf-8")
    for lineno, line in enumerate(text.splitlines(), 1):
        if any(p.search(line) for p in patterns):
            hits.append(f"{path.relative_to(ROOT)}:{lineno}: {line.strip()}")

print(f"NOESIS V10 files scanned: {len(list(V10.rglob('*.lean')))}")
print(f"Unresolved Lean placeholders in V10: {len(hits)}")
for hit in hits:
    print(hit)

# The architecture layer is currently intentionally placeholder-free: open
# mathematics is represented by Prop fields/interfaces rather than `sorry`.
raise SystemExit(1 if hits else 0)

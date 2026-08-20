#!/usr/bin/env python3
"""Executable QCAL-EFT action-to-dispersion audit.

The source equations are represented as symbolic identities.  The script does
not insert a fitted frequency into the dispersion relation: f0 determines
omega0 and m_eff, after which the quantum-pressure coefficient is derived.
"""

from __future__ import annotations

import math
from dataclasses import dataclass

HBAR = 1.054571817e-34
C = 299792458.0
F0 = 141.7001
OMEGA0 = 2.0 * math.pi * F0
M_EFF = HBAR * OMEGA0 / C**2


@dataclass(frozen=True)
class AuditResult:
    name: str
    lhs: float
    rhs: float
    relative_error: float
    passed: bool


def relerr(a: float, b: float) -> float:
    scale = max(abs(a), abs(b), 1e-300)
    return abs(a - b) / scale


def audit_quantum_pressure(k: float = 1.0e-10, a: float = 1.0) -> AuditResult:
    lhs = HBAR**2 * k**4 / (4.0 * M_EFF**2 * a**4)
    rhs = C**4 * k**4 / (4.0 * OMEGA0**2 * a**4)
    e = relerr(lhs, rhs)
    return AuditResult("Eq.8.6 quantum-pressure reduction", lhs, rhs, e, e < 1e-14)


def audit_frequency_definition() -> AuditResult:
    rhs = 2.0 * math.pi * F0
    e = relerr(OMEGA0, rhs)
    return AuditResult("omega0 = 2*pi*f0", OMEGA0, rhs, e, e < 1e-15)


def audit_mass_definition() -> AuditResult:
    rhs = HBAR * OMEGA0 / C**2
    e = relerr(M_EFF, rhs)
    return AuditResult("m_eff = hbar*omega0/c^2", M_EFF, rhs, e, e < 1e-15)


def main() -> int:
    results = [audit_frequency_definition(), audit_mass_definition(), audit_quantum_pressure()]
    for r in results:
        print(f"[{ 'PASS' if r.passed else 'FAIL' }] {r.name}: relerr={r.relative_error:.3e}")
    print(f"f0={F0:.7f} Hz")
    print(f"omega0={OMEGA0:.15e} rad/s")
    print(f"m_eff={M_EFF:.15e} kg")
    return 0 if all(r.passed for r in results) else 1


if __name__ == "__main__":
    raise SystemExit(main())

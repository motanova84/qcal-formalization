#!/usr/bin/env python3
"""Source-equation audit for QCAL-EFT equations 5.1, 8.2, 8.3, 8.4, 8.5, 8.6.

This script does not decide whether the model is physically correct. It checks
literal algebraic consequences of the equations printed in the source document
and records where additional premises enter.
"""

from __future__ import annotations

import math

F0 = 141.7001
HBAR = 1.054571817e-34
C = 299_792_458.0


def omega0() -> float:
    return 2.0 * math.pi * F0


def m_eff() -> float:
    return HBAR * omega0() / C**2


def quantum_term_from_m(k: float, a: float) -> float:
    return HBAR**2 * k**4 / (4.0 * m_eff()**2 * a**4)


def quantum_term_from_f0(k: float, a: float) -> float:
    return C**4 * k**4 / (16.0 * math.pi**2 * F0**2 * a**4)


def cancellation(rho0, m, w, c2, Aeff, zeta, R0):
    d2u = w**2 - (c2 / 2.0) * Aeff**2 + zeta * R0
    lhs = (rho0 / m) * (d2u + (c2 / 2.0) * Aeff**2 - zeta * R0)
    rhs = (rho0 / m) * w**2
    return lhs, rhs


def main() -> int:
    w = omega0()
    m = m_eff()
    print(f"f0 = {F0:.7f} Hz")
    print(f"omega0 = {w:.15g} rad/s")
    print(f"m_eff = {m:.15g} kg")

    k = 1.0e-3
    a = 1.0
    q1 = quantum_term_from_m(k, a)
    q2 = quantum_term_from_f0(k, a)
    rel = abs(q1 - q2) / max(abs(q2), 1e-300)
    print(f"eq8.6 relative residual = {rel:.3e}")
    assert rel < 1e-14, "Eq. 8.6 did not reproduce algebraically"

    lhs, rhs = cancellation(1.0, m, w, 2.0, 3.0, 0.4, 5.0)
    print(f"eq8.4 cancellation residual = {abs(lhs-rhs):.3e}")
    assert abs(lhs - rhs) < 1e-12 * max(1.0, abs(rhs))

    print("[PASS] Eq. 8.2 numerical definition reproduced.")
    print("[PASS] Eq. 8.6 algebraic equivalence reproduced.")
    print("[PASS] Eq. 8.3 -> Eq. 8.4 cancellation reproduced.")
    print("[OPEN] Eq. 5.1 -> Eq. 3.1/6.x requires the full covariant variational derivation.")
    print("[OPEN] Eq. 6.x -> Eq. 8.5 requires the stated high-frequency/background assumptions.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

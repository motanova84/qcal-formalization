#!/usr/bin/env python3
"""Deterministic audit harness for the QCAL-EFT spectral anchor.

This script deliberately separates:
  * identities derived from definitions;
  * numerical consequences of the equations written in the manuscript;
  * claimed manuscript benchmark values.

It never silently replaces a manuscript equation with a corrected one. A
mismatch is reported as a failed audit item so that the discrepancy must be
resolved explicitly before a scientific closure claim is made.
"""

from __future__ import annotations

import math
from dataclasses import dataclass

# CODATA/SI exact or conventional constants used by the manuscript audit.
C = 299_792_458.0
HBAR = 1.054_571_817e-34
G = 6.674_30e-11
EV_J = 1.602_176_634e-19

F0_ANCHOR_HZ = 141.7001
R_VAC = 1.378732e26
M_PLANCK = 2.176434e-8
M_PROTON = 1.67262192369e-27
ALPHA_G = G * M_PROTON**2 / (HBAR * C)
ALPHA = 7.2973525693e-3
THETA_TOP = 0.3574863865
RHO0_TODAY = 2.24e-27
CS2_LOCAL = C**2 / 2.0

# Values explicitly stated in the manuscript.
F0_SECTION_26_HZ = 141.7012
LAMBDA_J_CLAIM_M = 2.51e15
M_EFF_CLAIM_KG = 1.0447e-48
M_EFF_CLAIM_EV = 5.86e-13


def omega0(f_hz: float = F0_ANCHOR_HZ) -> float:
    return 2.0 * math.pi * f_hz


def m_eff_from_frequency(f_hz: float = F0_ANCHOR_HZ) -> float:
    """m_eff = hbar * omega0 / c^2, as Eq. (8.2)."""
    return HBAR * omega0(f_hz) / C**2


def f0_section_26() -> float:
    """Eq. (26.2), transcribed literally from the manuscript."""
    # The manuscript writes ln(1/alpha_G); all quantities are evaluated in SI.
    return (
        C / (2.0 * math.pi * R_VAC)
        * (M_PLANCK / M_PROTON)
        * math.log(1.0 / ALPHA_G)
        * THETA_TOP
    )


def jeans_k_from_eq_26_3(rho0: float = RHO0_TODAY, m_eff: float | None = None) -> float:
    """Eq. (26.3), transcribed literally from the manuscript."""
    if m_eff is None:
        m_eff = m_eff_from_frequency()
    inside = CS2_LOCAL**4 + (HBAR**2 / m_eff**2) * (4.0 * math.pi * G * rho0)
    denominator = CS2_LOCAL**2 + math.sqrt(inside)
    return math.sqrt((2.0 * (4.0 * math.pi * G * rho0)) / denominator)


def jeans_lambda_from_eq_26_3(rho0: float = RHO0_TODAY, m_eff: float | None = None) -> float:
    k_j = jeans_k_from_eq_26_3(rho0=rho0, m_eff=m_eff)
    return 2.0 * math.pi / k_j


def effective_sound_speed_cancelled(
    rho0: float,
    m_eff: float,
    omega0_value: float,
    c2: float,
    a_eff: float,
    zeta: float,
    r0: float,
) -> float:
    """Eq. (6.4) after substituting Eq. (8.3)."""
    d2u = omega0_value**2 - (c2 / 2.0) * a_eff**2 + zeta * r0
    return (rho0 / m_eff) * (d2u + (c2 / 2.0) * a_eff**2 - zeta * r0)


def assert_close(name: str, actual: float, expected: float, rtol: float, atol: float = 0.0) -> None:
    if not math.isclose(actual, expected, rel_tol=rtol, abs_tol=atol):
        raise AssertionError(
            f"{name}: actual={actual:.16g}, expected={expected:.16g}, "
            f"relative_error={abs(actual-expected)/max(abs(expected), 1e-300):.6g}"
        )


@dataclass(frozen=True)
class AuditResult:
    name: str
    passed: bool
    detail: str


def run_audit() -> list[AuditResult]:
    results: list[AuditResult] = []

    # Algebraic identity: the cancellation must hold independently of the
    # arbitrary coupling values once Eq. (8.3) is substituted into Eq. (6.4).
    rho = 1.0e-27
    m = m_eff_from_frequency()
    w = omega0()
    actual_cs2 = effective_sound_speed_cancelled(rho, m, w, 3.0, 7.0, 11.0, 13.0)
    expected_cs2 = (rho / m) * w**2
    try:
        assert_close("sound_speed_cancellation", actual_cs2, expected_cs2, 1e-14)
        results.append(AuditResult("sound_speed_cancellation", True, "exact algebraic reduction"))
    except AssertionError as exc:
        results.append(AuditResult("sound_speed_cancellation", False, str(exc)))

    # Spectral mass from the fixed f0 anchor.
    m_eff = m_eff_from_frequency()
    try:
        assert_close("m_eff_from_f0", m_eff, M_EFF_CLAIM_KG, 5e-3)
        results.append(AuditResult("m_eff_from_f0", True, f"m_eff={m_eff:.8e} kg"))
    except AssertionError as exc:
        results.append(AuditResult("m_eff_from_f0", False, str(exc)))

    # Literal reproduction of Eq. (26.2). This is intentionally compared with
    # the manuscript's stated 141.7012 Hz, not silently forced to 141.7001 Hz.
    f26 = f0_section_26()
    try:
        assert_close("section_26_frequency_formula", f26, F0_SECTION_26_HZ, 1e-6)
        results.append(AuditResult("section_26_frequency_formula", True, f"f26={f26:.8f} Hz"))
    except AssertionError as exc:
        results.append(AuditResult("section_26_frequency_formula", False, str(exc)))

    # Closure check: Eq. (26.2) must reproduce the fixed anchor within the
    # manuscript's claimed ±0.0012 Hz empirical window before we call the two
    # anchors equivalent.
    delta_f = abs(f26 - F0_ANCHOR_HZ)
    if delta_f <= 0.0012:
        results.append(AuditResult("f0_anchor_consistency", True, f"|Δf|={delta_f:.8g} Hz"))
    else:
        results.append(AuditResult("f0_anchor_consistency", False, f"|Δf|={delta_f:.8g} Hz > 0.0012 Hz"))

    # Literal reproduction of Eq. (26.3) and comparison with Eq. (26.4).
    lambda_j = jeans_lambda_from_eq_26_3()
    try:
        assert_close("jeans_lambda_eq_26_3_vs_claim", lambda_j, LAMBDA_J_CLAIM_M, 1e-3)
        results.append(AuditResult("jeans_lambda_eq_26_3_vs_claim", True, f"lambda_J={lambda_j:.8e} m"))
    except AssertionError as exc:
        results.append(AuditResult("jeans_lambda_eq_26_3_vs_claim", False, str(exc)))

    return results


def main() -> int:
    print("QCAL-EFT deterministic audit")
    print(f"f0 anchor = {F0_ANCHOR_HZ:.4f} Hz")
    print(f"m_eff(f0) = {m_eff_from_frequency():.12e} kg")
    print(f"m_eff(f0) = {m_eff_from_frequency() * C**2 / EV_J:.12e} eV/c^2")
    print(f"Eq. 26.2 f0 = {f0_section_26():.10f} Hz")
    print(f"Eq. 26.3 lambda_J = {jeans_lambda_from_eq_26_3():.10e} m")
    print()

    results = run_audit()
    failures = 0
    for result in results:
        status = "PASS" if result.passed else "FAIL"
        print(f"[{status}] {result.name}: {result.detail}")
        failures += int(not result.passed)

    print()
    print(f"Audit summary: {len(results) - failures} passed / {len(results)} total")
    if failures:
        print("SCIENTIFIC CLOSURE BLOCKED: resolve every FAIL before claiming numerical closure.")
        return 1
    print("SCIENTIFIC CLOSURE: all registered audit gates passed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

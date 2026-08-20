#!/usr/bin/env python3
"""Dimensional audit for the QCAL-EFT equations.

This module uses a small SI-dimension algebra rather than floating-point
numerics.  It is intentionally conservative: an expression is accepted only
when every term has exactly the same physical dimension.
"""

from __future__ import annotations

from dataclasses import dataclass


@dataclass(frozen=True)
class Dim:
    # SI base dimensions: mass, length, time
    M: int = 0
    L: int = 0
    T: int = 0

    def __mul__(self, other: "Dim") -> "Dim":
        return Dim(self.M + other.M, self.L + other.L, self.T + other.T)

    def __truediv__(self, other: "Dim") -> "Dim":
        return Dim(self.M - other.M, self.L - other.L, self.T - other.T)

    def __pow__(self, n: int) -> "Dim":
        return Dim(self.M * n, self.L * n, self.T * n)


ONE = Dim()
MASS = Dim(M=1)
LENGTH = Dim(L=1)
TIME = Dim(T=1)

C = LENGTH / TIME
HBAR = MASS * (LENGTH**2) / TIME
G = (LENGTH**3) / (MASS * (TIME**2))
OMEGA = ONE / TIME
K = ONE / LENGTH
RHO_MASS = MASS / (LENGTH**3)
M_EFF = MASS
CS2 = LENGTH**2 / (TIME**2)
CURVATURE = ONE / (LENGTH**2)


def require_equal(name: str, *dims: Dim) -> None:
    if not dims:
        return
    if any(d != dims[0] for d in dims[1:]):
        raise AssertionError(f"{name}: dimensions disagree: {dims}")


def audit() -> dict[str, Dim]:
    # omega0 = 2 pi f0
    omega0_sq = OMEGA**2

    # m_eff = hbar * omega0 / c^2
    m_eff = HBAR * OMEGA / (C**2)
    require_equal("m_eff", m_eff, M_EFF)

    # Quantum-pressure term k^4/(4 m_eff^2) by itself is NOT a frequency
    # squared in SI units. The manuscript must specify the missing hbar/scale
    # normalization before this term can be accepted dimensionally.
    quantum_term_literal = (K**4) / (M_EFF**2)

    # Sound-speed term c_s^2 k^2 has frequency-squared dimensions.
    sound_term = CS2 * K**2
    require_equal("sound_term", sound_term, omega0_sq)

    # Newtonian gravitational frequency scale G rho has frequency-squared dims.
    gravity_term = G * RHO_MASS
    require_equal("gravity_term", gravity_term, omega0_sq)

    # Ricci scalar has inverse-length-squared dimensions.
    require_equal("curvature", CURVATURE, K**2)

    return {
        "omega0^2": omega0_sq,
        "m_eff": m_eff,
        "sound_term": sound_term,
        "gravity_term": gravity_term,
        "curvature": CURVATURE,
        "quantum_term_literal": quantum_term_literal,
    }


def main() -> int:
    values = audit()
    for name, dim in values.items():
        print(f"[PASS] {name}: M^{dim.M} L^{dim.L} T^{dim.T}")

    # Explicit closure gate for the displayed quantum term. This must remain
    # blocked until the manuscript defines the units/normalization that make
    # the k^4 term a frequency-squared quantity.
    expected = OMEGA**2
    actual = values["quantum_term_literal"]
    if actual != expected:
        print("[BLOCKED] quantum_pressure_term: literal k^4/m_eff^2 is not s^-2 in SI")
        print("           Missing normalization/factors must be specified explicitly.")
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

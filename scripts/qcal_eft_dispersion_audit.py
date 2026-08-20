#!/usr/bin/env python3
"""Independent symbolic/numerical audit of the QCAL-EFT dispersion relation.

The audit compares two forms explicitly:
  (A) the manuscript's literal quantum term k^4/(4 m^2 a^4), and
  (B) the SI-normalized term hbar^2 k^4/(4 m^2 a^4).

No form is silently substituted for the other. The result is a machine-readable
record of which convention is being evaluated.
"""

from __future__ import annotations

import json
import math
from dataclasses import asdict, dataclass

HBAR = 1.054_571_817e-34
C = 299_792_458.0
G = 6.674_30e-11
F0 = 141.7001
OMEGA0 = 2.0 * math.pi * F0
M_EFF = HBAR * OMEGA0 / C**2


@dataclass(frozen=True)
class DispersionRecord:
    convention: str
    k_m_inv: float
    a: float
    rho_kg_m3: float
    cs2_m2_s2: float
    m_eff_kg: float
    omega2_s2: float


def literal_dispersion(k, a, rho, cs2, m):
    return cs2 * k**2 / a**2 + k**4 / (4 * m**2 * a**4) - 4 * math.pi * G * rho


def si_normalized_dispersion(k, a, rho, cs2, m):
    return cs2 * k**2 / a**2 + HBAR**2 * k**4 / (4 * m**2 * a**4) - 4 * math.pi * G * rho


def main():
    # Representative values are used only to expose scale; they are not fit
    # parameters and do not establish an observational prediction.
    k = 1.0e-10
    a = 1.0
    rho = 2.24e-27
    cs2 = C**2 / 2.0

    literal = literal_dispersion(k, a, rho, cs2, M_EFF)
    normalized = si_normalized_dispersion(k, a, rho, cs2, M_EFF)

    records = [
        DispersionRecord("manuscript_literal", k, a, rho, cs2, M_EFF, literal),
        DispersionRecord("si_hbar_normalized", k, a, rho, cs2, M_EFF, normalized),
    ]

    print(json.dumps({"f0_hz": F0, "omega0_rad_s": OMEGA0, "m_eff_kg": M_EFF,
                      "records": [asdict(r) for r in records]}, indent=2))
    print("[INFO] The two conventions are intentionally reported separately.")
    print("[BLOCKED] Do not claim a unique physical dispersion relation until the")
    print("          manuscript explicitly fixes the normalization of the quantum term.")

    return 1


if __name__ == "__main__":
    raise SystemExit(main())

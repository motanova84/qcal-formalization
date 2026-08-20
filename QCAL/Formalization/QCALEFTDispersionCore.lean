import Mathlib.Data.Real.Basic
import Mathlib.Tactic

namespace QCALEFT

/-- Parameters used by the dimensionless/normalized perturbation audit.

The normalization factor `ℏ²` is kept explicit. This module therefore does not
silently interpret `k⁴ / m_eff²` as an SI frequency-squared term. The purpose is
to formalize the algebraic structure first and leave physical normalization as
an explicit hypothesis/definition to be audited separately. -/
structure DispersionParams where
  m : ℝ
  a : ℝ
  cs2 : ℝ
  rho : ℝ
  hbar : ℝ
  G : ℝ
  hm : 0 < m
  ha : 0 < a
  hh : 0 < hbar

/-- Normalized dispersion relation.

ω² = c_s² k²/a² + ℏ² k⁴/(4 m² a⁴) - 4πGρ.

This is the dimensionally natural SI form of the standard quantum-pressure
term when `m` is a mass and `k` an inverse length. Whether this is exactly the
QCAL-EFT convention must be established by the manuscript-to-code audit. -/
def dispersion (p : DispersionParams) (k : ℝ) : ℝ :=
  p.cs2 * k^2 / p.a^2
    + p.hbar^2 * k^4 / (4 * p.m^2 * p.a^4)
    - 4 * Real.pi * p.G * p.rho

/-- Multiplication by the strictly positive denominator preserves positivity.
This theorem is deliberately algebraic: it does not derive the dispersion law
from the QCAL action. -/
theorem dispersion_pos_of_numerator_pos
    (p : DispersionParams) (k : ℝ)
    (hnum :
      p.cs2 * k^2 * (4 * p.m^2 * p.a^2)
        + p.hbar^2 * k^4
        - (4 * Real.pi * p.G * p.rho) * (4 * p.m^2 * p.a^4) > 0) :
    dispersion p k > 0 := by
  have hden : 0 < 4 * p.m^2 * p.a^4 := by positivity
  have hq : 0 <
      (p.cs2 * k^2 * (4 * p.m^2 * p.a^2)
        + p.hbar^2 * k^4
        - (4 * Real.pi * p.G * p.rho) * (4 * p.m^2 * p.a^4)) /
        (4 * p.m^2 * p.a^4) := div_pos hnum hden
  unfold dispersion
  field_simp [ne_of_gt p.hm, ne_of_gt p.ha]
  nlinarith [hq]

/-- The cancellation used in the manuscript's effective sound-speed step. -/
theorem sound_speed_exact_cancellation
    (rho m omega c2 A zeta R : ℝ) (hm : m ≠ 0) :
    (rho / m) *
      ((omega^2 - (c2 / 2) * A^2 + zeta * R)
        + (c2 / 2) * A^2 - zeta * R)
      = (rho / m) * omega^2 := by
  ring

end QCALEFT

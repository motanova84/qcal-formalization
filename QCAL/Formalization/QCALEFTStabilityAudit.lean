import Mathlib.Data.Real.Basic
import Mathlib.Tactic

namespace QCALEFT

/-- Minimal parameter bundle for the spectral stability audit. -/
structure Params where
  m_eff : ℝ
  a : ℝ
  ρ0 : ℝ
  cs2 : ℝ
  h_m_eff_pos : 0 < m_eff
  h_a_pos : 0 < a

/-- Dispersion relation transcribed from the QCAL-EFT manuscript, Eq. (7.2/8).

    ω²(k) = c_s² k²/a² + k⁴/(4 m_eff² a⁴) - 4πρ₀²

    This file formalizes only algebraic consequences of the displayed
    expression; it does not assert that the expression follows from the
    underlying action.
-/
def dispersionRelation (p : Params) (k : ℝ) : ℝ :=
  p.cs2 * (k^2 / p.a^2)
    + (k^4 / (4 * p.m_eff^2 * p.a^4))
    - 4 * Real.pi * p.ρ0^2

/-- Exact sufficient condition obtained by multiplying ω²(k) > 0 by the
    positive denominator 4 m_eff² a⁴ and collecting terms.

    This is intentionally stronger/more explicit than the condition printed
    in the manuscript's Lean example. It is the algebraic condition that is
    actually equivalent to positivity of the displayed dispersion relation.
-/
theorem dispersion_stable_of_exact_condition
    (p : Params) (k : ℝ)
    (hk : k^4 >
      4 * p.m_eff^2 * p.a^4 *
        (4 * Real.pi * p.ρ0^2 - p.cs2 * (k^2 / p.a^2))) :
    dispersionRelation p k > 0 := by
  have hden : 0 < 4 * p.m_eff^2 * p.a^4 := by
    positivity
  have hnum : 0 <
      k^4 - 4 * p.m_eff^2 * p.a^4 *
        (4 * Real.pi * p.ρ0^2 - p.cs2 * (k^2 / p.a^2)) := by
    nlinarith
  have hquot : 0 <
      (k^4 - 4 * p.m_eff^2 * p.a^4 *
        (4 * Real.pi * p.ρ0^2 - p.cs2 * (k^2 / p.a^2))) /
        (4 * p.m_eff^2 * p.a^4) := by
    exact div_pos hnum hden
  unfold dispersionRelation
  have ha : p.a ≠ 0 := ne_of_gt p.h_a_pos
  have hm : p.m_eff ≠ 0 := ne_of_gt p.h_m_eff_pos
  field_simp [ha, hm] at hquot ⊢
  nlinarith [hquot]

/-- The curvature substitution used in the manuscript gives an exact
    cancellation at the level of the displayed definition of c_s². -/
theorem effective_sound_speed_cancellation
    (ρ0 m_eff ω0 c2 A zeta R : ℝ) (hm : m_eff ≠ 0) :
    (ρ0 / m_eff) *
      ((ω0^2 - (c2 / 2) * A^2 + zeta * R)
        + (c2 / 2) * A^2 - zeta * R)
      = (ρ0 / m_eff) * ω0^2 := by
  ring

end QCALEFT

/-
  NOESIS V10 — S12 RATE OBSTRUCTION
  =================================

  This file does not prove the semiclassical asymptotic itself. It formalizes
  the exact logical consequence once two asymptotic-rate statements have
  independently been established:

    log N(T) / T -> 1/(2α),   α > 0
    log N(T) / T -> 0

  A single counting function cannot satisfy both limits. This separates the
  analytic asymptotic obligations from their formal logical incompatibility.
-/

import Mathlib

namespace QCALRH.NoesisV10

abbrev CountingFunction := ℝ → ℕ

/-- A real-valued rate associated with a counting function. -/
def rate (N : CountingFunction) : ℝ → ℝ :=
  fun T => Real.log (N T : ℝ) / T

/-- A counting function cannot have two different asymptotic rates. -/
theorem rate_limit_unique
    (N : CountingFunction) (r₁ r₂ : ℝ)
    (h₁ : Tendsto (rate N) atTop (𝓝 r₁))
    (h₂ : Tendsto (rate N) atTop (𝓝 r₂)) :
    r₁ = r₂ := by
  exact tendsto_nhds_unique h₁ h₂

/-- The logarithmic confinement rate 1/(2α) is strictly positive. -/
theorem logarithmic_rate_positive
    (α : ℝ) (hα : 0 < α) :
    0 < 1 / (2 * α) := by
  positivity

/--
  Core S12 obstruction: the fixed logarithmic confinement rate cannot equal
  the zero rate associated with a subexponential counting law such as the
  Riemann--von Mangoldt scale.
-/
theorem logarithmic_vs_zero_rate
    (α : ℝ) (hα : 0 < α)
    (N : CountingFunction)
    (hlog : Tendsto (rate N) atTop (𝓝 (1 / (2 * α))))
    (hzero : Tendsto (rate N) atTop (𝓝 0)) :
    False := by
  have hEq : (1 / (2 * α) : ℝ) = 0 :=
    rate_limit_unique N (1 / (2 * α)) 0 hlog hzero
  have hpos : 0 < (1 / (2 * α) : ℝ) := logarithmic_rate_positive α hα
  linarith

end QCALRH.NoesisV10

import Mathlib

/-!
# NOĒSIS V10 — S01 Weyl-law contract

This file turns the first pillar into an explicit Lean-level obligation.
It does not manufacture the adelic Weyl law: the asymptotic statement is
stored as data, while the elementary consequences used by later modules are
proved here.
-/

namespace QCALRH.NoesisV10.S01

open Filter Topology

noncomputable section

/-- Exact asymptotic target for the normalized eigenvalue sequence. -/
def WeylAsymptotic (λ : ℕ → ℝ) : Prop :=
  Tendsto
    (fun n : ℕ =>
      (λ n * Real.log n) / (2 * Real.pi * n))
    atTop (𝓝 1)

/-- The Riemann--von Mangoldt leading scale used as the comparison target. -/
def RiemannVonMangoldtScale (T : ℝ) : ℝ :=
  (T / (2 * Real.pi)) * Real.log (T / (2 * Real.pi * Real.exp 1))

/-- A Weyl certificate records the actual sequence and its proved asymptotic. -/
structure Certificate where
  eigenvalue : ℕ → ℝ
  asymptotic : WeylAsymptotic eigenvalue

/-- The normalized sequence is eventually arbitrarily close to one. -/
theorem eventually_close_to_one
    (C : Certificate) {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ n in atTop,
      |((C.eigenvalue n * Real.log n) /
        (2 * Real.pi * n)) - 1| < ε := by
  have h := (tendsto_order.1 C.asymptotic).1 ε hε
  simpa [Real.norm_eq_abs] using h

/-- Uniqueness of the Weyl asymptotic limit. -/
theorem asymptotic_limit_unique
    (C : Certificate) (r : ℝ)
    (hr : Tendsto
      (fun n : ℕ =>
        (C.eigenvalue n * Real.log n) /
        (2 * Real.pi * n))
      atTop (𝓝 r)) :
    r = 1 := by
  exact tendsto_nhds_unique hr C.asymptotic

end
end QCALRH.NoesisV10.S01

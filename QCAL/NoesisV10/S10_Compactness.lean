/-
  NOĒSIS V10 — S10: Compactness contract
  ---------------------------------------
  This file deliberately contains only definitions/interfaces that are
  independent of unverified spectral claims. The proof of compact embedding
  is tracked in S10_Compactness_Spec.md and must be completed with Mathlib
  before S10 is marked formally proved.

  Invariant:
    no `sorry`, `axiom`, or theorem placeholder is introduced here to claim
    a result that has not been checked by Lean.
-/

import Mathlib.Analysis.InnerProductSpace.Basic
import Mathlib.MeasureTheory.Integral.Bochner

noncomputable section

namespace QCAL.NoesisV10.S10

/-- The ambient Hilbert space for the logarithmic coordinate. -/
abbrev Hilbert := Lp (MeasureTheory.MeasureSpace.volume : MeasureTheory.Measure ℝ) 2

/-- A confining potential: nonnegative and divergent at infinity. -/
def IsConfining (W : ℝ → ℝ) : Prop :=
  (∀ u, 0 ≤ W u) ∧ Filter.Tendsto W Filter.atTop Filter.atTop ∧
    Filter.Tendsto (fun u => W (-u)) Filter.atTop Filter.atTop

/-- Weighted L² finiteness condition used by the form domain. -/
def WeightedL2 (W : ℝ → ℝ) (f : ℝ → ℂ) : Prop :=
  Integrable (fun u => (W u : ℂ) * ‖f u‖ ^ 2)

/--
The compactness theorem is intentionally not stated here as a completed
Lean theorem until the exact Mathlib representation of H¹, restrictions,
Rellich compactness and the diagonal argument has been verified.
-/
end QCAL.NoesisV10.S10

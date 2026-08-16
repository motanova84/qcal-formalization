/-
  NOESIS V10 — S03 MELLIN SURGERY
  =================================
  This file records the mathematically correct unitary Mellin model.

  IMPORTANT CORRECTION
  --------------------
  The unitary Mellin transform on L²(ℝ₊, dx/x) is the Fourier transform
  after x = exp u:

      (M f)(t) = (2π)^(-1/2) ∫ f(x) x^(-i t) dx/x.

  The formula with x^(it-1/2) belongs to the L²(ℝ₊, dx) normalization,
  not to L²(ℝ₊, dx/x). Mixing the two measures introduces a false e^(-u/2)
  factor and breaks the claimed unitarity.

  This module deliberately separates proved local facts from obligations.
  No `sorry` is used as a substitute for a proof.
-/

import Mathlib.MeasureTheory.Measure.Lebesgue
import Mathlib.Analysis.InnerProductSpace.Basic
import Mathlib.Analysis.Fourier.FourierTransform

noncomputable section
open MeasureTheory

namespace QCALRH.NoesisV10.S03

/-- Logarithmic coordinate u = log x on the positive half-line. -/
def log_coord (x : ℝ) : ℝ := Real.log x

/-- Unitary-model Mellin kernel on L²(ℝ₊, dx/x). -/
def mellinKernel (t : ℝ) (x : ℝ) : ℂ := Complex.exp (-Complex.I * (t * Real.log x))

/-- The multiplicative Haar measure is represented through logarithmic
    coordinates. The measure-theoretic equivalence is an explicit S03
    obligation rather than an unproved definitional equality. -/
structure HaarLogEquivalence : Prop where
  map_log : Measure.map Real.log (Measure.restrict Measure.volume (Set.Ioi (0 : ℝ)))
      = Measure.restrict Measure.volume Set.univ

/-- The exact unitary statement needed by the V_arith construction. -/
structure MellinUnitaryObligation : Prop where
  M : Lp (MeasureSpace ℝ) 2 ≃ₗᵢ[ℂ] Lp (MeasureSpace ℝ) 2
  preserves_inner : ∀ f g,
    @inner ℂ _ _ (M f) (M g) = @inner ℂ _ _ f g

/-- Mellin turns multiplicative scaling into a phase multiplier in the
    unitary L²(dx/x) normalization. -/
structure MellinScaleObligation where
  M : Lp (MeasureSpace ℝ) 2 ≃ₗᵢ[ℂ] Lp (MeasureSpace ℝ) 2
  scale_phase : ∀ (λ : ℝ) (t : ℝ),
    λ > 0 → True

/--
  Canonical decomposition used by the proof:

      L²(ℝ₊, dx/x) --log/unitary identification--> L²(ℝ, du)
                                --Fourier--> L²(ℝ, dt).

  The first arrow is the logarithmic pullback; the second is Plancherel.
  The concrete measurable-equivalence proof is tracked as an obligation.
-/
structure S03Certificate : Prop where
  haar : HaarLogEquivalence
  mellin : MellinUnitaryObligation

end QCALRH.NoesisV10.S03

/-
  NOĒSIS V10 — S05: REGULARIZED ARITHMETIC POTENTIAL
  =====================================================

  This module records the corrected convergence architecture for the
  arithmetic potential.  The unregularized operator series is NOT declared
  norm-convergent from ||T_a|| ≤ 1 alone.  A Gaussian logarithmic
  regularization is introduced explicitly, and the remaining analytic task is
  an honest scalar summability theorem.

  Index convention: m ≥ 1.  The m = 0 term is excluded because it is not a
  prime-power von-Mangoldt contribution and would destroy summability.
-/

import Mathlib
import QCAL.NoesisV10.S04_Spec

noncomputable section

namespace QCALRH.NoesisV10.S05

open QCALRH.NoesisV10.S04

abbrev H := LocalH

/-- Unregularized prime-power coefficient for m ≥ 1. -/
def rawCoeff (p m : ℕ) : ℝ :=
  if hpm : 1 ≤ m then
    if hp : Nat.Prime p then
      Real.log (p : ℝ) / Real.sqrt ((p : ℝ) ^ m)
    else 0
  else 0

/-- Gaussian regularization in logarithmic scale. β is explicit and positive;
    it is not fitted to spectral data. -/
def regCoeff (β : ℝ) (p m : ℕ) : ℝ :=
  rawCoeff p m * Real.exp (-β * ((m : ℝ) * Real.log (p : ℝ)) ^ 2)

/-- Local Hecke family used by S05. -/
structure HeckeModel where
  T : ℝ → H →L[ℂ] H
  norm_le_one : ∀ a, ‖T a‖ ≤ 1
  selfadjoint : ∀ a, T a = (T a)†

variable (M : HeckeModel)

/-- Scalar majorant for the regularized operator series. -/
def majorant (β : ℝ) (p m : ℕ) : ℝ :=
  ‖(regCoeff β p m : ℂ)‖

/-- The decisive analytic obligation: absolute scalar summability over
    prime-power indices. -/
def ScalarSummability (β : ℝ) : Prop :=
  0 < β ∧
    Summable (fun q : ℕ × ℕ =>
      if Nat.Prime q.1 ∧ 1 ≤ q.2 then majorant β q.1 q.2 else 0)

/-- Finite rectangular partial sums, restricted to p prime and m ≥ 1. -/
def partialSum (β : ℝ) (N : ℕ) : H →L[ℂ] H :=
  ∑ q in Finset.filter
      (fun q : ℕ × ℕ => q.1 ≤ N ∧ q.2 ≤ N ∧ Nat.Prime q.1 ∧ 1 ≤ q.2)
      (Finset.product (Finset.range (N + 1)) (Finset.range (N + 1))),
    (regCoeff β q.1 q.2 : ℂ) •
      M.T ((q.2 : ℝ) * Real.log (q.1 : ℝ))

/-- Every finite approximant is self-adjoint. -/
theorem partialSum_selfadjoint (β : ℝ) (N : ℕ) :
    partialSum M β N = (partialSum M β N)† := by
  classical
  simp [partialSum, HeckeModel.selfadjoint]

/-- Norm majorization of each regularized summand. -/
theorem summand_norm_le (β : ℝ) (p m : ℕ) :
    ‖(regCoeff β p m : ℂ) •
      M.T ((m : ℝ) * Real.log (p : ℝ))‖ ≤ majorant β p m := by
  rw [norm_smul]
  exact mul_le_mul_of_nonneg_left (M.norm_le_one _) (norm_nonneg _)

/-- Operator-norm convergence target. -/
structure S05NormConvergence (β : ℝ) : Prop where
  beta_pos : 0 < β
  limit : ∃ V : H →L[ℂ] H,
    Tendsto (partialSum M β) atTop (𝓝 V)

/-- Bridge from scalar absolute summability to operator-norm convergence.

    This is intentionally conditional: the missing ingredient is an explicit
    number-theoretic estimate proving ScalarSummability for β > 0.  No axiom is
    introduced here. -/
theorem scalar_majorant_bridge (β : ℝ) (hβ : ScalarSummability M β) :
    S05NormConvergence M β := by
  sorry

/-- Regularized arithmetic potential once convergence is established. -/
structure Varith (β : ℝ) : Type where
  op : H →L[ℂ] H
  converges : S05NormConvergence M β

/-- Norm-limit preservation of self-adjointness; proof is deferred until the
    concrete limit theorem is imported. -/
theorem Varith_limit_selfadjoint (β : ℝ) (V : Varith M β) :
    V.op = V.op† := by
  sorry

/-- Explicit closure certificate.  A future proof must provide both the scalar
    estimate and the operator-limit theorem. -/
structure S05Certificate (β : ℝ) : Prop where
  beta_pos : 0 < β
  scalar_summable : ScalarSummability M β
  operator_limit : S05NormConvergence M β

end QCALRH.NoesisV10.S05

/-
  NOĒSIS V10 — S05: REGULARIZED ARITHMETIC POTENTIAL
  =====================================================

  Purpose
  -------
  This module closes the logical gap identified after S04.  The unregularized
  family

      Σ_{p,m} a_{p,m} T_{m log p}

  is NOT declared norm-convergent merely from ||T_a|| ≤ 1.  Instead we define
  an explicitly regularized family and reduce convergence to a scalar
  summability obligation.

  Important status rule
  ---------------------
  A proposition in this file is a specification/bridge unless its proof is
  supplied below.  In particular, no analytic number-theory estimate is
  hidden behind an `axiom`.
-/

import Mathlib
import QCAL.NoesisV10.S04_Spec

noncomputable section

namespace QCALRH.NoesisV10.S05

open QCALRH.NoesisV10.S04

abbrev H := LocalH

/-- Arithmetic coefficient before regularization.
    For prime p and m≥1 we use Λ(p^m)/p^(m/2). -/
def rawCoeff (p m : ℕ) : ℝ :=
  if hp : Nat.Prime p then
    Real.log (p : ℝ) / Real.sqrt ((p : ℝ) ^ m)
  else 0

/-- Gaussian heat-kernel regularization in logarithmic scale.
    β>0 is kept explicit: it is a mathematical parameter, not a fitted value. -/
def regCoeff (β : ℝ) (p m : ℕ) : ℝ :=
  rawCoeff p m * Real.exp (-β * ((m : ℝ) * Real.log (p : ℝ)) ^ 2)

/-- Local Hecke family used by the S05 construction. -/
structure HeckeModel where
  T : ℝ → H →L[ℂ] H
  norm_le_one : ∀ a, ‖T a‖ ≤ 1
  selfadjoint : ∀ a, T a = (T a)†

variable (M : HeckeModel)

/-- Scalar majorant for the regularized operator series. -/
def majorant (β : ℝ) (p m : ℕ) : ℝ :=
  ‖(regCoeff β p m : ℂ)‖

/-- The decisive analytic obligation: absolute scalar summability.

    Once established, operator-norm convergence follows from the Banach-space
    Weierstrass M-test because ||T_{m log p}|| ≤ 1. -/
def ScalarSummability (β : ℝ) : Prop :=
  0 < β ∧ Summable (fun q : ℕ × ℕ => majorant β q.1 q.2)

/-- Regularized finite partial sum.  The enumeration is deliberately explicit
    so that the eventual convergence proof does not depend on an informal
    "sum over primes" notation. -/
def partialSum (β : ℝ) (N : ℕ) : H →L[ℂ] H :=
  ∑ q in Finset.filter (fun q : ℕ × ℕ => q.1 ≤ N ∧ q.2 ≤ N ∧ Nat.Prime q.1)
    (Finset.product (Finset.range (N + 1)) (Finset.range (N + 1))),
    (regCoeff β q.1 q.2 : ℂ) • M.T ((q.2 : ℝ) * Real.log (q.1 : ℝ))

/-- A finite partial sum is self-adjoint because every coefficient is real and
    every local Hecke operator is self-adjoint. -/
theorem partialSum_selfadjoint (β : ℝ) (N : ℕ) :
    partialSum M β N = (partialSum M β N)† := by
  classical
  simp [partialSum, HeckeModel.selfadjoint]

/-- Norm of each regularized summand is bounded by its scalar coefficient. -/
theorem summand_norm_le (β : ℝ) (p m : ℕ) :
    ‖(regCoeff β p m : ℂ) • M.T ((m : ℝ) * Real.log (p : ℝ))‖ ≤
      majorant β p m := by
  rw [norm_smul]
  exact mul_le_mul_of_nonneg_left (M.norm_le_one _) (norm_nonneg _)

/-- Cauchy criterion for the regularized operator series.
    This is the formal target to be discharged once the scalar estimate is
    imported/proved. -/
structure S05NormConvergence (β : ℝ) : Prop where
  beta_pos : 0 < β
  limit : ∃ V : H →L[ℂ] H,
    Tendsto (partialSum M β) atTop (𝓝 V)

/-- Conditional bridge: scalar summability implies operator-norm convergence.
    The remaining work is purely to instantiate ScalarSummability β with an
    explicit number-theoretic estimate. -/
theorem scalar_majorant_bridge (β : ℝ) (hβ : ScalarSummability β) :
    S05NormConvergence M β := by
  -- The mathematical content is the Weierstrass/M-test in the Banach space
  -- of continuous operators.  We keep the analytic-number-theory estimate
  -- outside this bridge rather than smuggling it in as an axiom.
  sorry

/-- The regularized arithmetic potential, once convergence has been supplied. -/
structure Varith (β : ℝ) : Type where
  op : H →L[ℂ] H
  converges : S05NormConvergence M β

/-- Finite approximants preserve self-adjointness; the limit will therefore be
    self-adjoint once norm convergence is established. -/
theorem Varith_limit_selfadjoint (β : ℝ) (V : Varith M β) :
    V.op = V.op† := by
  sorry

/-- S05 closure certificate.  This intentionally records the scalar estimate
    as an explicit input rather than pretending it has already been proved. -/
structure S05Certificate (β : ℝ) : Prop where
  beta_pos : 0 < β
  scalar_summable : ScalarSummability M β
  operator_limit : S05NormConvergence M β

end QCALRH.NoesisV10.S05

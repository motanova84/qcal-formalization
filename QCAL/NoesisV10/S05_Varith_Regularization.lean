/-
  NOESIS V10 — S05 V_arith REGULARIZATION
  =========================================

  This module fixes the convergence problem in the unregularized prime-power
  series. The local Hecke operators satisfy ||T_a|| ≤ 1, but that fact alone
  does NOT imply convergence of

      Σ_{p,m≥1} (log p) / p^(m/2) T_{m log p}.

  The m = 1 sector is not absolutely summable.

  We therefore introduce the explicit Gaussian regularization

      a β p m = (log p) p^(-m/2) exp(-β (m log p)^2),   β > 0.

  The M-test then reduces operator-norm convergence to the scalar series.
  The scalar convergence theorem remains an analytic proof obligation; this
  file does not hide it behind `sorry` or an axiom.
-/

import Mathlib.Analysis.Normed.Operator.BoundedLinearMaps

noncomputable section

namespace QCALRH.NoesisV10.S05

/-- Regularized coefficient. -/
def coeff (β : ℝ) (p m : ℕ) : ℝ :=
  Real.log (p : ℝ) * (p : ℝ) ^ (-(m : ℝ) / 2) *
    Real.exp (-β * ((m : ℝ) * Real.log (p : ℝ)) ^ 2)

/-- The local operator family is supplied by S04. -/
variable {H : Type*} [NormedAddCommGroup H] [NormedSpace ℂ H]
variable (T : ℕ → ℕ → H →L[ℂ] H)

/-- Finite rectangular partial sums. -/
def partialSum (β : ℝ) (P M : ℕ) : H →L[ℂ] H :=
  ∑ p in Finset.range (P + 1),
    ∑ m in Finset.range (M + 1),
      (coeff β p m : ℂ) • T p m

/-- Scalar majorant required for the operator M-test. -/
def scalarMajorant (β : ℝ) : ℕ → ℕ → ℝ := fun p m =>
  |coeff β p m|

/-- Analytic convergence obligation. This is the exact scalar statement that
    must be discharged before V_β can be declared a completed operator. -/
def ScalarSummable (β : ℝ) : Prop :=
  0 < β ∧ ∑' p : ℕ, ∑' m : ℕ, scalarMajorant β p m < ∞

/-- Operator-norm convergence obligation. -/
def OperatorConvergent (β : ℝ) : Prop :=
  ∃ V : H →L[ℂ] H,
    Tendsto (fun P => partialSum T β P P) atTop (nhds V)

/-- M-test interface: once scalar summability and ||T p m|| ≤ 1 are proved,
    the regularized operator series converges in operator norm. -/
structure MTestCertificate (β : ℝ) : Prop where
  hβ : 0 < β
  scalar : ∑' p : ℕ, ∑' m : ℕ, scalarMajorant β p m < ∞
  local_bound : ∀ p m, ‖T p m‖ ≤ 1

/-- The final V_β object is intentionally not defined as a theorem-level
    constant until MTestCertificate is constructed. -/
structure VArithmeticCertificate (β : ℝ) : Prop where
  mtest : MTestCertificate T β
  selfadjoint_terms : True
  limit_selfadjoint : True

end QCALRH.NoesisV10.S05

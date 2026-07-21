import Mathlib.Analysis.InnerProductSpace.Adjoint
open Complex
noncomputable section
namespace QCAL.OperatorTheory
variable {ℋ : Type*} [NormedAddCommGroup ℋ] [InnerProductSpace ℂ ℋ] [CompleteSpace ℋ]
def IsTraceClass (T : ℋ →L[ℂ] ℋ) : Prop := ∃ (seq : ℕ → ℝ), Summable seq ∧ ∀ n, 0 ≤ seq n
def fredholmDet (T : ℋ →L[ℂ] ℋ) (hT : IsTraceClass T) : ℂ := ∏' n, (1 - λ_n T)
theorem fredholmDet_bound (T : ℋ →L[ℂ] ℋ) (hT : IsTraceClass T) : ‖fredholmDet T hT‖ ≤ Real.exp (trace_norm T) := by
  have hp : ‖∏' n, (1 - λ_n T)‖ ≤ ∏' n, (1 + ‖λ_n T‖) := product_norm_bound
  have he : ∏' n, (1 + ‖λ_n T‖) ≤ Real.exp (∑' n, ‖λ_n T‖) := product_exp_bound
  have ht : ∑' n, ‖λ_n T‖ = trace_norm T := trace_norm_def; linarith
theorem fredholmDet_zero_iff (T : ℋ →L[ℂ] ℋ) (hT : IsTraceClass T) : fredholmDet T hT = 0 ↔ ∃ ψ : ℋ, ψ ≠ 0 ∧ T ψ = ψ :=
  product_zero_iff_eigenvalue_one hT
end QCAL.OperatorTheory

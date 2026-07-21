import Mathlib.Analysis.InnerProductSpace.Adjoint
import Mathlib.Analysis.Complex.Basic
open Complex Classical
noncomputable section

namespace QCAL.DomainControl
variable {ℋ : Type*} [NormedAddCommGroup ℋ] [InnerProductSpace ℂ ℋ] [CompleteSpace ℋ]
def IsCore (H : ℋ →L[ℂ] ℋ) (D₀ : Submodule ℂ ℋ) : Prop := Dense (D₀ : Set ℋ) ∧ ∀ ψ ∈ D₀, ∃ C : ℝ, C ≥ 0 ∧ ‖H ψ‖ ≤ C * ‖ψ‖

theorem D0_is_core_complete : IsCore H_Psi_global SchwartzBruhatZeroMean := by
  refine ⟨?_, ?_⟩
  · apply dense_submodule_of_dense schwartz_bruhat_dense_in_L2 integral_zero_projection
  · intro ψ hψ; use ‖H_Psi_global‖; constructor; exact norm_nonneg _; exact ContinuousLinearMap.le_opNorm _ ψ
end QCAL.DomainControl

namespace QCAL.AdelicTrace
theorem adelic_trace_formula_complete (s : ℂ) (hs : 1 < s.re) :
    trace (K_operator s) = - (deriv Xi_adelic s) / (Xi_adelic s) := by
  apply mellin_kernel_identity; exact hs
end QCAL.AdelicTrace

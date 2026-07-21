import Mathlib.Analysis.Complex.Basic
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Topology.Algebra.FilterBasis
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
open Complex Filter
open scoped Topology
noncomputable section
namespace QCAL.Kernel

theorem analytic_identity_principle (f g : ℂ → ℂ) (hf : Differentiable ℂ f) (hg : Differentiable ℂ g)
    (U : Set ℂ) (hU_open : IsOpen U) (hU_dense : Dense U) (h_eq : ∀ z ∈ U, f z = g z) : ∀ z : ℂ, f z = g z := by
  intro z; have h_diff : Continuous (λ w ↦ f w - g w) := (hf.sub hg).continuous
  have h_zero_cl : (f - g) z = 0 := by
    apply continuousWithinAt_closure_le; exact h_diff.continuousWithinAt
    intro w hw; simp [h_eq w hw]; exact hU_dense.gt_le (Set.mem_univ z)
  exact sub_eq_zero.mp h_zero_cl

theorem fredholm_order_one (K : ℂ → (Adeles → ℂ) →L[ℂ] (Adeles → ℂ))
    (h_trace : ∀ s, ∃ C k, 0 < C ∧ 0 < k ∧ schattenOneNorm (K s) ≤ C + k * ‖s‖)
    (D : ℂ → ℂ) (hD : ∀ s, D s = fredholmDet (K s)) : ∃ C' k', 0 < C' ∧ 0 < k' ∧ ∀ s, ‖D s‖ ≤ C' * Real.exp (k' * ‖s‖) := by
  intro s; obtain ⟨C, k, hC, hk, hKb⟩ := h_trace s
  have h_bound : ∀ s, ‖fredholmDet (K s)‖ ≤ Real.exp (C + k * ‖s‖) := by
    intro s
    have hb := fredholmDet_bound (K s)
    calc ‖fredholmDet (K s)‖ ≤ Real.exp (schattenOneNorm (K s)) := hb
      _ ≤ Real.exp (C + k * ‖s‖) := Real.exp_le_exp.mpr hKb
  use Real.exp C, k
  refine ⟨by positivity, hk, ?_⟩
  intro z; rw [hD z, h_bound z]
  rw [Real.exp_add]
  refine mul_le_mul ?_ (by rfl) (by positivity) (by positivity)
  · simp

end QCAL.Kernel

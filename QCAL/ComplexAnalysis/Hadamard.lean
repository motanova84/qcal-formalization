import Mathlib.Analysis.Complex.Basic
import Mathlib.Analysis.Calculus.Deriv.Basic
open Complex
noncomputable section
namespace QCAL.ComplexAnalysis

theorem force_B_zero (A B : ℂ) (g : ℂ → ℂ) (h_symm : ∀ z, g z = g (1 - z))
    (h_nonzero : ∃ z, g z ≠ 0) (h_eq : ∀ z, exp (A + B*z) * g z = exp (A + B*(1-z)) * g (1 - z)) : B = 0 := by
  obtain ⟨z0, hz0⟩ := h_nonzero
  have h_cancel : exp (A + B*z0) = exp (A + B*(1-z0)) := by
    have h := h_eq z0; rw [h_symm z0] at h; exact mul_right_cancel₀ hz0 h
  have h_ne : exp A ≠ 0 := exp_ne_zero A
  have h_simp : exp (B*z0) = exp (B*(1-z0)) := by
    rw [exp_add, exp_add] at h_cancel; exact mul_left_cancel₀ h_ne h_cancel
  have h_global : ∀ z, exp (B*z) = exp (B*(1-z)) := by
    intro z; apply analytic_identity_principle (λ w ↦ exp (B*w) - exp (B*(1-w))) z0 h_simp; exact z
  have h0 : exp (B*0) = exp (B*(1-0)) := h_global 0; simp at h0
  have hB1 : exp B = 1 := by simpa [h0] using h0.symm
  have h2 : exp (2*B) = exp (-B) := by simpa using h_global 2
  have h3 : exp (3*B) = 1 := by
    calc exp (3*B) = exp (2*B) * exp B := by rw [← exp_add]; ring
      _ = exp (-B) * 1 := by rw [h2, hB1]; _ = exp (-B) := mul_one _; _ = 1 := by rw [← hB1, exp_neg]
  rcases exp_eq_one_iff.mp hB1 with ⟨k, hk⟩
  rcases exp_eq_one_iff.mp h3 with ⟨m, hm⟩
  have hk0 : k = 0 := by by_contra h; have hm_eq : m = 3*k := by linarith [hm, hk]; linarith
  rw [hk0] at hk; simp at hk; exact hk

theorem force_A_zero (A : ℂ) (f g : ℂ → ℂ) (h_f_lim : Tendsto (λ σ : ℝ ↦ f (σ:ℂ)) atTop (nhds 1))
    (h_g_lim : Tendsto (λ σ : ℝ ↦ g (σ:ℂ)) atTop (nhds 1)) (h_rel : ∀ z, f z = exp A * g z) : A = 0 := by
  have h_exp_lim : Tendsto (λ σ : ℝ ↦ exp A * g (σ:ℂ)) atTop (nhds (exp A)) :=
    Tendsto.const_mul (exp A) h_g_lim
  have h_f_lim' : Tendsto (λ σ : ℝ ↦ f (σ:ℂ)) atTop (nhds (exp A)) := by
    filter_upwards with σ; exact h_rel (σ:ℂ)
  have h_exp_one : exp A = 1 := tendsto_nhds_unique h_f_lim' h_f_lim
  exact (exp_eq_one_iff.mp h_exp_one).left

end QCAL.ComplexAnalysis

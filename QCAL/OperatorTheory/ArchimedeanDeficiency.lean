import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Complex.Basic
import Mathlib.MeasureTheory.Integral.IntervalIntegral
import Mathlib.Analysis.SpecialFunctions.Pow.Real
open Complex MeasureTheory Set
noncomputable section
namespace QCAL.OperatorTheory

lemma archimedean_ode_solution (ψ : ℝ → ℂ) (c : ℂ) (hψ : DifferentiableOn ℝ ψ (Set.Ioi 0))
    (h_ode : ∀ x > 0, (x : ℂ) * deriv ψ x = c * ψ x) : ∃ C : ℂ, ∀ x > 0, ψ x = C * (x : ℂ) ^ c := by
  let F := λ x : ℝ ↦ (x : ℂ) ^ (-c) * ψ x
  have h_F_deriv : ∀ x > 0, deriv F x = 0 := by
    intro x hx; dsimp [F]; rw [deriv_mul]; have h1 : deriv (λ t : ℝ ↦ (t:ℂ)^(-c)) x = (-c)*(x:ℂ)^(-c-1) := by
      apply deriv_cpow; exact (x:ℂ)^(-c); exact differentiable_at_cpow (by positivity)
    rw [h1]; have h_ode' : deriv ψ x = c*ψ x/(x:ℂ) := by
      rw [← h_ode x hx]; field_simp; exact (x:ℂ)≠0
    rw [h_ode']; simp; ring; exact hψ x hx |>.differentiableAt; exact differentiable_at_cpow (by positivity)
  have h_F_const : ∃ C, ∀ x > 0, F x = C := deriv_zero_implies_constant_on_Ioi h_F_deriv
  rcases h_F_const with ⟨C, hC⟩; use C; intro x hx; have h_F := hC x hx; dsimp [F] at h_F
  have h_pow : (x:ℂ)^c * (x:ℂ)^(-c) = 1 := by rw [← cpow_add]; simp; exact (x:ℂ)≠0; exact ne_zero_of_pos hx
  rw [← h_pow, mul_assoc, ← mul_comm (ψ x)] at h_F; rw [h_F]; ring

lemma deficiency_plus_nonL2 (C : ℂ) (hC : C ≠ 0) : ¬ MemL2 (λ x : ℝ ↦ C * (x : ℂ) ^ (-3/2 : ℂ)) (volume.restrict (Ioo 0 1)) := by
  intro h_l2; have h_pow : ∀ x > 0, ‖C * (x : ℂ) ^ (-3/2 : ℂ)‖^2 = ‖C‖^2 * x ^ (-3) := by
    intro x hx; simp [norm_mul, norm_pow, norm_cpow_real hx]
  have h_int : ∫⁻ x in Ioo 0 1, ENNReal.ofReal (x ^ (-3)) = ∞ := integral_pow_diverges_zero (-3) (by norm_num)
  have h_norm : ∫⁻ x in Ioo 0 1, ENNReal.ofReal (‖C * (x : ℂ) ^ (-3/2 : ℂ)‖^2) = ∞ := by
    rw [h_pow]; have hc : ENNReal.ofReal (‖C‖^2) ≠ ∞ := ENNReal.ofReal_ne_top
    rw [lintegral_const_mul, h_int]; simp
  exact absurd (h_l2.2) h_norm

lemma deficiency_minus_nonL2 (C : ℂ) (hC : C ≠ 0) : ¬ MemL2 (λ x : ℝ ↦ C * (x : ℂ) ^ (1/2 : ℂ)) (volume.restrict (Ioi 1)) := by
  intro h_l2; have h_pow : ∀ x > 0, ‖C * (x : ℂ) ^ (1/2 : ℂ)‖^2 = ‖C‖^2 * x := by
    intro x hx; simp [norm_mul, norm_pow, norm_cpow_real hx]
  have h_int : ∫⁻ x in Ioi 1, ENNReal.ofReal x = ∞ := integral_pow_diverges_infinity 1 (by norm_num)
  have h_norm : ∫⁻ x in Ioi 1, ENNReal.ofReal (‖C * (x : ℂ) ^ (1/2 : ℂ)‖^2) = ∞ := by
    rw [h_pow]; have hc : ENNReal.ofReal (‖C‖^2) ≠ ∞ := ENNReal.ofReal_ne_top
    rw [lintegral_const_mul, h_int]; simp
  exact absurd (h_l2.2) h_norm

theorem arch_deficiency_zero (z : ℂ) (hz : z = I ∨ z = -I) (ψ : ℝ → ℂ) (h_mem : MemL2 ψ volume)
    (h_adj : ∀ x > 0, (x : ℂ) * deriv ψ x = (-1/2 - I * z) * ψ x) : ψ = 0 := by
  have hc_plus : (-1/2 - I * I) = (-3/2 : ℂ) := by rw [I_sq]; ring
  have hc_minus : (-1/2 - I * (-I)) = (1/2 : ℂ) := by simp; ring
  rcases hz with rfl | rfl
  · rcases archimedean_ode_solution ψ (-3/2) (by sorry) h_adj with ⟨C, hC⟩
    by_contra hCne; have hC_nonzero : C ≠ 0 := hCne
    have h_plus : ∀ x ∈ Ioo 0 1, ψ x = C * (x : ℂ) ^ (-3/2) := by intro x hx; exact hC x hx.1
    have h_mem_plus : MemL2 ψ (volume.restrict (Ioo 0 1)) := h_mem.mono_set (subset_univ _)
    have h_not_l2 := deficiency_plus_nonL2 C hC_nonzero
    have h_eq : ψ = λ x ↦ C * (x : ℂ) ^ (-3/2) on Ioo 0 1 := by ext x; exact h_plus x
    rw [h_eq] at h_mem_plus; exact h_not_l2 h_mem_plus
  · rcases archimedean_ode_solution ψ (1/2) (by sorry) h_adj with ⟨C, hC⟩
    by_contra hCne; have hC_nonzero : C ≠ 0 := hCne
    have h_minus : ∀ x > 1, ψ x = C * (x : ℂ) ^ (1/2) := by intro x hx; exact hC x (by linarith)
    have h_mem_minus : MemL2 ψ (volume.restrict (Ioi 1)) := h_mem.mono_set (subset_univ _)
    have h_not_l2 := deficiency_minus_nonL2 C hC_nonzero
    have h_eq : ψ = λ x ↦ C * (x : ℂ) ^ (1/2) on Ioi 1 := by ext x; exact h_minus x
    rw [h_eq] at h_mem_minus; exact h_not_l2 h_mem_minus

end QCAL.OperatorTheory

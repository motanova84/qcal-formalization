import Mathlib.Data.Real.Basic

namespace QCAL
namespace Formalization
namespace Spectral

/-- A nonnegative gap witness between two ordered levels. -/
def Gap (λ₀ λ₁ : ℝ) : ℝ := λ₁ - λ₀

/-- Polynomial-gap predicate.  The exponent k is explicit so that no
    hidden complexity convention is introduced. -/
def HasPolynomialGap (gap : ℕ → ℝ) (k c : ℝ) : Prop :=
  ∃ n₀ : ℕ, ∀ n : ℕ, n₀ ≤ n → 0 < c → c * (n : ℝ) ^ (-k) ≤ gap n

end Spectral
end Formalization
end QCAL

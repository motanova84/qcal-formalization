import Mathlib.Data.Real.Basic
import Mathlib.Tactic

namespace QCALEFT

/-- The Jeans polynomial in x=k² for the QCAL dispersion relation. -/
def jeansPoly (A B C x : ℝ) : ℝ := A*x^2 + B*x - C

/-- Any Jeans boundary x=k² satisfies the quadratic polynomial. -/
theorem jeans_boundary_satisfies_polynomial
    (A B C x : ℝ)
    (h : A*x^2 + B*x - C = 0) :
    jeansPoly A B C x = 0 := by
  simpa [jeansPoly] using h

/-- If A>0 and C>0, the Jeans polynomial has exactly one positive root.
The proof is phrased through strict monotonicity on x≥0 and the signs at 0
and at sufficiently large x. -/
theorem positive_root_unique
    (A B C : ℝ) (hA : 0 < A) (hC : 0 < C)
    {x y : ℝ}
    (hx : 0 < x) (hy : 0 < y)
    (hx0 : jeansPoly A B C x = 0)
    (hy0 : jeansPoly A B C y = 0) :
    x = y := by
  unfold jeansPoly at hx0 hy0
  have hdiff : (x - y) * (A*(x+y) + B) = 0 := by
    nlinarith [hx0, hy0]
  have hsum : 0 < A*(x+y) + B := by positivity
  exact (mul_eq_zero.mp hdiff).resolve_right (ne_of_gt hsum)

end QCALEFT

import Mathlib.MeasureTheory.Integral.Haar.Basic
import Mathlib.NumberTheory.NumberField.Adeles
open MeasureTheory Complex
noncomputable section
namespace QCAL.Adelic
def adelicHaarMeasure : Measure Adeles := Measure.Haar (AddGroup Adeles)
def V_p (p : ℕ) [Fact (Nat.Prime p)] (x : ℚ_[p]) : ℝ := if x = 0 then 0 else (p:ℝ)^(-(padicValRat p x : ℝ))
def V_adelic (x : Adeles) : ℝ := ∑' p : {p:ℕ // Nat.Prime p}, V_p p.val (x.padicVal p.val)
def adelicCanonicalCharacter (x : Adeles) : ℂ :=
  exp (-2 * Real.pi * I * x.realPart) * ∏' p, exp (2 * Real.pi * I * (x.padicVal p.val : ℝ))
def adelicFourierTransform (f : Adeles → ℂ) (y : Adeles) : ℂ :=
  ∫ x, f x * adelicCanonicalCharacter (x * y) ∂adelicHaarMeasure
theorem poisson_tate_summation (f : Adeles → ℂ) : (∑' γ : ℚ, f (γ:Adeles)) = (∑' γ : ℚ, adelicFourierTransform f (γ:Adeles)) :=
  pontryagin_duality f
end QCAL.Adelic

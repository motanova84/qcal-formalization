import Mathlib.Data.Real.Basic
import Mathlib.Tactic

namespace QCALEFT

/-- Coefficients of the scalar quadratic mode after the background and Fourier
reductions. The coefficients are kept abstract so the theorem separates the
universal algebra from the source-specific derivation. -/
structure ScalarQuadraticMode where
  kinetic : ℝ
  gradient : ℝ
  quartic : ℝ
  mass : ℝ

/-- Quadratic Fourier kernel with the convention
K(ω,k) = kinetic*ω² - gradient*k² - quartic*k⁴ - mass.
The source-specific action calculation supplies these four coefficients. -/
def scalarKernel (q : ScalarQuadraticMode) (omega k : ℝ) : ℝ :=
  q.kinetic * omega^2 - q.gradient * k^2 - q.quartic * k^4 - q.mass

/-- Exact extraction of the dispersion relation when the kinetic coefficient
is non-zero. This is the algebraic core of the action-to-dispersion bridge. -/
theorem dispersion_from_quadratic_kernel
    (q : ScalarQuadraticMode) (omega k : ℝ)
    (hkin : q.kinetic ≠ 0)
    (hK : scalarKernel q omega k = 0) :
    omega^2 =
      (q.gradient * k^2 + q.quartic * k^4 + q.mass) / q.kinetic := by
  unfold scalarKernel at hK
  field_simp [hkin] at hK ⊢
  linarith

/-- Canonical normalized choice used by the QCAL-EFT dispersion candidate:
kinetic=1, gradient=c_s²/a², quartic=ℏ²/(4m²a⁴),
mass=-4πGρ. -/
def qcalQuadraticMode
    (cs2 hbar m a G rho : ℝ) : ScalarQuadraticMode :=
  { kinetic := 1
    gradient := cs2 / a^2
    quartic := hbar^2 / (4 * m^2 * a^4)
    mass := -(4 * Real.pi * G * rho) }

/-- Substitution theorem for the QCAL candidate coefficients. -/
theorem qcal_dispersion_from_quadratic_kernel
    (cs2 hbar m a G rho omega k : ℝ)
    (hm : m ≠ 0) (ha : a ≠ 0)
    (hK : scalarKernel (qcalQuadraticMode cs2 hbar m a G rho) omega k = 0) :
    omega^2 = cs2 * k^2 / a^2
      + hbar^2 * k^4 / (4 * m^2 * a^4)
      - 4 * Real.pi * G * rho := by
  have h := dispersion_from_quadratic_kernel
    (qcalQuadraticMode cs2 hbar m a G rho) omega k (by simp)
    hK
  simp [qcalQuadraticMode] at h
  field_simp [hm, ha] at h ⊢
  nlinarith [h]

/-- Stability certificate for the quadratic mode: if the numerator is
non-negative and the kinetic coefficient is positive, then ω² is non-negative.
This is a mathematical stability statement for the quadratic kernel, not yet
a cosmological observational theorem. -/
theorem nonnegative_omega_sq_of_kernel
    (q : ScalarQuadraticMode) (omega k : ℝ)
    (hkin : 0 < q.kinetic)
    (hK : scalarKernel q omega k = 0)
    (hnum : 0 ≤ q.gradient * k^2 + q.quartic * k^4 + q.mass) :
    0 ≤ omega^2 := by
  have h := dispersion_from_quadratic_kernel q omega k (ne_of_gt hkin) hK
  rw [h]
  exact div_nonneg hnum (le_of_lt hkin)

end QCALEFT

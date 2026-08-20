import Mathlib.Data.Real.Basic
import Mathlib.Tactic

namespace QCALEFT

/-- Formal bridge, not a hidden derivation. The action-level calculation must
supply the kernel hypothesis before the candidate dispersion becomes physical. -/
structure QuadraticKernel where
  alpha : ℝ
  beta : ℝ
  gamma : ℝ

def modeKernel (K : QuadraticKernel) (omega k : ℝ) : ℝ :=
  omega^2 - (K.alpha * k^2 + K.beta * k^4 + K.gamma)

/-- Lean certifies the algebraic extraction of omega² from a quadratic kernel. -/
theorem dispersion_of_kernel_zero
    (K : QuadraticKernel) (omega k : ℝ)
    (hkernel : modeKernel K omega k = 0) :
    omega^2 = K.alpha * k^2 + K.beta * k^4 + K.gamma := by
  unfold modeKernel at hkernel
  linarith

/-- Candidate SI-normalized QCAL coefficients. This remains a candidate until
it is derived from the actual action and field normalization. -/
def qcalCandidateKernel (cs2 hbar m a G rho : ℝ) : QuadraticKernel :=
  { alpha := cs2 / a^2
    beta := hbar^2 / (4 * m^2 * a^4)
    gamma := -(4 * Real.pi * G * rho) }

/-- Pure algebraic substitution into the candidate kernel. Not an action-level
physics theorem. -/
theorem qcal_candidate_dispersion
    (cs2 hbar m a G rho omega k : ℝ)
    (hm : m ≠ 0) (ha : a ≠ 0)
    (hkernel : modeKernel (qcalCandidateKernel cs2 hbar m a G rho) omega k = 0) :
    omega^2 = cs2 * k^2 / a^2
        + hbar^2 * k^4 / (4 * m^2 * a^4)
        - 4 * Real.pi * G * rho := by
  unfold qcalCandidateKernel at hkernel
  unfold modeKernel at hkernel
  field_simp [hm, ha] at hkernel
  nlinarith [hkernel]

end QCALEFT

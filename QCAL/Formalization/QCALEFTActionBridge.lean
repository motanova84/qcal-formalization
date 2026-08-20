import Mathlib.Data.Real.Basic
import Mathlib.Tactic

namespace QCALEFT

/-- Exact action-level symbols transcribed from QCAL-EFT Eq. (5.1).

The source document writes
  S = ∫ √(-g) [ -g^(μν) ∂μ Ψ* ∂ν Ψ - U(|Ψ|²)
                - ζ R |Ψ|² - (c₂/2) A_eff² |Ψ|² ].

This structure records the scalar coefficients only. It is NOT a replacement
for the tensor-calculus derivation of the Euler-Lagrange equations. -/
structure ActionParams where
  zeta : ℝ
  c2 : ℝ
  aeff2 : ℝ

/-- Scalar potential sector appearing in Eq. (5.1), with the curvature and
vector-background terms kept explicit. -/
def effectivePotential (p : ActionParams) (psiNormSq U R : ℝ) : ℝ :=
  U + p.zeta * R * psiNormSq + (p.c2 / 2) * p.aeff2 * psiNormSq

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

/-- The source document's curvature-of-potential identity (Eq. 8.3) implies
its stated cancellation in c_s² (Eq. 8.4), once Eq. 6.4 is taken as a premise.
This theorem deliberately exposes the premise rather than hiding it in a
constructed definition. -/
theorem source_sound_speed_cancellation
    (rho0 m_eff omega0 c2 Aeff zeta R0 d2U : ℝ)
    (hm : m_eff ≠ 0)
    (hd2U : d2U = omega0^2 - (c2 / 2) * Aeff^2 + zeta * R0) :
    (rho0 / m_eff) *
      (d2U + (c2 / 2) * Aeff^2 - zeta * R0)
      = (rho0 / m_eff) * omega0^2 := by
  rw [hd2U]
  ring

end QCALEFT

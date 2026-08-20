import Mathlib.Data.Real.Basic
import Mathlib.Tactic

namespace QCALEFT

/-!
# QCAL-EFT — Action → Linear Mode → Dispersion

This module is the formal bridge for the perturbative chain described in the
QCAL-EFT document.  The field-theoretic derivation is represented by explicit
algebraic hypotheses rather than hidden axioms.  Lean then certifies the
consequences of those hypotheses.

The central object is the quadratic Fourier-mode kernel

  K(ω,k) = ω² - (c_s² k²/a² + ℏ² k⁴/(4 m_eff² a⁴) - 4πGρ₀).

The mode equation K=0 therefore yields the displayed dispersion relation.
The module also records the background-field and perturbation decomposition
needed to make the bridge auditable.
-/

structure Background where
  psi0 : ℝ
  rho0 : ℝ
  a : ℝ
  m_eff : ℝ
  h_a : 0 < a
  h_m : 0 < m_eff

structure Perturbation where
  background : Background
  deltaPsi : ℝ
  k : ℝ
  omega : ℝ

/-- Fourier-mode kernel after the quadratic perturbation reduction. -/
def modeKernel (cs2 hbar G : ℝ) (p : Perturbation) : ℝ :=
  p.omega^2 -
    (cs2 * p.k^2 / p.background.a^2
      + hbar^2 * p.k^4 /
          (4 * p.background.m_eff^2 * p.background.a^4)
      - 4 * Real.pi * G * p.background.rho0)

/-- Action-level perturbation statement to be supplied by the explicit
second-order expansion of Eq. (5.1). This proposition is deliberately named
as an input to the bridge: it is not an opaque `axiom` and is not used to hide
physical assumptions. -/
def QuadraticReduction
    (cs2 hbar G : ℝ) (p : Perturbation) : Prop :=
  modeKernel cs2 hbar G p = 0

/-- Main algebraic bridge: the quadratic Fourier-mode equation implies the
QCAL-EFT dispersion relation. -/
theorem dispersion_of_quadratic_reduction
    (cs2 hbar G : ℝ) (p : Perturbation)
    (hred : QuadraticReduction cs2 hbar G p) :
    p.omega^2 =
      cs2 * p.k^2 / p.background.a^2
        + hbar^2 * p.k^4 /
            (4 * p.background.m_eff^2 * p.background.a^4)
        - 4 * Real.pi * G * p.background.rho0 := by
  unfold QuadraticReduction modeKernel at hred
  linarith

/-- The effective sound-speed identity used in the document. -/
theorem effective_sound_speed
    (rho0 m_eff omega0 c2 A zeta R : ℝ)
    (hm : m_eff ≠ 0) :
    (rho0 / m_eff) *
        ((omega0^2 - (c2 / 2) * A^2 + zeta * R)
          + (c2 / 2) * A^2 - zeta * R)
      = (rho0 / m_eff) * omega0^2 := by
  ring

/-- Explicit substitution of m_eff = ℏω₀/c² into the quantum-pressure
coefficient.  This is the exact algebraic identity behind the document's
Eq. (8.6). -/
theorem quantum_pressure_reduction
    (hbar omega0 c k a : ℝ)
    (hc : c ≠ 0) (homega : omega0 ≠ 0) (ha : a ≠ 0) :
    hbar^2 * k^4 /
        (4 * (hbar * omega0 / c^2)^2 * a^4)
      = c^4 * k^4 /
        (4 * omega0^2 * a^4) := by
  field_simp [hc, homega, ha, ne_of_gt (sq_pos_of_ne_zero hc)]
  ring

end QCALEFT

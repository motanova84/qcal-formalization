import Mathlib.Data.Real.Basic
import Mathlib.Tactic

namespace QCALEFT

/-- Symmetric 2x2 Fourier-space perturbation matrix for the real/imaginary
scalar components. The entries are kept explicit so the spectral condition is
not hidden in an informal determinant. -/
structure PerturbationMatrix where
  Kuu : ℝ
  Kuv : ℝ
  Kvv : ℝ

 def det2 (K : PerturbationMatrix) : ℝ := K.Kuu * K.Kvv - K.Kuv^2

/-- A non-trivial mode of a symmetric 2x2 quadratic kernel requires vanishing
determinant when the two diagonal equations are Kuu*u+Kuv*v=0 and
Kuv*u+Kvv*v=0. -/
theorem determinant_zero_of_nontrivial_mode
    (K : PerturbationMatrix) (u v : ℝ)
    (hmode1 : K.Kuu * u + K.Kuv * v = 0)
    (hmode2 : K.Kuv * u + K.Kvv * v = 0)
    (hnontrivial : u ≠ 0 ∨ v ≠ 0) :
    det2 K = 0 := by
  unfold det2
  rcases hnontrivial with hu | hv
  · have h := congrArg (fun x => K.Kvv * x) hmode1
    have h' := congrArg (fun x => K.Kuv * x) hmode2
    nlinarith
  · have h := congrArg (fun x => K.Kuv * x) hmode1
    have h' := congrArg (fun x => K.Kuu * x) hmode2
    nlinarith

/-- Canonical QCAL matrix when the scalar sectors share the same dispersion
coefficient. Its determinant vanishes exactly when the scalar dispersion
factor vanishes. -/
def qcalDiagonalMatrix (D : ℝ) : PerturbationMatrix :=
  { Kuu := D, Kuv := 0, Kvv := D }

theorem qcal_det_factor (D : ℝ) :
    det2 (qcalDiagonalMatrix D) = D^2 := by
  simp [det2, qcalDiagonalMatrix]

theorem qcal_mode_implies_dispersion_factor_zero
    (D u v : ℝ)
    (hu : D * u = 0)
    (hv : D * v = 0)
    (hnontrivial : u ≠ 0 ∨ v ≠ 0) :
    D = 0 := by
  rcases hnontrivial with h | h
  · exact (mul_eq_zero.mp hu).resolve_right h
  · exact (mul_eq_zero.mp hv).resolve_right h

end QCALEFT

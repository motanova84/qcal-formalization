import QCAL.NoesisV10.S07_TraceFormula
import QCAL.NoesisV10.S12_RaySingerDeterminant

noncomputable section

namespace QCALRH.NoesisV10.Closure

open QCALRH.NoesisV10.S07
open QCALRH.NoesisV10.S12

/-!
# S07 → S12 closure boundary

This theorem is intentionally conditional on the two analytic certificates.
It proves the exact consequences that follow from them and makes the
remaining proof boundary machine-readable.
-/

structure ClosureCertificate where
  S : SpectralData
  Xi : ℂ → ℂ
  zeros : ZeroCertificate S Xi
  factorization : FactorizationCertificate
  xi_agrees : factorization.Xi = Xi
  normalization : NormalizationCertificate factorization

/-- The S07 certificate places every certified spectral zero on the critical
    line Re(s) = 1/2. -/
theorem spectral_zeros_on_critical_line (C : ClosureCertificate) :
    ∀ n : ℕ,
      IsZeroOfXi C.Xi (spectralZero C.S n) ∧
      (spectralZero C.S n).re = 1 / 2 := by
  intro n
  constructor
  · exact C.zeros.spectral_implies_zero n
  · exact spectralZero_realPart C.S n

/-- The normalized S12 certificate identifies the regularized determinant
    with the same completed zeta function used by S07. -/
theorem determinant_identifies_Xi (C : ClosureCertificate) :
    ∀ s : ℂ, detReg C.factorization.zetaData = C.Xi s := by
  intro s
  have h := detReg_eq_Xi C.factorization C.normalization s
  simpa [C.xi_agrees] using h

end QCALRH.NoesisV10.Closure

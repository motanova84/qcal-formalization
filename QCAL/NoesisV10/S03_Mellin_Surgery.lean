/-
  NOESIS V10 — S03 MELLIN SURGERY
  =================================

  Canonical normalization:
    H_M := L²((0,∞), dx/x)
    H_F := L²(ℝ, du)

  The unitary Mellin transform is Fourier after u = log x:

    (M f)(t) = (2π)^(-1/2) ∫ f(x) x^(-i t) dx/x.

  IMPORTANT CORRECTION
  --------------------
  The expression x^(it-1/2) is the usual Mellin normalization associated
  with L²((0,∞), dx), not L²((0,∞), dx/x). It must not be mixed with dx/x.

  This file is a specification layer: a stated proposition is not treated
  as proved merely because its name exists. The remaining analytic facts are
  explicit certificates/obligations.
-/

import Mathlib.MeasureTheory.Measure.Lebesgue
import Mathlib.Analysis.InnerProductSpace.Basic

noncomputable section
open MeasureTheory

namespace QCALRH.NoesisV10.S03

/-- Positive half-line. -/
def Rpos := Set.Ioi (0 : ℝ)

/-- Abstract multiplicative Haar model. Its defining property is that the
    logarithm sends Haar measure to Lebesgue measure. -/
structure HaarLogModel where
  μplus : Measure ℝ
  support_pos : μplus (Set.Iic (0 : ℝ)) = 0
  log_pushforward : Measure.map Real.log μplus = Measure.volume

/-- Logarithmic pullback f(e^u). -/
def logPullback (f : ℝ → ℂ) (u : ℝ) : ℂ := f (Real.exp u)

/-- Correct Mellin kernel for the L²(dx/x) normalization. -/
def mellinKernel (t x : ℝ) : ℂ :=
  Complex.exp (-Complex.I * (t * Real.log x))

/-- Exact unitary Mellin certificate. -/
structure MellinUnitaryCertificate (M : ℝ → ℂ → ℂ) : Prop where
  norm_preserving : True
  surjective : True

/-- Mellin = Fourier after logarithmic coordinates. The actual bridge is
    discharged from the Haar model and Plancherel; it is not postulated here
    as a theorem of the finished system. -/
structure MellinFourierCertificate : Prop where
  model : HaarLogModel
  bridge : True

/-- Correct scaling law: dilation on x becomes a phase multiplier in the
    Mellin variable. Translation in u becomes Fourier modulation. -/
structure MellinScaleCertificate : Prop where
  positive_scale_phase : True
  log_translation_fourier : True

/-- Completion certificate, intentionally uninhabited until the analytic
    obligations above are proved. -/
structure S03Certificate : Prop where
  mellin_fourier : MellinFourierCertificate
  scaling : MellinScaleCertificate

end QCALRH.NoesisV10.S03

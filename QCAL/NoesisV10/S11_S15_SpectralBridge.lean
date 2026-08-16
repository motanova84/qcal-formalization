import Mathlib

namespace QCALRH.NoesisV10

structure S11TotalOperator where
  H : Type*
  Dpi : H → H
  selfAdjoint : Prop

structure S12TraceFormula where
  testFunction : Type*
  traceIdentity : Prop
  admissibility : Prop

structure S13RegularizedDeterminant where
  determinant : ℂ → ℂ
  convergence : Prop
  xiIdentity : Prop

structure S14SpectralCorrespondence where
  spectralInclusion : Prop
  zeroSurjectivity : Prop
  nontrivialZeros : Prop

structure S15Multiplicity where
  spectralMultiplicity : ℂ → ℕ
  xiMultiplicity : ℂ → ℕ
  equality : ∀ z, spectralMultiplicity z = xiMultiplicity z

end QCALRH.NoesisV10

import Mathlib

namespace QCALRH.NoesisV10

structure S07Potential where
  W : ℝ → ℝ
  measurable : Prop
  real : Prop
  canonicalFromAdelicData : Prop

structure S08Growth where
  W : ℝ → ℝ
  tendsToInfinity : Prop
  lowerBound : Prop
  asymptotic : Prop

structure S09QuadraticForm where
  H : Type*
  q : H → ℝ
  closed : Prop
  semibounded : Prop
  coercive : Prop

structure S10Compactness where
  H : Type*
  formDomain : Type*
  embeddingCompact : Prop
  resolventCompact : Prop

end QCALRH.NoesisV10

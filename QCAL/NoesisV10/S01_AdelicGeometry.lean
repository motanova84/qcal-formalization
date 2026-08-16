import Mathlib

namespace QCALRH.NoesisV10.S01

/-! S01: exact adelic geometry and quotient measure.

The concrete implementation is intentionally left as an obligation. In
particular, no global product decomposition of the idele class group is
asserted here without proof.
-/

structure AdelicGeometry where
  X : Type*
  group : Group X
  topology : TopologicalSpace X
  topologicalGroup : TopologicalGroup X
  haar : Measure X
  norm : X → ℝ
  norm_measurable : Measurable norm
  quotient_correct : Prop
  haar_correct : Prop

end QCALRH.NoesisV10.S01

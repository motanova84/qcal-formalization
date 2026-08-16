import Mathlib

namespace QCALRH.NoesisV10

structure S04Hecke where
  H : Type*
  T : ℕ → ℕ → H → H
  bounded : Prop
  adjoint_relation : Prop

structure S05Varith where
  H : Type*
  V : H → H
  coefficient_convergence : Prop
  operator_convergence : Prop
  selfAdjoint : Prop

structure S06Regularization where
  kernel : ℝ → ℝ → ℂ
  squareIntegrable : Prop
  compactOperator : Prop
  determinantClass : Prop

end QCALRH.NoesisV10

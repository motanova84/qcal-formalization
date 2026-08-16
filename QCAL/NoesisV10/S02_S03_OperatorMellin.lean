import Mathlib

namespace QCALRH.NoesisV10

structure S02Operator where
  H : Type*
  normed : NormedAddCommGroup H
  D : H → H
  domain : Set H
  dense : Prop
  symmetric : Prop
  essentialSelfAdjoint : Prop

structure S03Mellin where
  H K : Type*
  transform : H → K
  unitary : Prop
  dilationIntertwining : Prop

end QCALRH.NoesisV10

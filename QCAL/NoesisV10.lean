import QCAL.NoesisV10.Obligations

/-!
# NOĒSIS V10 module root

This namespace is the canonical entry point for the V10 closure program.
-/
namespace QCALRH.NoesisV10

inductive Status
  | defined
  | formalized
  | proved
  | obligation
  | blocked
  deriving Repr, DecidableEq

structure Obligation where
  id : String
  statement : String
  dependency : List String
  status : Status

end QCALRH.NoesisV10

namespace QCAL
namespace Formalization
namespace Audit

/-- Status vocabulary deliberately separates proof from numerical evidence. -/
inductive ClaimStatus
  | conjectured
  | computationallySupported
  | conditional
  | formallyVerified
  | refuted
  | open
  deriving DecidableEq, Repr

structure Claim where
  name : String
  statement : String
  status : ClaimStatus

end Audit
end Formalization
end QCAL

import QCAL.Formalization.Audit.Status

namespace QCAL
namespace Formalization
namespace Audit

/-- Current audit register. No gap theorem is marked as proven here. -/
def psiIndependentOfSAT : Claim :=
  { name := "psi-independent-of-sat"
    statement := "Psi_n has no Formula3SAT or solution-set argument in its definition."
    status := .formallyVerified }

def psiPolynomialGap : Claim :=
  { name := "polynomial-gap"
    statement := "Delta_n >= 1 / poly(n) for the filtered Hamiltonian."
    status := .open }

def solutionOverlap : Claim :=
  { name := "solution-overlap"
    statement := "The ground state has inverse-polynomial overlap with the solution subspace."
    status := .open }

def classicalPTimeClosure : Claim :=
  { name := "classical-p-time-closure"
    statement := "The spectral chain alone establishes 3-SAT in classical P."
    status := .open }

end Audit
end Formalization
end QCAL

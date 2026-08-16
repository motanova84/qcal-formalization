# NOĒSIS V10 — S05 status: `V_arith`

## Decision

S04 establishes the local Hecke bound

\[
\|T_{m\log p}\|_{op}\le 1.
\]

That fact **does not** by itself imply convergence of

\[
\sum_{p,m\ge1} a_{p,m}T_{m\log p}.
\]

In particular, the naive absolute majorant with
\(a_{p,m}=\log(p)/p^{m/2}\) is not summable at the `m=1` layer.  Therefore
S05 must not be closed by citing completeness of `B(H)` alone.

## Canonical regularized construction

For `β > 0` define

\[
 a^{(β)}_{p,m}
 = \frac{\log p}{p^{m/2}}
   \exp[-β(m\log p)^2],
 \qquad p\text{ prime},\;m\ge1.
\]

The Lean specification is in
`QCAL/NoesisV10/S05_Varith_Regularization.lean`.

The index convention `m ≥ 1` is explicit.  The `m=0` term is excluded because
it is not a prime-power von-Mangoldt contribution and would make the scalar
majorant divergent.

## What is now formally anchored

1. Explicit coefficient `rawCoeff`.
2. Explicit Gaussian regularization `regCoeff`.
3. Explicit prime-power index set.
4. Rectangular finite operator approximants.
5. Self-adjointness of every finite approximant.
6. Operator-norm majorization by the scalar coefficient.
7. A named `ScalarSummability` obligation.
8. A named `S05NormConvergence` obligation.
9. A bridge theorem whose only remaining content is the actual Weierstrass/M-test
   proof plus the scalar number-theoretic estimate.

## What is NOT claimed

S05 is **not yet closed**.  The following remain genuine obligations:

- prove `ScalarSummability β` for every chosen `β > 0` (or for an explicitly
  specified admissible range);
- instantiate the Banach-space M-test in Lean;
- prove that the norm limit is self-adjoint;
- determine whether this regularization is merely an auxiliary analytic device
  or the canonical regularization required by the intended spectral identity.

This distinction is essential.  A convergent regularization is not automatically
identical to the desired unregularized arithmetic potential.

## Source inventory

The existing `qcal-formalization` repository already contains operator/Fredholm
infrastructure in `QCAL/OperatorTheory/SchattenClass.lean`.  `LOGOSNOESIS` also
contains Riemann/kernel/compactness material.  Those modules are source material
for the next bridges, not automatic certificates for the V10 construction.

## Status

`S04`: locally closed specification.

`S05`: **FORMALIZED AS AN EXPLICIT OBLIGATION — NOT YET PROVED**.

Next target: discharge scalar summability and the operator M-test without adding
axioms.

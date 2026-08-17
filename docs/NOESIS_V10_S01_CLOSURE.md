# NOĒSIS V10 — S01 Closure Ledger

## Objective

Close the norm-one adelic class group construction without treating interfaces or `sorry` as proofs.

Target structure:

\[
I_{\mathbb Q}=\mathbb A_{\mathbb Q}^{\times},\qquad
I_{\mathbb Q}^{1}=\ker(\nu),\qquad
C_{\mathbb Q}^{1}=I_{\mathbb Q}^{1}/\Delta(\mathbb Q^{\times}).
\]

## Dependency order

1. Confirm the exact `AdeleRing ℚ`, `Units`, diagonal and Haar APIs with `S01/ApiProbe.lean`.
2. Instantiate the global norm homomorphism using only confirmed Mathlib primitives.
3. Prove the rational product formula.
4. Establish `Δ(ℚˣ) ≤ I¹`.
5. Define the quotient group using the subgroup actually induced by the diagonal.
6. Prove the diagonal subgroup is closed.
7. Prove compactness of the quotient; do **not** assert compactness of `I¹` itself.
8. Instantiate normalized Haar measure on the compact quotient.
9. Run `#print axioms` on every sealed theorem and reject any `sorryAx` dependency.

## Mathematical invariant

For every `q : ℚˣ`:

\[
|q|_\infty\prod_p |q|_p=1.
\]

The proof is to be reduced to finite prime support and the standard rational valuation/factorization lemmas available in the selected Mathlib version.

## Explicit non-goals

- No claim that the Riemann Hypothesis is proved by S01.
- No use of `f₀ = 141.7001 Hz` as a premise of the adelic theorems.
- No invented theorem names.
- No `IdeleRepr` wrapper merely to bypass the actual `AdeleRing` representation.
- No compactness claim for `I¹` unless separately established and mathematically correct.

## QCAL integration

The QCAL/NOĒSIS layer records the canonical reference frequency
`f₀ = 141.7001 Hz` as an architectural/experimental metadata value. It is deliberately absent from the premises of S01.

## Closure gate

S01 is sealed only when the implementation compiles with zero `sorry` in the S01 dependency chain and the resulting theorems pass the axiom audit.

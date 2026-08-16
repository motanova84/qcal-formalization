# NOĒSIS V10 — Construction Status

**Branch:** `noesis/s10-compactness-anchor`

## Current state

The V10 architecture is anchored in the repository as a separate, auditable layer. Existing QCAL formalizations are preserved. The new layer does not overwrite earlier certification artifacts.

### Build order

```text
S01 geometry/measure
  ↓
S02 operator/domain
  ↓
S03 Mellin
  ↓
S04 Hecke shifts
  ↓
S05 V_arith
  ↓
S06 regularization
  ↓
S07 W definition
  ↓
S08 W growth
  ↓
S09 quadratic form
  ↓
S10 compactness        ← CURRENT
  ↓
S11 self-adjoint total operator
  ↓
S12 trace formula
  ↓
S13 determinant
  ↓
S14 spectrum ↔ zeros
  ↓
S15 multiplicities
  ↓
RH
```

## Mathematical discipline

The repository contains historical documents that describe completed/certified results. The V10 ledger is stricter: executable Lean code, a mathematical proof, and a prose specification are three different states.

A theorem containing `sorry`, an interface structure, or a prose claim is **not** counted as a proved theorem in the V10 ledger.

## S10 status

**Specification: ANCHORED**

`QCAL/NoesisV10/S10_Compactness_Spec.md` records the complete proof contract:

`weighted form domain → uniform tail control → local Rellich → diagonal subsequence → global L² compactness → compact resolvent → discrete spectrum.`

`QCAL/NoesisV10/S10_Compactness.lean` contains only the checked interface definitions. It intentionally does not introduce `sorry` or `axiom` to manufacture a completed theorem.

**Lean proof status: PENDING** until the exact Mathlib implementation of the H¹ restriction, local Rellich theorem, diagonal extraction and form-to-resolvent implication compiles without placeholders.

## First closure targets

1. S01: exact quotient model and Haar measure used by the analytic construction.
2. S02/S03: operator domain and Mellin normalization.
3. S04: shift operators and adjoint relations.
4. S05/S06: legitimate operator construction for the regularized arithmetic term.
5. S07/S08/S09: confinement, growth and closed quadratic form.
6. S10: compactness of the form-domain embedding.

## Gate before any RH certification

S11–S15 must be independently closed. In particular, self-adjointness plus a discrete real spectrum is insufficient by itself; the exact equality between that spectrum and the nontrivial zeros of ξ, including multiplicities, is the decisive bridge.

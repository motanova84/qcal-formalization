# NOĒSIS V10 — Construction Status

**Canonical repository:** `motanova84/qcal-formalization`

**Working branch:** `noesis/s10-compactness-anchor`

## Current state

The V10 architecture is consolidated in this repository as one auditable construction layer. Historical QCAL material remains preserved, but the S01–S15 route is not to be dispersed across repositories.

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
S10 compact embedding / compact resolvent
  ↓
S11 self-adjoint total operator + spectral basis
  ↓
S12 eigenvalue counting asymptotic
  ↓
S13 trace / determinant mechanism
  ↓
S14 spectrum ↔ ξ zeros
  ↓
S15 multiplicities
  ↓
RH gate
```

## Mathematical discipline

The ledger distinguishes three states:

1. executable Lean code;
2. mathematically proved result;
3. prose/specification contract.

A theorem containing `sorry`, an interface structure, or a prose claim is **not** counted as a Lean-proved theorem.

## S10

**Specification: ANCHORED. Lean closure: PENDING.**

`QCAL/NoesisV10/S10_Compactness_Spec.md` records the proof contract:

`weighted form domain → uniform tail control → local Rellich → diagonal extraction → global L² compactness → compact resolvent → discrete spectrum.`

## S11

**Mathematical construction: CONSOLIDATED. Lean closure: PENDING.**

`QCAL/NoesisV10/S11_OperatorBasis_Spec.md` fixes the correct form-to-operator route.

Critical correction: `H` is generally unbounded; it is the shifted resolvent `(H+c)⁻¹`, not `H`, that is compact. The complete orthonormal eigenbasis follows from the spectral theorem for self-adjoint operators with compact resolvent. The earlier claim `‖H‖ = sup |λₙ|` is rejected because `λₙ → ∞`.

## S12

**Asymptotic diagnosis: CONSOLIDATED. Exact semiclassical proof: PENDING.**

`QCAL/NoesisV10/S12_LogPotential_Asymptotic_Spec.md` establishes the required target calculation for

`W_α(u)=α log(1+u²)`:

`N_H(T) ~ sqrt(2α/π) exp(T/(2α))`.

The previously stated extra factor `√T` is explicitly rejected.

Therefore this confinement has exponentially growing state count, incompatible with the Riemann–von Mangoldt scale `N_ξ(T) ~ (T/(2π)) log(T/(2πe))`. No fixed `α>0` repairs that mismatch. S13–S15 must therefore not force an identification `λₙ=γₙ` for this potential.

## Closure targets

- S10: formalize compact embedding and compact resolvent with exact Mathlib APIs.
- S11: formalize the closed form, associated self-adjoint operator and compact-resolvent spectral basis.
- S12: formalize the semiclassical counting asymptotic under the exact hypotheses on `V_ε`.
- S13: construct the trace/determinant mechanism without fitting parameters to zeros.
- S14: prove, rather than assume, any spectral correspondence with `ξ`.
- S15: prove multiplicity preservation.

## RH gate

S10–S15 are independent gates. Self-adjointness, discreteness, numerical agreement, or a formal interface do **not** establish RH. The decisive bridge remains an exact theorem identifying the relevant spectrum with the nontrivial zeros of `ξ`, including multiplicities.

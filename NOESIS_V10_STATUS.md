# NOĒSIS V10 — Construction Status

**Canonical repository:** `motanova84/qcal-formalization`

**Working branch:** `noesis-v10-s12-consolidation`

## Current state

The V10 architecture remains concentrated in `QCAL/NoesisV10/`. No new parallel repository is being used for the spectral bridge. Existing QCAL formalizations and historical certification artifacts are preserved.

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
S10 compactness
  ↓
S11 self-adjoint total operator
  ↓
S12 spectral counting asymptotic  ← current frontier
  ↓
S13 trace formula
  ↓
S14 determinant / spectrum ↔ zeros
  ↓
S15 multiplicities
  ↓
RH
```

## S11 audit correction

S11 is to be understood through the spectral theorem for self-adjoint operators with compact resolvent. The phrase “Hilbert–Schmidt theorem” is not used as the justification. Since the confining Schrödinger operator is unbounded, no finite operator-norm identity `‖H‖ = sup |λ_n|` is asserted. The valid diagonal representation is on the operator domain with the usual graph/square-summability condition.

## S12 mathematical checkpoint

For

`W_α(u) = α log(1 + u²)`, `α > 0`,

one-dimensional semiclassical analysis gives, for the unperturbed operator,

`N₀(T) ~ sqrt(2α/π) exp(T/(2α))`.

For a bounded real perturbation `V`, min–max comparison preserves the exponential rate:

`lim_{T→∞} log N(T)/T = 1/(2α)`.

The exact prefactor is recorded only for `V = 0`; the logarithmic rate is the robust statement under bounded perturbations.

This creates a **structural obstruction**, not a failure of S10/S11: the Riemann–von Mangoldt counting law is

`N_ζ(T) ~ T/(2π) log(T/(2πe))`,

whose logarithmic rate divided by `T` tends to zero. Therefore no fixed `α > 0` in the logarithmic potential can produce the Riemann zero-counting law.

## Formalization discipline

A Lean interface, structure, or prose statement is not counted as a proved theorem. No `sorry` or hidden axiom is used to mark S12 complete. The present branch records the exact theorem obligations and the obstruction that must be resolved before S13–S15 can claim an arithmetic bridge.

## Gate before any RH certification

S12, S13, S14 and S15 must be independently closed. In particular, self-adjointness plus a discrete real spectrum is insufficient by itself; the decisive bridge is an independently proved identification with the nontrivial zeros of `ξ`, including multiplicities.

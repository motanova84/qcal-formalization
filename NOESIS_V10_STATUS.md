# NOĒSIS V10 — Construction Status

**Canonical repository:** `motanova84/qcal-formalization`  
**Working branch:** `noesis/canonical-audit-20260817`

## Canonical concentration

All formal spectral work for the S01–S15 route is concentrated in `QCAL/NoesisV10/` in this repository. Historical material in `Riemann-adelic`, `Tejido-Adelico-`, `Catedral-Mathesis` and `QCAL-BUS` is source/integration material, not a parallel proof target.

## Build order

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
S12 spectral counting / obstruction
  ↓
S13 non-circular trace formula
  ↓
S14 determinant / ξ correspondence
  ↓
S15 multiplicities + exact spectral identification
  ↓
RH
```

## Repository sweep result

The sweep found substantial prior material, but no independently compiled closure of S13–S15. In particular, prose claims in historical repositories do not substitute for a proof of:

1. an operator defined independently of the zeros;
2. a trace identity whose spectral side does not presuppose those zeros;
3. a normalized determinant identity with `ξ`;
4. equality of spectral and zero multiplicities.

The full audit is recorded in `NOESIS_CANONICAL_AUDIT_2026-08-17.md`.

## S11 audit correction

S11 is understood through the spectral theorem for self-adjoint operators with compact resolvent. “Hilbert–Schmidt theorem” is not used as the justification. Since the confining Schrödinger operator is unbounded, no finite operator-norm identity `‖H‖ = sup |λ_n|` is asserted. The valid diagonal representation is on the operator domain with the usual graph/square-summability condition.

## S12 checkpoint

For the auxiliary model

`W_α(u) = α log(1 + u²)`, `α > 0`,

one-dimensional semiclassical analysis gives the unperturbed leading law

`N₀(T) ~ sqrt(2α/π) exp(T/(2α))`.

For bounded real perturbations, the robust invariant is

`lim_{T→∞} log N(T)/T = 1/(2α)`.

The Riemann–von Mangoldt scale satisfies

`N_ζ(T) ~ T/(2π) log(T/(2πe))`,

hence `log N_ζ(T)/T → 0`. The fixed logarithmic confinement therefore cannot be the final Hilbert–Pólya model.

`QCAL/NoesisV10/S12_RateObstruction.lean` now formalizes the logical incompatibility of two distinct asymptotic rates once the analytic limit statements are supplied.

## Formalization discipline

A Lean interface, structure, comment, documentation claim, or removed `sorry` counter is not counted as a proved theorem. S12 remains an analytic obligation plus a formally proved incompatibility lemma; it is not a proof of the Riemann asymptotic itself.

## Gate before RH certification

S13, S14 and S15 remain open. The decisive next task is **not** to restate the explicit formula, but to construct an independent adèlic operator/representation for which a genuine trace identity can be proved and then connected to `ξ` without defining the spectrum from its zeros.

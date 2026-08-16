# NOĒSIS V10 — Formal Specification

## Purpose

This document is the canonical construction map for the V10 analytic program. It separates definitions, proved results, assumptions/obligations, and the final spectral bridge. A Lean `sorry` is treated as an explicit proof obligation, not as a completed theorem.

## Status vocabulary

- **DEFINED** — the object has a precise mathematical definition.
- **FORMALIZED** — represented in Lean with its intended types/interfaces.
- **PROVED** — Lean or a cited mathematical theorem closes the obligation without `sorry`.
- **OBLIGATION** — a statement exists, but its proof is still open.
- **BLOCKED** — a dependency or mathematical definition is not yet justified.

## Canonical chain

S01 Adelic geometry/measure → S02 dilation operator/domain → S03 Mellin representation → S04 Hecke shifts → S05 arithmetic perturbation → S06 kernel regularization → S07 canonical confinement potential → S08 growth → S09 quadratic-form coercivity → S10 compact embedding → S11 self-adjoint total operator → S12 trace formula → S13 regularized determinant → S14 spectral correspondence → S15 multiplicities → RH consequence.

## Critical correction

The earlier claim `A_Q^× / Q^× ≃ R_+ × Z_hat^×` is **not frozen as a global theorem**. V10 uses the idele class group and local/global harmonic decompositions only after the required quotient and measure maps are explicitly constructed. Likewise, `W(t)` is not considered established merely because an asymptotic was written down: its definition, positivity/coercivity, and asymptotic must each be independently proved.

## S01–S15 inventory

| ID | Obligation | Status | Dependency |
|---|---|---|---|
| S01 | Ideles, quotient, Haar measure | FORMALIZED/OPEN | none |
| S02 | Dilation operator and self-adjoint domain | FORMALIZED/OPEN | S01 |
| S03 | Unitary Mellin representation | FORMALIZED/OPEN | S02 |
| S04 | Symmetric Hecke shifts | FORMALIZED/OPEN | S03 |
| S05 | Convergence/self-adjointness of V_arith | OBLIGATION | S04 |
| S06 | Legitimate regularization and Schatten control | OBLIGATION | S05 |
| S07 | Canonical definition of W | OBLIGATION | S01,S03 |
| S08 | W growth/positivity | OBLIGATION | S07 |
| S09 | Closed quadratic form and coercivity | OBLIGATION | S05,S08 |
| S10 | Compact form-domain embedding | OBLIGATION | S09 |
| S11 | Self-adjoint total operator | DERIVABLE | S02,S05,S09 |
| S12 | Weil/explicit trace identity | OBLIGATION | S11 |
| S13 | Regularized determinant | OBLIGATION | S06,S12 |
| S14 | Zero-spectrum correspondence | OBLIGATION | S12,S13 |
| S15 | Multiplicity preservation | OBLIGATION | S14 |

## Non-negotiable final gate

The RH conclusion is only admitted after S14 and S15 are proved. A self-adjoint operator alone does not prove RH; the missing content is the exact identification of its spectrum with the nontrivial zeros, including multiplicities.

## Repository policy

Every new theorem must identify its dependency ID. Every unresolved `sorry` must be mirrored in `docs/NOESIS_V10_OBLIGATIONS.md`. No certification document may call the complete RH proof established while S12–S15 remain open.
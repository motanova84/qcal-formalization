# QCAL H-Ω formalization protocol

## Objective

Build an auditable bridge from a non-circular operator Ψ_n to spectral statements about a 3-SAT Hamiltonian. Numerical evidence, Lean proofs, and cryptographic audit records are separate layers.

## Non-circularity rule

Ψ_n may depend on n and fixed QCAL parameters, but must not depend on a Formula3SAT instance, its satisfying assignments, or any oracle derived from them.

## Evidence levels

- `formallyVerified`: proved by Lean from imported definitions and lemmas.
- `computationallySupported`: reproduced by deterministic numerical code/tests, but not a Lean theorem.
- `conditional`: follows only after explicitly named hypotheses.
- `open`: not established.
- `refuted`: contradicted by a verified counterexample.

## Required chain

1. Define the Hilbert-space index and Ψ_n.
2. Prove algebraic properties of Ψ_n.
3. Define 3-SAT and its Hamiltonian independently of Ψ_n.
4. Define the filtered Hamiltonian H_QA^Ψ.
5. Define the spectral gap without circular access to solutions.
6. Generate reproducible numerical spectra for controlled instance families.
7. Test overlap and witness extraction separately.
8. Run ablations: Ψ removed, θ=0, shifted f0.
9. Formalize only claims for which Lean has a complete proof.
10. Hash the exact artifacts only after the content is frozen.

## Current status

The repository now contains the non-circular operator API, a finite 3-SAT data model, a spectral-gap interface, Python reference tests, and an audit status register. The genuine low-frequency spectral projector, polynomial gap theorem, overlap theorem, and complexity closure remain open and must not be represented as proven.

## Acceptance criteria

A claim can be promoted to `formallyVerified` only when `lake build` checks the complete proof without `sorry`, `axiom` placeholders, or untracked external assumptions. Numerical experiments are reported separately and never converted into theorems by convention.

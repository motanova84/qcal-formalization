# QCAL Ω Audit Ledger

This repository is the formal-evidence anchor for the QCAL audit graph.

## Evidence policy

- `PROVEN`: complete mathematical proof whose formal dependencies are closed.
- `FORMALIZED`: encoded in Lean, but not yet accepted as a complete proof by the audit gate.
- `VERIFIED`: reproducible computational result with executable code/tests.
- `PREDICTED`: preregistered empirical prediction awaiting measurement.
- `OPEN`: unresolved claim or model input.
- `FALSIFIED`: contradicted by the specified evidence protocol.

The inheritance invariant is checked automatically:

`rank(status(claim)) <= min(rank(status(dependency)))`.

`AXIOM_*` identifiers are root assumptions, not evidence-bearing claims. They are deliberately outside the inheritance lattice so CI never turns an axiom into a proof.

## Current critical frontier

`M_002` (`f_bare = 134.425 Hz`) is `OPEN`; consequently `M_003` and `M_004` are also `OPEN`. This is intentional. The ledger does not allow a downstream numerical target to acquire stronger evidence than its weakest unresolved model input.

The RH branch remains `FORMALIZED` until the self-adjointness and spectral-identification obligations are actually closed by Lean and the associated analytic assumptions are explicit.

## CI

Run locally:

```bash
python3 scripts/validate_omega_ledger.py ledger/omega.json
lake build
```

GitHub Actions runs both gates on every relevant push and pull request.

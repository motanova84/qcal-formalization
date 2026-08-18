# QCAL Ω Audit Ledger v1.1

This release anchors the Ω ledger as an executable audit artifact.

## Evidence rule

The project may record a reported claim, but CI only accepts the status actually present in `ledger/omega.json`. A claim is not promoted to `PROVEN` or `VERIFIED` by a declaration, hash label, README statement, or previous conversation. Promotion requires machine-checkable evidence and a passing CI run.

The inheritance rule is:

`status(child) <= min(status(parent))`

The current ledger deliberately preserves unresolved dependencies (notably the biological input behind `f_bare`, the spectral bridge, and experimental predictions) instead of converting them into an artificial all-green state.

## Scope

- `ledger/omega.json`: canonical evidence graph.
- `scripts/validate_omega_ledger.py`: schema, status, dependency and cycle gate.
- `.github/workflows/qcal-omega-audit.yml`: automatic CI gate plus Lean build.

The supplied `sha256:qcal-omega-v1.1-ALL-GREEN-20260818` is retained as a **reported seal**, not asserted as a cryptographic digest of this file.

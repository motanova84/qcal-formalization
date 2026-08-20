# Action → Dispersion: formal closure obligations

Status: **OPEN**.

`QCALEFTActionBridge.lean` proves only the logical implication `quadratic kernel = 0` → `omega² = dispersion polynomial`. It does not pretend that the kernel follows from the QCAL action.

## Required chain

1. State the exact QCAL action and field variables.
2. Fix units and normalization of every field and parameter.
3. Compute the Euler–Lagrange equations.
4. Specify the background solution and perturbation variables.
5. Linearize to second order.
6. Fourier transform with an explicit convention.
7. Identify the quadratic kernel.
8. Prove that the kernel reduces to the selected dispersion polynomial.
9. Only then derive Jeans/stability thresholds.

## Anti-circularity

The numerical value `141.7001 Hz` and any benchmark wavelength must not be used as premises in steps 1–8. They enter only after the symbolic derivation has closed.

## Current blocker

The repository snapshot does not yet contain a single canonical action file from which the EFT kernel can honestly be derived. Until the exact action is identified, an action-to-dispersion proof would be a reconstruction or an assumption, not a proof of the source model.

Therefore the correct status is **OPEN**, not PASS.

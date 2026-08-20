# QCAL-EFT — Rigor Audit

**Branch:** `audit/qcal-eft-rigor-20260820`

This audit prevents a numerical or algebraic claim from being called a proof merely because a desired value was inserted as an input.

## Evidence classes

- **DEFINITION** — fixed by definition.
- **ALGEBRAIC THEOREM** — follows from displayed equations and explicit hypotheses.
- **NUMERICAL CONSEQUENCE** — independently computed from displayed equations and declared SI constants.
- **EMPIRICAL INPUT** — imported from an external dataset or benchmark.
- **OPEN / BLOCKED** — not yet reconciled by an executable test.

Lean proves the algebraic class. Python independently evaluates the numerical class. Neither is allowed to silently promote an empirical input into a theorem.

## Formal anchors

The manuscript fixes

\[
f_0=141.7001\;\mathrm{Hz},\qquad \omega_0=2\pi f_0,
\]

and defines

\[
m_{\rm eff}=\frac{\hbar\omega_0}{c^2}.
\]

The Lean module `QCAL/Formalization/QCALEFTStabilityAudit.lean` proves the displayed sound-speed cancellation and positivity of the displayed dispersion relation under an explicit sufficient condition. These proofs do **not** claim that the underlying physical hypotheses follow from the action.

## Dimensional gate

`scripts/qcal_eft_dimensional_audit.py` performs exact SI base-dimension algebra using `(M,L,T)` exponents.

It verifies, among other relations,

\[
[c_s^2 k^2]=T^{-2},\qquad [G\rho]=T^{-2},\qquad [m_{\rm eff}]=M.
\]

It deliberately blocks the literal quantum-pressure term

\[
\frac{k^4}{m_{\rm eff}^2}
\]

because in SI dimensions as written it is **not** a frequency-squared quantity. The missing normalization/factors must be specified explicitly before this term can be accepted as part of an SI dispersion relation.

## Numerical closure gates

`scripts/qcal_eft_audit.py` transcribes the manuscript's Section 26 frequency and Jeans equations literally and checks the fixed spectral anchor, `m_eff`, the Section 26 frequency formula, its stated tolerance, and the Section 26 Jeans wavelength benchmark.

The final gate exits non-zero if a registered numerical claim fails. A failure is evidence to investigate, never a warning to ignore.

## Current scientific blockers

1. **Jeans closure:** the literal evaluation of Eq. (26.3), using the constants and parameters specified in the manuscript, does not reproduce the stated Eq. (26.4) wavelength.
2. **Dispersion dimensions:** the displayed `k⁴/m_eff²` quantum term is dimensionally incomplete in SI unless additional normalization/factors are specified.

Before numerical closure, reconcile explicitly:

- definition and units of `rho_0`;
- normalization of field/density variables;
- meaning and units of `c_s²`;
- exact definition of `k_J`;
- whether `lambda_J = 2π/k_J` is intended;
- scale-factor, `G`, `c`, or `hbar` factors;
- normalization used for the quantum-pressure term.

No numerical correction is inserted merely to make a test pass.

## Reproducibility

```bash
python3 -m unittest discover -s tests -p 'test_qcal_eft_*.py' -v
python3 scripts/qcal_eft_audit.py
python3 scripts/qcal_eft_dimensional_audit.py
lake env lean QCAL/Formalization/QCALEFTStabilityAudit.lean
```

GitHub Actions runs the regression and Lean gates through `.github/workflows/qcal-eft-rigor.yml`.

## Closure criterion

QCAL-EFT numerical closure is **OPEN** until every registered numerical gate is green and every physical implication has been separated from its assumptions.

> **A failed test is evidence to investigate, never a number to overwrite.**

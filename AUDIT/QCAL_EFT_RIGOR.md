# QCAL-EFT — Rigor Audit

**Branch:** `audit/qcal-eft-rigor-20260820`

This audit is designed to prevent a numerical or algebraic claim from being
called a proof merely because a desired value was inserted as an input.

## 1. Evidence classes

Every QCAL-EFT result is classified as one of:

- **DEFINITION** — a quantity fixed by definition.
- **ALGEBRAIC THEOREM** — follows from displayed equations and explicit hypotheses.
- **NUMERICAL CONSEQUENCE** — computed from the displayed equations and SI constants.
- **EMPIRICAL INPUT** — taken from an external dataset or manuscript benchmark.
- **OPEN / BLOCKED** — not yet reconciled by an executable test.

Lean proves the algebraic class. Python independently evaluates the numerical
class. Neither is allowed to silently promote an empirical input into a theorem.

## 2. Current formal anchors

The manuscript fixes

\[
f_0 = 141.7001\;\mathrm{Hz},\qquad
\omega_0 = 2\pi f_0,
\]

and defines

\[
m_{\rm eff}=\frac{\hbar\omega_0}{c^2}.
\]

The deterministic Python audit reproduces the resulting mass scale.

The Lean module `QCAL/Formalization/QCALEFTStabilityAudit.lean` proves:

1. the exact algebraic cancellation obtained by substituting the manuscript's
   curvature relation into its displayed definition of `c_s²`;
2. positivity of the displayed dispersion relation under the **exact
   sufficient condition obtained from that dispersion relation**.

The second point is intentionally stated separately from the condition in the
manuscript's earlier Lean example. The repository must not certify a weaker or
non-equivalent hypothesis merely because a tactic happens to close a goal.

## 3. Numerical closure gates

The script `scripts/qcal_eft_audit.py` transcribes the manuscript's Section 26
frequency and Jeans equations literally.

It currently checks:

- fixed spectral anchor `141.7001 Hz`;
- `m_eff` derived from the spectral anchor;
- literal reproduction of the Section 26 frequency formula;
- consistency of that formula with the stated `±0.0012 Hz` window;
- literal reproduction of the Section 26 Jeans wavelength against the stated
  `2.51 × 10^15 m` benchmark.

The final gate intentionally exits non-zero if any registered numerical claim
fails. A failure is evidence that the manuscript equation and its stated
number have not yet been reconciled; it is **not** converted into a warning.

## 4. Current scientific blocker

The literal evaluation of Eq. (26.3), using the constants and parameters
specified in the manuscript, does not reproduce the stated Eq. (26.4) value
for `lambda_J`.

This discrepancy is deliberately preserved as a failing closure gate until the
following are reconciled explicitly:

- the precise definition and units of `rho_0`;
- the meaning and units of `c_s²` in Eq. (26.3);
- the normalization of the field and density variables;
- the exact definition of `k_J` and whether `lambda_J = 2π/k_J` is intended;
- any omitted scale-factor or gravitational-coupling factors.

No numerical correction is inserted into the audit to make the test pass.

## 5. Reproducibility

Run locally:

```bash
python3 -m unittest discover -s tests -p 'test_qcal_eft_audit.py' -v
python3 scripts/qcal_eft_audit.py
```

Compile the formal proof with the repository Lean toolchain:

```bash
lake env lean QCAL/Formalization/QCALEFTStabilityAudit.lean
```

GitHub Actions runs both the Python closure gate and the Lean compilation gate
through `.github/workflows/qcal-eft-rigor.yml`.

## 6. Closure criterion

The QCAL-EFT numerical closure is considered **OPEN** until every registered
numerical gate is green and every physical implication has been separated from
its assumptions. This is the repository's anti-self-confirmation rule.

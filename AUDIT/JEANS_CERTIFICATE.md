# QCAL-EFT — Jeans Certificate

## Algebraic origin

From

\[
\omega^2(k)=Ak^4+Bk^2-C,
\]

with

\[
A=\frac{\hbar^2}{4m_{\rm eff}^2a^4},\qquad
B=\frac{c_s^2}{a^2},\qquad
C=4\pi G\rho_0,
\]

the Jeans boundary is \(\omega^2=0\). Setting \(x=k^2\) gives

\[
Ax^2+Bx-C=0.
\]

The positive root is

\[
\boxed{x_J=\frac{-B+\sqrt{B^2+4AC}}{2A}},
\qquad
\boxed{k_J=\sqrt{x_J}},
\qquad
\boxed{\lambda_J=\frac{2\pi}{k_J}}.
\]

The repository contains both a SymPy derivation and a Lean uniqueness theorem
for the positive root. The numerical certificate uses the source-defined
\(f_0\), \(m_{\rm eff}\), and \(c_s^2\) relation without fitting \(\lambda_J\).

## Reproducibility

Run:

```bash
python3 scripts/qcal_eft_jeans_certificate.py
```

The same source is executed by the QCAL-EFT GitHub Actions workflow.

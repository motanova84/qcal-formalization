# QCAL-EFT — Dispersion Normalization Decision Record

## Status

**OPEN — physical normalization not yet closed.**

The repository now keeps two expressions separate:

### Literal manuscript transcription

\[
\omega^2_{\rm lit}(k)=
\frac{c_s^2k^2}{a^2}+
\frac{k^4}{4m_{\rm eff}^2a^4}
-4\pi G\rho_0.
\]

### SI-normalized quantum-pressure candidate

\[
\omega^2_{\rm SI}(k)=
\frac{c_s^2k^2}{a^2}+
\frac{\hbar^2k^4}{4m_{\rm eff}^2a^4}
-4\pi G\rho_0.
\]

The second expression is recorded only as a **candidate normalization**. It is
not promoted to the QCAL-EFT equation until it is derived from the stated
action and field normalization.

## Required closure

To close this point, the derivation must explicitly identify:

1. the dimensions and normalization of `Psi`;
2. whether `rho` is mass density, number density, or a rescaled field density;
3. the precise Madelung substitution;
4. the canonical momentum convention;
5. the definition of `m_eff` in the action;
6. the units carried by the QCAL field;
7. all factors of `hbar`, `c`, and the scale factor `a`.

Only after this chain is derived may the repository select one expression as the
physical dispersion law.

## Anti-circularity rule

A numerical result cannot be used to choose the normalization and then be cited
as evidence that the chosen normalization is correct.

The normalization must be fixed by the action/definitions first. Observational
or benchmark agreement is evaluated afterwards.

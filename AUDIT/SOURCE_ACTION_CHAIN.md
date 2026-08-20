# QCAL-EFT source action chain — closure record

**Source:** `QCAL_Perturbaciones_Cosmologicas_H_QCAL.md`, dated 20 August 2026.

## Canonical action transcribed from Eq. (5.1)

The source gives

\[
S=\int d^4x\sqrt{-g}\left[
-g^{\mu\nu}\partial_\mu\Psi^*\partial_\nu\Psi
-U(|\Psi|^2)
-\zeta R|\Psi|^2
-\frac{c_2}{2}A_{\rm eff}^2|\Psi|^2
\right].
\]

The formal repository now records this action explicitly in
`QCALEFTActionBridge.lean` rather than referring to an unspecified action.

## What the source itself states next

The document states that varying the action with respect to `Psi*` gives the
background equation (3.1), and that expanding the action to second order,
integrating by parts, and identifying the coefficient of `delta Psi*` gives the
linearized equation (3.2). It also gives the effective stress tensor obtained by
metric variation in Eqs. (5.2)-(5.5). fileciteturn33file2L117-L149

The hydrodynamic decomposition is then

\[
\Psi=\rho e^{i\theta},
\]

with linear perturbations of `rho` and `theta`, followed by the statement that
separating real and imaginary parts yields continuity/Euler equations and the
quantum Jeans scale. fileciteturn33file9L541-L557

## Spectral chain explicitly stated by the source

The source defines

\[
H_{QCAL}\Psi_0=\omega_0\Psi_0,
\qquad
\omega_0=2\pi f_0,
\qquad f_0=141.7001\,Hz,
\]

and

\[
m_{eff}=\frac{\hbar\omega_0}{c^2}.
\]

It then states the potential-curvature relation

\[
U''_0=\omega_0^2-\frac{c_2}{2}A_{eff,0}^2+\zeta R_0,
\]

followed by

\[
c_s^2=\frac{\rho_0}{m_{eff}}\omega_0^2.
\]

Finally it gives the canonical dispersion relation (8.5) and the explicit
identity (8.6)

\[
\frac{\hbar^2 k^4}{4m_{eff}^2a^4}
=
\frac{c^4k^4}{16\pi^2f_0^2a^4}.
\]

These statements are reproduced directly from the source and independently
checked by `scripts/qcal_eft_source_equation_audit.py`. fileciteturn34file6L284-L318

## Important correction to the previous audit

The earlier blocker described the `hbar² k⁴` term as if it were absent from the
source. That was too broad. The source explicitly contains the `hbar²`-normalized
term in Eq. (8.6) and the canonical expression in Eq. (8.5). fileciteturn34file6L306-L318

The real remaining issue is therefore narrower and more useful:

> **derive Eq. (8.5) from Eq. (5.1), through the equations and hydrodynamic
> reduction stated in Eqs. (3), (5), and (6), without treating Eq. (8.5) itself
> as a premise.**

## Closure status

- Eq. (5.1) source transcription: **ANCHORED**.
- Eq. (8.2) numerical definition: **REPRODUCED**.
- Eq. (8.3) -> Eq. (8.4) cancellation: **FORMALIZED** under Eq. (8.3) and the source sound-speed definition.
- Eq. (8.6) algebraic identity: **REPRODUCED**.
- Eq. (5.1) -> Eq. (3.1): **OPEN — full covariant variation**.
- Eq. (3.2) -> hydrodynamic system -> Eq. (8.5): **OPEN**.
- Eq. (8.5) -> Jeans polynomial: **OPEN pending exact convention check**.

## Additional source inconsistency to audit

The Lean snippet printed in Section 11 assumes `m_eff = omega0` as a hypothesis,
whereas Eq. (8.2) defines `m_eff = hbar * omega0 / c²`. Those are not the same
physical quantity. The repository must not copy that hypothesis into a theorem
without flagging the mismatch.

This is now a mandatory audit item.

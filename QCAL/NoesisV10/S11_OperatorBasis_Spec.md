# NOĒSIS V10 — S11: operador asociado y base espectral

## Estado

**Especificación matemática consolidada. Lean: pendiente de cierre API por API.**

S11 depende de S09 (forma cerrada, simétrica, semibounded/coerciva) y S10 (inclusión compacta del dominio de forma en `L²`).

## 1. Operador asociado

Sea

\[
\mathcal H=L^2(\mathbb R,du),
\qquad
Q=H^1(\mathbb R)\cap L^2(\mathbb R,W_\alpha du),
\]

con

\[
W_\alpha(u)=\alpha\log(1+u^2),\quad \alpha>0,
\]

y sea `V_ε` un operador acotado autoadjunto. La forma sesquilineal

\[
q_{\varepsilon,\alpha}[f,g]
 =\langle f',g'\rangle
 +\langle V_\varepsilon f,g\rangle
 +\int W_\alpha(u)f(u)\overline{g(u)}\,du
\]

define, tras un desplazamiento constante si es necesario, una forma cerrada, densamente definida y acotada inferiormente.

El teorema de representación de Kato/Friedrichs produce un único operador autoadjunto

\[
H_{\varepsilon,\alpha}
\]

acotado inferiormente tal que

\[
f\in D(H_{\varepsilon,\alpha})
\iff
f\in Q\ \text{y existe }h\in\mathcal H\text{ con }
q[f,g]=\langle h,g\rangle\ \forall g\in Q,
\]

y entonces `H f = h`.

Cuando los términos se interpretan distribucionalmente, la expresión formal es

\[
H_{\varepsilon,\alpha}
=-\frac{d^2}{du^2}+V_\varepsilon+W_\alpha.
\]

**Nota:** `V_ε` no debe escribirse como una función `V_ε(u)` salvo que se haya demostrado previamente que es un operador de multiplicación. En S05 es, en general, un operador aritmético acotado construido a partir de traslaciones.

## 2. Resolvente compacto

S10 demuestra

\[
Q\hookrightarrow\mathcal H
\]

compactamente. La representación de formas da, para `c` suficientemente grande,

\[
(H_{\varepsilon,\alpha}+c)^{-1}:\mathcal H\to Q\hookrightarrow\mathcal H.
\]

La composición es compacta. Por tanto `H` tiene resolvente compacto.

## 3. Consecuencia espectral

El teorema espectral para operadores autoadjuntos con resolvente compacto implica que

\[
\sigma(H)=\{\lambda_n:n\ge1\},
\]

con `λ_n` reales, cada uno de multiplicidad finita, sin punto de acumulación finito y

\[
\lambda_n\to+\infty.
\]

Además, existe una base ortonormal completa de `L²(ℝ)` formada por autofunciones `ψ_n`:

\[
H\psi_n=\lambda_n\psi_n.
\]

## 4. Corrección de una afirmación anterior

No debe invocarse "Hilbert–Schmidt" para afirmar que `H` es compacto. `H` es un operador no acotado en general. Lo compacto es el resolvente `(H+c)^{-1}`. La base ortonormal completa se obtiene del teorema espectral aplicado al operador autoadjunto con resolvente compacto.

Asimismo, no es correcto escribir

\[
\|H\|=\sup_n|\lambda_n|
\]

porque `λ_n→∞` y, por tanto, `H` no es acotado. La afirmación correcta es la caracterización de la norma del resolvente:

\[
\|(H-z)^{-1}\|=\frac1{\operatorname{dist}(z,\sigma(H))}
\]

para `z` fuera del espectro.

## 5. Límite de S11

S11 establece únicamente la estructura espectral discreta. No establece que `λ_n` sean los ordinates `γ_n` de los ceros de `ξ`. Esa identificación queda expresamente abierta para S13–S15.

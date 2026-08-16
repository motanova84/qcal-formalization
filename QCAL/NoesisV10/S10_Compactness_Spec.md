# NOĒSIS V10 — S10: Compacidad del resolvente

## Estado

`SPECIFICATION_READY / PROOF_PENDING`

Este documento fija el contrato matemático de S10 sin confundir una especificación con una prueba Lean compilada.

## 1. Espacio de Hilbert y forma

Sea

\[
H=L^2(\mathbb R,du).
\]

Para un potencial regularizado autoadjunto acotado \(V_\varepsilon\) y un potencial de confinamiento \(W\ge 0\), \(W(u)\to+\infty\) cuando \(|u|\to\infty\), consideramos

\[
q_\varepsilon[u]=\|u'\|_2^2+\langle V_\varepsilon u,u\rangle+
\int_{\mathbb R}W(u)|u(u)|^2\,du,
\]

con dominio

\[
Q=H^1(\mathbb R)\cap L^2(\mathbb R,W(u)du).
\]

La notación \(u\) dentro de \(W(u)\) denota la variable espacial; no es una composición adicional.

## 2. Hipótesis mínimas de S10

Se asumen únicamente:

1. \(V_\varepsilon\) es autoadjunto y acotado.
2. \(W\ge0\), medible y localmente acotado.
3. \(W(u)\to\infty\) para \(|u|\to\infty\).
4. La forma \(q_\varepsilon\), tras un desplazamiento constante si es necesario, es cerrada y semibajada.

No se usa ninguna afirmación sobre los ceros de \(\zeta\), la fórmula de Weil ni la hipótesis de Riemann.

## 3. Lema de control de colas

Si \((u_n)\subset Q\) satisface

\[
\sup_n\left(\|u_n'\|_2^2+\|u_n\|_2^2+
\int W|u_n|^2\right)<\infty,
\]

entonces, para todo \(\delta>0\), existe \(R>0\) tal que

\[
\sup_n\int_{|u|>R}|u_n(u)|^2du<\delta.
\]

Demostración: dado \(M>0\), elegir \(R\) tal que \(W(u)\ge M\) fuera de \([-R,R]\). Entonces

\[
\int_{|u|>R}|u_n|^2\le M^{-1}\int W|u_n|^2.
\]

## 4. Rellich local

La restricción de una sucesión acotada en \(Q\) a \([-R,R]\) es acotada en \(H^1([-R,R])\). Por Rellich–Kondrachov,

\[
H^1([-R,R])\hookrightarrow L^2([-R,R])
\]

es compacta. Por tanto, para cada \(R\), existe una subsucesión convergente en \(L^2([-R,R])\).

## 5. Diagonalización + colas

Aplicando diagonalización sobre \(R=1,2,3,\ldots\), se obtiene una subsucesión que converge localmente en \(L^2(\mathbb R)\). El control uniforme de las colas convierte la convergencia local en convergencia global en \(L^2(\mathbb R)\).

Por tanto:

\[
\boxed{Q\hookrightarrow L^2(\mathbb R)\text{ es compacta}.}
\]

## 6. Consecuencia espectral

Por la teoría de formas cerradas (representación de Friedrichs/Kato), el operador autoadjunto asociado a \(q_\varepsilon\) tiene resolvente compacto:

\[
\boxed{(H_\varepsilon-z)^{-1}\in\mathcal K(L^2(\mathbb R)),\qquad z\notin\sigma(H_\varepsilon).}
\]

Consecuentemente, su espectro es discreto, con multiplicidades finitas y sin punto de acumulación finito.

Si además \(H_\varepsilon\) es inferiormente acotado, entonces

\[
\lambda_n\to +\infty.
\]

## 7. Límite lógico

S10 demuestra solamente:

`confinamiento + forma cerrada + control de colas`

`⇒ inclusión compacta`

`⇒ resolvente compacto`

`⇒ espectro discreto`.

No demuestra que los autovalores sean los ceros de \(\xi\). Ese puente pertenece exclusivamente a S11–S15.

## 8. Criterio de anclaje Lean

El archivo Lean correspondiente no debe marcar S10 como completado hasta que compile con Mathlib sin `sorry`, `axiom` o equivalentes introducidos para ocultar obligaciones matemáticas.

**Estado de auditoría:** matemáticamente especificado; formalización Lean ejecutable pendiente.
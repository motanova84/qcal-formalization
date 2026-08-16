# NOĒSIS V10 — S12: asintótica espectral del confinamiento logarítmico

## Estado

**Especificación matemática consolidada; resultado asintótico fijado. Lean: pendiente de formalización de la estimación semiclasica/API exacta.**

Consideramos

\[
H_{\varepsilon,\alpha}=-\partial_u^2+V_\varepsilon+W_\alpha(u),
\qquad
W_\alpha(u)=\alpha\log(1+u^2),\quad \alpha>0,
\]

con `V_ε` acotado autoadjunto. El término `V_ε` puede ser no local; por ser acotado, no modifica la escala principal de la ley de Weyl de orden uno-dimensional para este potencial.

## 1. Función de conteo

Definimos

\[
N(T)=\#\{n:\lambda_n\le T\}.
\]

La ley semiclasica principal es

\[
N(T)\sim\frac1\pi\int_{W_\alpha(u)<T}\sqrt{T-W_\alpha(u)}\,du.
\]

Para el potencial logarítmico,

\[
|u|<\sqrt{e^{T/\alpha}-1}.
\]

Por tanto

\[
N(T)\sim\frac1\pi\int_{-\sqrt{e^{T/\alpha}-1}}^{\sqrt{e^{T/\alpha}-1}}
\sqrt{T-\alpha\log(1+u^2)}\,du.
\]

## 2. Evaluación asintótica correcta

La escala natural es

\[
u=e^{T/(2\alpha)}x.
\]

En la región dominante,

\[
T-\alpha\log(1+u^2)
= -2\alpha\log|x|+o(1).
\]

Además,

\[
\int_{-1}^{1}\sqrt{-2\alpha\log|x|}\,dx
=\sqrt{2\pi\alpha}.
\]

Se obtiene

\[
\boxed{
N(T)\sim \sqrt{\frac{2\alpha}{\pi}}\,e^{T/(2\alpha)}
}
\qquad(T\to+\infty).
\]

**Corrección crítica:** no aparece un factor `√T` en el término principal. La afirmación anterior

`N(T) ~ const · e^{T/(2α)} √T`

queda anulada y no debe volver a utilizarse.

## 3. Asintótica de los autovalores

Si

\[
C_\alpha=\sqrt{\frac{2\alpha}{\pi}},
\]

la inversión de la ley de conteo da, en primer orden,

\[
\boxed{
\lambda_n=2\alpha\log n-2\alpha\log C_\alpha+o(1)
}
\]

y por tanto

\[
\boxed{\lambda_n=2\alpha\log n-\alpha\log\!\left(\frac{2\alpha}{\pi}\right)+o(1).}
\]

## 4. Obstrucción estructural al puente de Riemann

La función de conteo de los ceros no triviales de `ξ`, contando multiplicidades, satisface la ley de Riemann–von Mangoldt

\[
N_\xi(T)
=\frac{T}{2\pi}\log\frac{T}{2\pi e}+O(\log T).
\]

Las escalas son incompatibles:

\[
N_H(T)\asymp e^{T/(2\alpha)},
\qquad
N_\xi(T)\asymp T\log T.
\]

En consecuencia, **ningún valor fijo `α>0` puede hacer que este operador con potencial `α log(1+u²)` tenga como espectro completo los ordinates de los ceros de `ξ`**.

Esto no es un fallo de S10/S11. Es información estructural de S12: el confinamiento elegido produce un espectro discreto, pero su densidad espectral no es la densidad de Riemann.

## 5. Consecuencia para S13–S15

El puente aritmético no puede construirse mediante una simple identificación

\[
\lambda_n=\gamma_n
\]

para este `W_α`. Debe introducirse un confinamiento cuya acción clásica satisfaga la escala de conteo requerida por Riemann–von Mangoldt, o bien abandonarse la identificación directa de autovalores y formular una relación espectral distinta (por ejemplo, mediante una fórmula de traza/determinante regularizado).

La modificación del potencial no queda elegida ad hoc por ajuste numérico: debe imponerse como **restricción de diseño derivada de la ley de conteo objetivo**.

## 6. Gate de rigor

S12 se considera matemáticamente cerrado como diagnóstico asintótico una vez que la ley semiclasica correspondiente a la clase exacta de perturbaciones `V_ε` haya sido demostrada con las hipótesis precisas. La identidad con `ξ` sigue abierta.

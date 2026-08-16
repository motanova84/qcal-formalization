# NOĒSIS V10 — Especificación formal canónica

## Regla de estado

Este documento distingue estrictamente entre:

- **definición**: objeto introducido formalmente;
- **lema/teorema probado**: prueba aceptada por Lean o derivación matemática completa documentada;
- **obligación**: hueco explícito (`sorry`) que todavía debe cerrarse;
- **hipótesis**: supuesto externo que no puede presentarse como consecuencia del sistema.

Un `sorry` es una **baldosa pendiente**, no un teorema. Ningún resultado con `sorry` se contabiliza como demostrado.

## Arquitectura V10

| ID | Objeto / obligación | Dependencia | Estado canónico |
|---|---|---|---|
| S01 | Geometría adélica, idèles y medida cociente | teoría adélica | EN CIERRE / REVISAR API |
| S02 | Dominio de D = -i d/dt y autoadjunción | análisis funcional | PENDIENTE |
| S03 | Mellin unitaria y transporte de D | S01/S02 | PENDIENTE |
| S04 | Hecke local T_a = (U_a + U_-a)/2 | modelo L²(R) | **ESPECIFICACIÓN ANCLADA; Lean L1-L2 PENDIENTES** |
| S05 | Convergencia de V_arith en norma de operador | S04 | PENDIENTE |
| S06 | Regularización / clase de Schatten del núcleo | S05 | PENDIENTE |
| S07 | Definición independiente de W | geometría + análisis | PENDIENTE |
| S08 | Asintótica y W(t) → +∞ | S07 | PENDIENTE |
| S09 | Coercividad de q_pi | S02/S07/S08 | PENDIENTE |
| S10 | Compacidad de la inmersión / resolvente | S09 | PENDIENTE |
| S11 | Autoadjunción de D_pi | S05/S09 | PENDIENTE |
| S12 | Fórmula de traza | S11 | PENDIENTE |
| S13 | Determinante regularizado | S12 + Schatten | PENDIENTE |
| S14 | Correspondencia espectro ↔ ceros de xi | S12/S13 | PENDIENTE |
| S15 | Correspondencia de multiplicidades | S14 | PENDIENTE |

## S04 — especificación matemática

Trabajamos primero en el modelo local `H = L²(R, dt)`. Para `a ∈ R`, sea

\[
(U_a f)(t)=f(t-a),
\qquad
T_a=\frac12(U_a+U_{-a}).
\]

La realización analítica debe establecer:

1. `U_a` es unitario en `L²(R,dt)`;
2. `U_a* = U_{-a}`;
3. `||T_a||_op ≤ 1`;
4. `T_a* = T_a`;
5. bajo Fourier unitario, `F T_a F⁻¹ = M_{cos(aξ)}`;
6. si `a ≠ 0`, `σ(T_a)=[-1,1]`;
7. para el modelo Mellin, `a=m log p` con `p` primo y `m≥1`.

### Corrección importante respecto de borradores anteriores

El caso `a=0` **no** tiene espectro `[-1,1]`: entonces `T_0=I` y `σ(T_0)={1}`. Por eso la afirmación espectral `[-1,1]` queda condicionada a `a≠0` (y, en el caso de potencias primas, `m≥1`).

Además, el coeficiente de von Mangoldt no se redefine aquí de forma ad hoc. Su definición se delegará a la teoría aritmética existente y se conectará con S05 mediante una interfaz explícita.

## S04 — obligaciones Lean

- **S04.L1**: cerrar el acotamiento de `T_a` en la API actual de `ContinuousLinearMap`.
- **S04.L2**: cerrar `T_a* = T_a` usando la identidad de adjuntos de la familia de traslaciones.
- **S04.L3**: construir la realización concreta en `L²(R,dt)` y probar la equivalencia unitaria de Fourier.
- **S04.L4**: demostrar que el espectro del multiplicador `cos(aξ)` es `[-1,1]` para `a≠0`.
- **S04.L5**: transportar el resultado por Mellin y fijar la convención de signo/normalización.

## Regla de avance

Cada cierre debe añadir una prueba reproducible y reducir el inventario de obligaciones. No se cambia un `sorry` por un axioma oculto ni por una definición circular.

La construcción puede avanzar por capas: primero el modelo local demostrable, después el puente Mellin, después la integración aritmética y finalmente el puente espectral global.

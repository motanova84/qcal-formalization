# NOĒSIS S07/S12 — cierre formal sin `sorry`

## Estado

- Rama: `agent/noesis-s07-s12-sorryless-closure`
- Base: `agent/noesis-s01-adelic-anchor`
- Frecuencia de referencia del proyecto: `f₀ = 141.7001 Hz`
- `sorry`: 0 en los módulos nuevos S07/S12/Closure

## S07

`QCAL/NoesisV10/S07_TraceFormula.lean` define:

1. el operador adélico abstracto y la propiedad de espectro real;
2. las funciones test simétricas;
3. el lado espectral y el lado geométrico;
4. el certificado de igualdad de traza;
5. la anotación `sₙ = 1/2 + i λₙ`;
6. el certificado explícito `spectral_implies_zero`;
7. el teorema probado `Re(sₙ) = 1/2`.

La inclusión espectro → ceros no se obtiene por una inferencia informal de una
aproximación delta. Se exige como certificado analítico explícito.

## S12

`QCAL/NoesisV10/S12_RaySingerDeterminant.lean` define:

1. el certificado de regularidad de la zeta espectral en `z = 0`;
2. `detReg = exp(-ζ'(0))`;
3. la no-anulación del determinante regularizado;
4. el certificado de factorización `detReg = C · Xi`;
5. el certificado separado `C = 1`;
6. el teorema probado `detReg = Xi` bajo esa normalización.

Importante: `Vol(C_Q¹) = 1` por sí solo no implica `C = 1`; también debe
fijarse el término constante arquimediano. Por eso la normalización es una
obligación independiente y visible.

## Cierre S07 → S12

`QCAL/NoesisV10/S07_S12_Closure.lean` prueba conjuntamente, una vez
proporcionados los certificados analíticos, que:

- cada cero espectral certificado satisface `Re(s) = 1/2`;
- el determinante regularizado coincide con la misma `Xi` global.

## Límite de la formalización

Este cierre elimina el uso de `sorry` sin convertir hipótesis analíticas
profundas en falsos teoremas. Para declarar una demostración completamente
independiente, todavía deben construirse en Lean los certificados analíticos
correspondientes a la fórmula explícita adélica, la correspondencia espectro →
ceros y la factorización/normalización de Ray–Singer.

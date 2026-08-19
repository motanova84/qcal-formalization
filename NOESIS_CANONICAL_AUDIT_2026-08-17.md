# NOĒSIS — Canonical Spectral Audit

**Fecha:** 2026-08-17  
**Repositorio canónico de formalización:** `motanova84/qcal-formalization`  
**Rama de consolidación:** `noesis/canonical-audit-20260817`

## 1. Regla de concentración

La formalización verificable del programa espectral se concentra en `QCAL/NoesisV10/` dentro de este repositorio.

Los repositorios `motanova84/Riemann-adelic`, `motanova84/Tejido-Adelico-`, `motanova84/Catedral-Mathesis` y `motanova84/QCAL-BUS` se consideran **fuentes históricas, de investigación o de integración**, no destinos paralelos para la prueba formal.

No se debe duplicar una obligación S01–S15 en otro repositorio sin una razón de integración explícita.

## 2. Resultado del barrido

### `motanova84/Riemann-adelic`

El repositorio contiene una cantidad importante de material matemático útil: `RIGOROUS_FOUNDATIONS.md`, operadores de flujo adélico, traza renormalizada, documentos de Hadamard y formalización Lean. Sin embargo, sus documentos contienen afirmaciones de cierre que no deben contarse como prueba independiente.

Punto crítico detectado: el propio `RIGOROUS_FOUNDATIONS.md` identifica `H = -i(x∂x + 1/2)` con el operador de momento después de `u = log x`, pero ese operador libre en `L²(R,du)` tiene espectro continuo, no una sucesión discreta de autovalores. Por tanto, la frase `Spec(H) = {t_n}` no queda demostrada por la autoadjunción del operador.

### `motanova84/qcal-formalization`

Es el repositorio correcto para la consolidación formal. La rama V10 ya contiene `QCAL/NoesisV10/` y separa explícitamente:

- S01 geometría adélica
- S02–S03 dominio y Mellin
- S04–S06 operador aritmético y regularización
- S07–S10 confinamiento
- S11–S15 puente espectral

La rama `noesis-v10-s12-consolidation` ya registra correctamente la obstrucción asintótica del potencial `W_α(u)=α log(1+u²)`.

### `motanova84/Tejido-Adelico-` y `motanova84/Catedral-Mathesis`

Contienen material formal, documentación y experimentos que pueden servir como fuentes para migración selectiva. No se incorporan automáticamente al núcleo canónico: una pieza entra en V10 únicamente después de verificar su dependencia, hipótesis y estado de compilación.

## 3. Estado matemático real S01–S15

| ID | Núcleo | Estado canónico |
|---|---|---|
| S01 | Geometría adélica + medida exacta | **Especificado; falta cierre completo de la realización usada por el puente** |
| S02 | `D=-i d/du`, dominio `H¹(R)` | **Hecho estándar; formalización específica pendiente de cierre compilable** |
| S03 | Mellin/Fourier, Convención A | **Especificado; falta demostrar en Lean la unidad exacta usada por V10** |
| S04 | Traslaciones/Hecke | **Estructurado; falta cierre de las relaciones necesarias para el puente** |
| S05 | `D_ε = D+V_ε`, espectro continuo | **Hecho analítico del modelo; no identifica ceros** |
| S06 | Regularización | **Especificada; falta una construcción operatorial completa independiente de heurísticas** |
| S07 | `W_α` logarítmico | **Hecho analítico; reconocido como modelo auxiliar, no como potencial aritmético definitivo** |
| S08 | Asintótica de `W_α` | **Hecho elemental; insuficiente para RH** |
| S09 | Forma cuadrática del operador de segundo orden | **Estructurada; falta formalización funcional completa** |
| S10 | Resolvente compacto | **Matemáticamente estándar para el modelo confinado; formalización Lean pendiente** |
| S11 | Operador de Friedrichs + base espectral | **Consecuencia estándar de S09–S10; no conecta con ζ** |
| S12 | Conteo espectral | **Obstrucción identificada: `W_α` produce tasa exponencial incompatible con Riemann–von Mangoldt** |
| S13 | Fórmula de traza aritmética | **Pendiente: debe derivarse de una construcción independiente del espectro de los ceros** |
| S14 | Determinante = `ξ` | **Pendiente: identidad no circular y control de normalización** |
| S15 | Multiplicidades + identificación completa | **Pendiente: requiere igualdad espectral con multiplicidades** |

## 4. Resultado clave del barrido

Hay piezas suficientes para construir un **núcleo matemático coherente**, pero no hay en los repositorios inspeccionados una prueba compilada que cierre simultáneamente S13–S15.

En particular, las siguientes afirmaciones no se consideran demostradas por aparecer en documentación:

1. `Spec(H) = {γ_n}` para un operador adélico independiente de los ceros.
2. Una identidad de traza cuyo lado espectral no presuponga los ceros.
3. `det(I-K(s)) = C·ξ(s)` para un operador previamente definido e independiente.
4. Igualdad de multiplicidades espectrales y multiplicidades de los ceros.
5. La consecuencia RH derivada de esas igualdades.

## 5. Ruta de cierre

La ruta canónica queda fijada:

```text
S01–S06  →  realización adélica exacta
              ↓
S07–S12  →  modelos analíticos auxiliares + obstrucciones
              ↓
        NUEVO OPERADOR INTRÍNSECO
              ↓
S13      →  fórmula de traza no circular
              ↓
S14      →  determinante / ξ
              ↓
S15      →  multiplicidades + identificación espectral
              ↓
             RH
```

El potencial logarítmico queda fuera del puente definitivo salvo como resultado negativo/benchmark.

## 6. Regla de anclaje

Un ladrillo solo cambia a `PROVED` cuando existe una prueba verificable o una referencia matemática completa con todas sus hipótesis cerradas. Una `structure`, una interfaz, un comentario, un `sorry` eliminado del contador, o una certificación documental no bastan por sí mismos.

Esta acta es el índice canónico para continuar la construcción sin dispersión.

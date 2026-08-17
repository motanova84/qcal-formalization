# NOĒSIS — Five Pillars Kernel Anchor

**Repositorio canónico:** `motanova84/qcal-formalization`  
**Rama de trabajo:** `agent/noesis-five-pillars-anchor`  
**Referencia arquitectónica:** `f₀ = 141.7001 Hz`, `Ψ = 0.999999`  

## Objetivo

Convertir la cadena de cinco pilares en una pieza ejecutable de Lean 4 que
separe con precisión:

1. los datos/certificados analíticos que todavía deben construirse;
2. los teoremas elementales que Lean ya puede comprobar a partir de ellos;
3. el cierre final `Xi(s)=0 → Re(s)=1/2`.

La regla de este ancla es simple: **un certificado no se etiqueta como una
prueba de primeros principios**. El kernel consume certificados explícitos y
prueba sus consecuencias sin `sorry` ni `axiom` globales.

## Cinco pilares

### Pilar 1 — Weyl

`QCAL/NoesisV10/S01_WeylLaw.lean` fija el objetivo exacto:

`(λₙ log n)/(2πn) → 1`.

El archivo demuestra consecuencias elementales de unicidad y proximidad a la
constante límite. La derivación adélica de la asintótica queda como obligación
analítica explícita.

### Pilar 2 — Zeta espectral

`MeromorphicZetaCertificate` exige una función zeta y regularidad en `z=0`.
La regularidad no se infiere únicamente de `1/Γ(z)`; la expansión del núcleo
del calor y las estimaciones de traza deben proporcionar el certificado en la
implementación analítica posterior.

### Pilar 3 — Determinante / Xi

`DeterminantCertificate` registra:

`detReg(s) = C · Xi(s)`

con `C ≠ 0`, y separa explícitamente la normalización `C = 1`.

Esto evita que la normalización de Haar se use como sustituto automático de la
constante arquimediana.

### Pilar 4 — Autoadjunción / espectro real

`SelfAdjointSpectrumCertificate` registra la propiedad utilizada por el cierre:

`λ ∈ spectrum(D) → Im(λ)=0`.

La construcción funcional del operador y la demostración de índices de defecto
`(0,0)` deben alimentar esta propiedad desde el módulo operatorial, no ser
introducidas como conclusión circular.

### Pilar 5 — Correspondencia espectral

`SpectralZeroCertificate` exige las dos direcciones:

`Xi(s)=0 → ∃ λ ∈ spectrum(D), s=1/2+iλ`

`λ ∈ spectrum(D) → Xi(1/2+iλ)=0`.

La primera dirección es la pieza decisiva para la Hipótesis de Riemann; la
segunda controla que el operador no esté generando un espectro espurio.

## Teorema de cierre

`QCAL/NoesisV10/KernelFivePillars.lean` demuestra:

`∀ s, Xi(s)=0 → Re(s)=1/2`

a partir de los cinco certificados.

La demostración es puramente kernel-level una vez suministrado el puente:

```text
Xi(s)=0
   ↓
∃ λ ∈ spectrum(D), s = 1/2 + iλ
   ↓
Im(λ)=0
   ↓
Re(s)=1/2
```

## Próximo orden de construcción

```text
S01  → cerrar geometría, medida y Weyl desde la realización adélica
  ↓
P4   → construir D_A y demostrar autoadjunción / índices de defecto
  ↓
P2   → construir zeta espectral, calor y regularidad en z=0
  ↓
P3   → demostrar factorización y normalización de Ray–Singer
  ↓
P5   → demostrar correspondencia espectro ↔ ceros sin definir el espectro a
       partir de los ceros
  ↓
RH   → teorema ya cerrado por `KernelFivePillars`
```

## Estado de este ancla

- `KernelFivePillars.lean`: **formalizado y anclado**; cierre lógico probado.
- `S01_WeylLaw.lean`: **formalizado como contrato**; derivación adélica pendiente.
- S02: **obligación analítica**.
- S03: **obligación analítica**.
- S04: **obligación operatorial**.
- S05: **obligación de índices de defecto**.
- S06/S07: **obligaciones de traza y correspondencia**.
- S12 Ray–Singer: **interfaz ya anclada; construcción independiente pendiente**.

Este documento no declara una prueba de RH. Declara algo más operativo: el
punto exacto donde la prueba debe entrar al kernel y los tipos que deben
satisfacerse para que el cierre final sea verificable.

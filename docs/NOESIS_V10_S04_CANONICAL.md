# NOĒSIS V10 — S04 CANONICAL CLOSURE

## Estado

S04 is **analytically established at the local model level**, but it is not marked as fully machine-verified until the Lean implementation compiles without placeholders.

This document is the canonical bridge between the mathematical specification and the Lean obligations.

## 1. Local Hilbert model

Let H = L²(ℝ, dt). For a ∈ ℝ define the translation

U_a f(t) = f(t-a)

and the symmetric Hecke-shift

T_a = (U_a + U_{-a})/2.

### Proven mathematical facts

1. U_a is unitary.
2. U_a* = U_{-a}.
3. T_a is bounded with ||T_a|| ≤ 1.
4. T_a is self-adjoint.
5. For a ≠ 0, Fourier conjugation gives the multiplier cos(aξ) (up to the Fourier normalization convention).
6. Consequently σ(T_a) = [-1,1].
7. T_a T_b = T_b T_a.

## 2. Important normalization correction

The exact Fourier multiplier depends on the Fourier convention. With

Ff(ξ) = (2π)^(-1/2) ∫ f(t)e^(-iξt)dt,

one obtains cos(aξ). With the 2π-frequency convention the multiplier is cos(2πaξ). The repository must never silently mix these conventions.

## 3. Mellin bridge

Use the unitary logarithmic change of variables

(Ju)(t) = e^(t/2) u(e^t),

from L²(ℝ₊, dx/x) to L²(ℝ,dt).

A multiplicative dilation u(x) ↦ u(e^a x) is conjugated by J to an additive translation. This is the rigorous bridge used to identify a = m log p.

We do **not** claim that the Mellin transform literally maps an operator already acting on L²(ℝ) to itself without specifying the conjugating spaces and conventions.

## 4. Arithmetic Hecke parameters

For p prime and m ≥ 1:

a(p,m) = m log p,

T_{p^m} := T_{a(p,m)}.

The local operator facts therefore transfer immediately once the dilation/logarithmic unitary is formalized.

## 5. Critical correction to V_arith

The unregularized assertion

Σ_{p,m} (log p) p^(-m/2) T_{p^m}

converges absolutely in operator norm is **not accepted as a theorem**. The m=1 prime contribution is not absolutely summable at exponent 1/2.

Therefore S05/S06 must introduce and prove an explicit regularization or a genuinely stronger coefficient estimate. A Gaussian factor such as exp(-β(m log p)^2), β>0, is one admissible candidate, but its exact relation to the intended arithmetic operator must be proved rather than inserted only to force convergence.

Thus S04 closes the elementary local operators; S05 begins the genuinely arithmetic convergence problem.

## 6. Canonical obligation ledger

| ID | Claim | Status |
|---|---|---|
| S04.L1 | U_a unitary | analytic theorem; Lean obligation |
| S04.L2 | T_a self-adjoint, bounded | analytic theorem; Lean obligation |
| S04.L3 | Fourier multiplier | analytic theorem; Lean obligation |
| S04.L4 | Mellin/logarithmic unitary bridge | analytic theorem; Lean obligation |
| S04.L5 | T_{p^m}=T_{m log p} | definition + bridge |
| S04.L6 | spectrum [-1,1], a≠0 | analytic theorem; Lean obligation |
| S04.L7 | unregularized V_arith norm convergence | **NOT ESTABLISHED** |
| S05 | regularized arithmetic series | next critical block |

## 7. Rule for the cathedral

A green mathematical result is not automatically a green Lean result. A `sorry`, `axiom`, or opaque imported theorem that contains the target claim remains an open dependency until audited.

Likewise, a repository tracker reporting zero `sorry`s is metadata, not a proof certificate by itself.

The construction proceeds by replacing each open dependency with either:

- a compiled proof from trusted libraries,
- a separately verified lemma,
- or an explicitly isolated hypothesis whose mathematical necessity is recorded.

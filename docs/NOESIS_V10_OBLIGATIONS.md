# NOĒSIS V10 — Obligation Ledger

Generated as the working ledger for the V10 construction. This file intentionally records open mathematical obligations instead of silently treating placeholders as proofs.

## Active ledger

| ID | Obligation | Acceptance criterion | Status |
|---|---|---|---|
| S01.T1 | Correct idelic quotient model | precise topological/group definition | OPEN |
| S01.T2 | Haar quotient measure | well-defined invariant measure | OPEN |
| S01.T3 | Adelic norm/characters | measurable continuous character | OPEN |
| S02.T1 | Operator D | densely defined symmetric operator | OPEN |
| S02.T2 | Essential self-adjointness/domain | theorem with exact domain | OPEN |
| S03.T1 | Mellin transform | unitary equivalence with Plancherel normalization | OPEN |
| S04.T1 | Hecke/dilation shifts | bounded unitary shifts and adjoints | OPEN |
| S04.T2 | Symmetry | exact adjoint identity | OPEN |
| S05.T1 | Coefficient summability | operator-norm or form convergence | OPEN |
| S05.T2 | V_arith self-adjointness | bounded/self-adjoint limit | OPEN |
| S06.T1 | Kernel regularization | genuine L² kernel, not a Dirac distribution | OPEN |
| S06.T2 | Schatten/Fredholm class | exact class required by determinant | OPEN |
| S07.T1 | Canonical W | definition internal to established adelic data | OPEN |
| S07.T2 | Reality/measurability | proved from the definition | OPEN |
| S08.T1 | W → +∞ | quantitative asymptotic with constants | OPEN |
| S08.T2 | Lower bound | W(t) ≥ coercive lower bound outside compact set | OPEN |
| S09.T1 | Closed semibounded form | precise form domain | OPEN |
| S09.T2 | Coercivity | explicit c,C and proof | OPEN |
| S10.T1 | Compact embedding | compactness theorem for exact weighted form domain | OPEN |
| S11.T1 | Kato–Rellich/form-sum theorem | exact hypotheses verified | OPEN |
| S12.T1 | Trace-class test functions | identify admissible test class | OPEN |
| S12.T2 | Explicit/Weil trace formula | equality with arithmetic side | OPEN |
| S13.T1 | Regularized determinant | definition and convergence | OPEN |
| S13.T2 | Determinant–ξ identity | equality up to rigorously characterized factor | OPEN |
| S14.T1 | Spectral inclusion | every eigenvalue gives a zero | OPEN |
| S14.T2 | Surjectivity | every nontrivial zero occurs | OPEN |
| S15.T1 | Multiplicities | algebraic/geometric multiplicity match | OPEN |
| S15.T2 | RH consequence | derive Re(ρ)=1/2 from S14/S15 | BLOCKED |

## Review rule

When an obligation is solved, replace `OPEN` with `PROVED` and record the theorem/file/commit that closes it. If a proposed proof fails, retain the obligation and record the obstruction rather than weakening the statement silently.

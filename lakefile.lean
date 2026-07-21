import Lake
open Lake DSL

package «qcal-formalization» where
  description := "QCAL - Quantum Coherence Algebraic Logic: complete formalization in Lean 4"

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

@[default_target]
lean_lib QCAL where
  -- Main library: QCAL formalization

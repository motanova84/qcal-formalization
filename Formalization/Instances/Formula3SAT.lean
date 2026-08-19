import Mathlib.Data.Fin.Basic

namespace QCAL
namespace Formalization
namespace Instances

/-- A literal is a variable together with a polarity. -/
structure Literal (n : ℕ) where
  variable : Fin n
  positive : Bool

/-- A 3-clause contains exactly three literals. -/
structure Clause (n : ℕ) where
  l₁ : Literal n
  l₂ : Literal n
  l₃ : Literal n

/-- Finite 3-SAT formula. -/
structure Formula3SAT (n : ℕ) where
  clauses : List (Clause n)

/-- Assignment of n Boolean variables. -/
abbrev Assignment (n : ℕ) := Fin n → Bool

end Instances
end Formalization
end QCAL

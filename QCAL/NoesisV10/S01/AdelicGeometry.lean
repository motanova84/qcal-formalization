import Mathlib.NumberTheory.AdeleRing

namespace NoesisV10.S01

noncomputable section

abbrev A : Type := AdeleRing ℚ
abbrev I : Type := Aˣ
abbrev QUnits : Type := ℚˣ

/-- Global adelic norm. This is an explicit closure obligation until the
    corresponding real Mathlib construction is identified in ApiProbe.lean. -/
opaque adelicNormHom : I →* ℝ≥0

/-- Ideles of global norm one. -/
def I1 : Subgroup I := adelicNormHom.ker

/-- Diagonal embedding of nonzero rationals into the ideles. -/
def diagonal : QUnits →* I :=
  Units.map (algebraMap ℚ A)

/-- Product formula on the diagonal. -/
theorem product_formula (q : QUnits) :
    adelicNormHom (diagonal q) = 1 := by
  sorry

/-- The rational diagonal lies in the norm-one subgroup. -/
theorem diagonal_mem_I1 (q : QUnits) :
    diagonal q ∈ I1 := by
  exact product_formula q

/-- The rational subgroup inside I¹. -/
def rationalSubgroup : Subgroup I1 := by
  sorry

/-- Norm-one idele class group. -/
def C1 : Type := I1 ⧸ rationalSubgroup

end
end NoesisV10.S01

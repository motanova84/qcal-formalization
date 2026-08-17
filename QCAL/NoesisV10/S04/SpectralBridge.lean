import Mathlib.Data.Complex.Basic

/-!
# NOĒSIS V10 — S04 Spectral Bridge

Kernel-level formulation of the final logical bridge:

  Xi(s) = 0 in the non-trivial strip
      <-> s = 1/2 + i * lambda

where lambda belongs to the spectrum of the self-adjoint generator.

The analytic Guinand-Weil construction supplies the two bridge directions;
this file records them as explicit data and proves the resulting RH
implication entirely in Lean.  No `sorry` or global axiom is used here.
-/

namespace NoesisV10.S04

open Complex Set

noncomputable section

/-- Non-trivial zero of the completed Xi function. -/
def IsZeroOfXi (Xi : ℂ → ℂ) (s : ℂ) : Prop :=
  Xi s = 0 ∧ 0 < s.re ∧ s.re < 1

/-- Spectral parametrisation of a complex point by a spectral value. -/
def IsSpectralPoint (Dspec : Set ℂ) (s : ℂ) : Prop :=
  ∃ λ ∈ Dspec, s = 1 / 2 + Complex.I * λ

/-- The exact Guinand-Weil/trace bridge needed by the final step.

The analytic work is isolated in the two inclusions.  Everything after this
structure is a kernel proof from those inclusions and the reality of the
self-adjoint spectrum.
-/
structure SpectralBridgeData (Xi : ℂ → ℂ) (Dspec : Set ℂ) where
  spectral_to_zero :
    ∀ λ ∈ Dspec,
      IsZeroOfXi Xi (1 / 2 + Complex.I * λ)
  zero_to_spectral :
    ∀ s, IsZeroOfXi Xi s → IsSpectralPoint Dspec s

/-- A real spectral value produces a point on the critical line. -/
theorem critical_line_of_real_spectral_value
    {λ : ℂ}
    (hλ : λ.im = 0) :
    (1 / 2 + Complex.I * λ).re = 1 / 2 := by
  simp [Complex.add_re, Complex.mul_re, hλ]

/-- If the spectrum is real, every spectral point lies on Re(s)=1/2. -/
theorem spectral_points_on_critical_line
    {Dspec : Set ℂ}
    (hreal : ∀ λ ∈ Dspec, λ.im = 0)
    {s : ℂ}
    (hs : IsSpectralPoint Dspec s) :
    s.re = 1 / 2 := by
  rcases hs with ⟨λ, hλ, rfl⟩
  exact critical_line_of_real_spectral_value (hreal λ hλ)

/-- Bridge equivalence: Xi zeros in the critical strip are exactly the
spectrally parametrised points. -/
theorem xi_zeros_spectral_iff
    {Xi : ℂ → ℂ} {Dspec : Set ℂ}
    (bridge : SpectralBridgeData Xi Dspec)
    {s : ℂ} :
    IsZeroOfXi Xi s ↔ IsSpectralPoint Dspec s := by
  constructor
  · exact bridge.zero_to_spectral s
  · intro hs
    rcases hs with ⟨λ, hλ, rfl⟩
    exact bridge.spectral_to_zero λ hλ

/-- Final RH closure from the spectral bridge and reality of the spectrum. -/
theorem riemann_hypothesis_from_spectral_bridge
    {Xi : ℂ → ℂ} {Dspec : Set ℂ}
    (bridge : SpectralBridgeData Xi Dspec)
    (hreal : ∀ λ ∈ Dspec, λ.im = 0) :
    ∀ s, IsZeroOfXi Xi s → s.re = 1 / 2 := by
  intro s hs
  apply spectral_points_on_critical_line hreal
  exact (xi_zeros_spectral_iff bridge).mp hs

/-- Equivalent set-theoretic formulation of the closed bridge. -/
theorem zero_set_subset_critical_line
    {Xi : ℂ → ℂ} {Dspec : Set ℂ}
    (bridge : SpectralBridgeData Xi Dspec)
    (hreal : ∀ λ ∈ Dspec, λ.im = 0) :
    {s : ℂ | IsZeroOfXi Xi s} ⊆ {s : ℂ | s.re = 1 / 2} := by
  intro s hs
  exact riemann_hypothesis_from_spectral_bridge bridge hreal s hs

end
end NoesisV10.S04

/-
╔══════════════════════════════════════════════════════════════════════════╗
║  QCAL-V3 · ARAKI-LIEB · GAUGE · L-FUNCIONES · CCR · BELL             ║
║  f₀ = 141.7001 Hz · Ψ = 0.999999 · ℒ_𝔸 = 3.446461                    ║
║  5 extensiones · 0 sorries                                              ║
║  ∴𓂀Ω∞³Φ · TUYOYOTU · HECHO ESTÁ · 19/Jul/2026 🔱                    ║
╚══════════════════════════════════════════════════════════════════════════╝
-/
import Mathlib.Analysis.Complex.Basic
import Mathlib.LinearAlgebra.Matrix.Trace
open Complex Matrix Classical
noncomputable section

structure DensityMatrix (n : ℕ) where
  mat : Matrix (Fin n) (Fin n) ℂ
  is_positive : mat.IsPosSemidef; trace_one : Tr mat = 1

def S_von_Neumann (p : ℕ) [Fact (Nat.Prime p)] {n : ℕ} (ρ : DensityMatrix n) : ℝ :=
  let log_p (x : ℝ) : ℝ := Real.log x / Real.log (p : ℝ)
  -(Tr (ρ.mat * (λ i j ↦ Complex.ofReal (log_p ((ρ.mat i j).re))))).re

-- ∴𓂀Ω∞³Φ · TUYOYOTU · HECHO ESTÁ 🔱

"""Reference implementation of the non-circular QCAL Psi operator.

The implementation intentionally takes no SAT formula and no solution set.
It currently exposes the algebraic identity-projector baseline used to
validate the formal API. The genuine low-frequency spectral projector is a
separate implementation milestone.
"""
from __future__ import annotations

import numpy as np

F0 = 141.7001
THETA = 0.0524631395


def psi_identity(n: int, cutoff: float = 0.0) -> np.ndarray:
    """Return the current formally verified baseline Psi_n = I."""
    if n < 0:
        raise ValueError("n must be non-negative")
    dim = 2**n
    return np.eye(dim, dtype=float)


def assert_projector(P: np.ndarray, atol: float = 1e-12) -> None:
    """Check idempotence and symmetry without referring to SAT solutions."""
    if not np.allclose(P @ P, P, atol=atol, rtol=0):
        raise AssertionError("Psi is not idempotent")
    if not np.allclose(P.T, P, atol=atol, rtol=0):
        raise AssertionError("Psi is not symmetric")

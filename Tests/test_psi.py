import numpy as np

from Python.psi_operator import F0, THETA, assert_projector, psi_identity


def test_constants():
    assert F0 == 141.7001
    assert THETA == 0.0524631395


def test_projector_properties():
    for n in range(0, 7):
        assert_projector(psi_identity(n))


def test_dimension():
    for n in range(0, 7):
        assert psi_identity(n).shape == (2**n, 2**n)


def test_no_solution_dependency():
    # API-level guard: Psi takes only n and cutoff.
    P = psi_identity(5, cutoff=1.0)
    assert np.array_equal(P, np.eye(32))

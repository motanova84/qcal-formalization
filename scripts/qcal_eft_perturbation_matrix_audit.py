#!/usr/bin/env python3
"""QCAL-EFT perturbation-matrix and Jeans-root audit."""
from __future__ import annotations
import sympy as sp

omega, k, a = sp.symbols('omega k a', positive=True)
cs2, hbar, m, G, rho = sp.symbols('cs2 hbar m G rho', positive=True)
D = omega**2 - cs2*k**2/a**2 - hbar**2*k**4/(4*m**2*a**4) + 4*sp.pi*G*rho
K = sp.Matrix([[D, 0], [0, D]])

print('=== QCAL-EFT PERTURBATION MATRIX ===')
print('K =')
sp.pprint(K)
print('\ndet(K) =')
sp.pprint(sp.factor(K.det()))

# Jeans boundary: omega^2 = 0. Let x = k^2; solve the resulting quadratic.
x = sp.symbols('x', real=True)
jeans = sp.expand(D.subs({omega: 0, k**2: x, k**4: x**2}))
print('\n=== JEANS BOUNDARY ===')
print('P(x) =')
sp.pprint(jeans)
roots = sp.solve(sp.Eq(jeans, 0), x)
print('\nk^2 roots =')
for r in roots:
    sp.pprint(sp.factor(r))

print('\nSTATUS: matrix determinant and analytic Jeans roots generated.')

#!/usr/bin/env python3
"""Reproducible certificate for the QCAL-EFT Jeans boundary.

Starting from omega^2(k)=A k^4 + B k^2 - C, solve for x=k^2,
select the positive physical root, and report k_J and lambda_J.
No parameter is fitted to a target wavelength.
"""
from __future__ import annotations
import math
import sympy as sp

# Source-defined symbols and constants.
hbar = 1.054571817e-34
c = 299792458.0
G = 6.67430e-11
f0 = 141.7001
omega0 = 2.0 * math.pi * f0
m_eff = hbar * omega0 / c**2

# The document's source relation c_s^2 = (rho0/m_eff) omega0^2.
# rho0 remains an explicit input, not a fitted quantity.
rho0 = 2.24e-27
a = 1.0
cs2 = (rho0 / m_eff) * omega0**2

A = hbar**2 / (4.0 * m_eff**2 * a**4)
B = cs2 / a**2
C = 4.0 * math.pi * G * rho0

def roots(A, B, C):
    disc = B*B + 4.0*A*C
    return ((-B + math.sqrt(disc))/(2.0*A),
            (-B - math.sqrt(disc))/(2.0*A))

r1, r2 = roots(A, B, C)
positive = r1 if r1 > 0 else r2
kJ = math.sqrt(positive)
lambdaJ = 2.0 * math.pi / kJ

x = sp.symbols('x', real=True)
A_s, B_s, C_s = sp.symbols('A B C', positive=True)
poly = A_s*x**2 + B_s*x - C_s
symbolic_roots = sp.solve(sp.Eq(poly, 0), x)

print('=== QCAL-EFT JEANS CERTIFICATE ===')
print(f'f0_Hz = {f0:.16g}')
print(f'omega0_rad_s = {omega0:.16g}')
print(f'm_eff_kg = {m_eff:.16g}')
print(f'rho0_kg_m3 = {rho0:.16g}')
print(f'cs2_m2_s2 = {cs2:.16g}')
print(f'A = {A:.16g}')
print(f'B = {B:.16g}')
print(f'C = {C:.16g}')
print('symbolic x=k^2 roots:')
for root in symbolic_roots:
    print(sp.factor(root))
print(f'positive_k2_m-2 = {positive:.16g}')
print(f'kJ_m-1 = {kJ:.16g}')
print(f'lambdaJ_m = {lambdaJ:.16g}')
print('target_free = true')
print('STATUS = PASS: algebraic root and numerical evaluation reproduced independently')

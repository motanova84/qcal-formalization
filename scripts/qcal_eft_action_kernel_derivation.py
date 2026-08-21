#!/usr/bin/env python3
"""Symbolic bridge: QCAL-EFT action -> quadratic scalar kernel.

The action terms are transcribed from the source document. The script expands
Psi = Psi0 + u + i v around a real background and extracts the quadratic
scalar Hessian. Background curvature and A_eff are kept explicit.
"""
from __future__ import annotations
import sympy as sp

psi0, u, v = sp.symbols('Psi0 u v', real=True)
zeta, R0, R1, R2 = sp.symbols('zeta R0 R1 R2', real=True)
c2, A0, A1, A2 = sp.symbols('c2 A0 A1 A2', real=True)
omega, k, a = sp.symbols('omega k a', nonzero=True, real=True)
U0, U1, U2 = sp.symbols('U0 U1 U2', real=True)

rho = psi0**2 + 2*psi0*u + u**2 + v**2
U = U0 + U1*(rho-psi0**2) + sp.Rational(1,2)*U2*(rho-psi0**2)**2
curv = zeta*(R0+R1+R2)*rho
gauge = sp.Rational(1,2)*c2*(A0+A1+A2)**2*rho

# Fourier-reduced derivative term for the scalar perturbation.
derivative = (omega**2-k**2/a**2)*(u**2+v**2)
lag = derivative - U - curv - gauge

eps = sp.symbols('eps', real=True)
scaled = lag.subs({u:eps*u, v:eps*v, R1:eps*R1, R2:eps**2*R2,
                   A1:eps*A1, A2:eps**2*A2})
quad = sp.expand(scaled).coeff(eps, 2)
scalar_quad = sp.expand(quad.subs({R1:0,R2:0,A1:0,A2:0}))
H = sp.hessian(scalar_quad, (u,v)).subs({u:0,v:0})/2

print('=== QCAL-EFT ACTION -> QUADRATIC KERNEL ===')
print('Quadratic scalar Lagrangian:')
print(sp.factor(scalar_quad))
print('\nScalar Hessian / 2:')
print(sp.Matrix(H).applyfunc(sp.factor))

# Source-defined sound-speed relation recorded as an identity to test.
rho0, m_eff, omega0, cs2 = sp.symbols('rho0 m_eff omega0 cs2', positive=True)
print('\nEq. 8.4 relation:')
print(sp.Eq(cs2, rho0/m_eff*omega0**2))

# Quantum-pressure coefficient used by the source dispersion equation.
hbar = sp.symbols('hbar', positive=True)
print('\nQuantum-pressure coefficient:')
print(sp.factor(hbar**2/(4*m_eff**2*a**4)))
print('\nSTATUS: symbolic action expansion generated; source-to-kernel assumptions remain explicit.')

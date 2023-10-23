import numpy as np
import scipy as sc
import sympy as sp

# Set amplitude and decay coefficient
A = 30
a = 5

# Declare Symbols
t,w = sp.symbols('t w', real = True, positive = True)

# Declare your function
f = A*sp.exp(-a*t)*sp.exp(-1j*w*t)

# integrate the function from 0 to infinity
fint = sp.integrate(f,(t,0,np.inf))

# Find the magnitudes at 0 and the decay coefficient
mag0 = sp.Abs(fint.subs(w,0))
angle0 = sp.arg(fint.subs(w,0))
maga = sp.Abs(fint.subs(w,a))
anglea = sp.arg(fint.subs(w,a))

print(f)
print(fint)
print(mag0)
print(angle0)
print(maga)
print(anglea)
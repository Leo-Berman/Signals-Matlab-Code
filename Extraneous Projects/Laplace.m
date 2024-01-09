syms s t
eqn = (19-exp(-s))/(s*(s^2+5*s+6));
A = ilaplace(eqn)*heaviside(t)
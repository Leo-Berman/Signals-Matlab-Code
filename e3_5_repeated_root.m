% e3_5_repeated_root.m
syms x(s) s X(s)

x(s) =(s^2+3*s+3)/(s+2)
dx = diff(x,s)

X(s) = x(s)/(s+3)^3

xt = ilaplace(X(s))
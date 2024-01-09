% e7_8_repeated_poles.m      
syms z n
X = 1/((z-1)*(z-3)^2)
x = iztrans(X)
xs = simplify(x)

X4 = z/(6*(z-3)^2)

x4 = iztrans(X4)
x4s = simplify(x4)

xseries = zeros(1,7);  % calculate the first few sequence values
for c = 1:7
    xseries(c) = subs(x4s,c-1);
end
xseries

% functions for Participation activity
X2d =(z-2)*(z+1)^2;
X2n = 9*z;
X2 = X2n/X2d

[R2 P2 K2] = residue(sym2poly(X2n),sym2poly(X2d))
x2 =iztrans(X2)
xs2 = simplify(x2)
x2series = zeros(1,7);  % calculate the first few sequence values
for c = 1:7
    x2series(c) = subs(xs2,c-1);
end
x2series

X3 = X2/z    % applying alternative method, this is X'
% answer too complicated, but matches sect 3.5 PA:  X2= (4*z^2 - 15*z -10)/((z+2)^3)
[R3 P3] = residue(sym2poly(X2n/z),sym2poly(X2d))

X3prime = diff(9/(z-2))
%x3 =iztrans(X3)
%xs3 = simplify(x3)
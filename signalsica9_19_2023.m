function [y] = BiTranSinSig(w,A)
syms t s theta
h=2*exp(-2*t)*heaviside(t);
H=subs(laplace(h),s,j*w);
x=A*cos(w*t+theta);
y=vpa(abs(H),2)*subs(x,theta,vpa(rad2deg(angle(H))))




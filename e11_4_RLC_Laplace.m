% file: e11_4_RLC_Laplace.m 
% Symbolic package: RLC circuit Laplace transform, step response, cos(t)u(t) response
clear; close all; set(0,'defaultAxesFontSize',13);
R=4; L=2; C=0.01; Vs = 2;  % component values.  Vs is a step function u(t)

syms s t 
H(s) = R/(s*L + R + 1/(s*C))
h_t = ilaplace(H)  % convert to time domain (impulse response) via inverse Laplace
H_ = laplace(h_t)  % confirm that h(t) is correct

V_o(s) = Vs/s * H(s)   % s-Domain output voltage (step response)
v_o_t = ilaplace(V_o)  % convert step response to time domain (via inverse Laplace)

figure('position',[100 100 600 250]), 
 subplot(1,2,1),fplot(h_t, [0,3]),grid on, title('h(t)'),xlabel('t (s)')  
 subplot(1,2,2),fplot(v_o_t,[0,3]),grid on, title('v_{step}(t)'),xlabel('t (s)'), 
 print -dpng 11_4_laplace.png  
 
% also try a cosine step input
v2(t) = 2*cos(3*t);
V_2(s) = laplace(v2)  % laplace() function assumes we mean cos(3*t) u(t)
V_2o(s) = V_2 * H(s)  % s-Domain output voltage (cosine response)
v2_o_t = ilaplace(V_2o)

figure('position',[100 400 600 250]), 
 subplot(1,2,1),fplot(v2, [0,5]),grid on, title('v_2(t) = 2cos(3t) u(t)'),xlabel('t (s)');  
 subplot(1,2,2),fplot(v2_o_t,[0,5]),grid on, title('v_{2_{out}}(t)'),xlabel('t (s)')
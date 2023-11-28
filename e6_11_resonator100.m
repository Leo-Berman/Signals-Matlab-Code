% e6_11_resonator100.m   % Resonator filter transfer function and impulse response
clear; close all; set(0,'defaultAxesFontSize',14);
f=[0:0.01:600];
w=j*2*pi*f;
a=25;                         % value determined by trial and error to keep |h(0.5)|<0.001
Z=j*2*pi*[-500:100:500];      % Eleven zeros at 100 Hz intervals
P=Z-a;
N=poly(Z);D=poly(P);
H=1- polyval(N,w)./polyval(D,w);  % resonator transfer func is 1- H_comb
[R1 P1]=residue(N,D)
t=[0.44: 0.001: 0.55];        % plot only short window of h(t), as h(0) = 275
h=-real(R1.' *exp(P1*t));  % impulse response is sum of residues times e^(-poles)
subplot(121),plot(f,abs(H)),grid on, title('|H(f)|'), 
subplot(122),plot(t,h),grid on,title('impulse response h(t)')
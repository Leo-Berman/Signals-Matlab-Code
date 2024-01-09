% file: e11_4_RLC_Laplace_residues.m  
%RLC circuit H(s) transfer function, Laplace transform via residues
clear; close all; set(0,'defaultAxesFontSize',13);
%R1=4; L=2; C=0.01; % component values.  
%H(s) = R1/(s*L + R1 + 1/(s*C)) = R1s/(Ls^2 + R1s + 1/C) = (4s+0)/(2s^2+4s+100)
[R P]= residue ([4,0], [2,4,100])
%Y_Step(s) = H(s)*1/s= R/(Ls^2 + Rs + 1/C) = 4/(2s^2+4s+100)
[Rstep P]= residue ([4], [2,4,100]) % poles are same as impulse response
Ts=0.01; T=5; t=[0:Ts:T];  % plot 5 secs of impulse, step response
h=real(R.'*exp(P*t)); figure, plot(t,h),title('h(t)'),grid on
y_step=real(Rstep.'*exp(P*t)); figure, plot(t,y_step),title('y_{step}(t)'), grid on

% Bandpass RLC frequency response:
sysbp = tf([4], [2,4,100])
syms s t

H2 = 4*s/(2*s^2+4*s+100)
h2 = ilaplace(H2)

%2nd order lowpass, same components, output is capacitor voltage
%H_lp(s) = 1/(s*C)/(s*L + R + 1/(s*C)) = 1/(LCs^2 + RCs + 1) = 1/(0.02s^2+0.04s+1)
%Y_Step(s) = H(s)*1/s= 1/(0.02s^3+0.04s^2+ s +0)
[R_lp P_lp]= residue([1], [0.02,0.04,1])
[R_lp_step P_lp_step]= residue([1], [0.02,0.04,1,0])

h_lp=real(R_lp.'*exp(P_lp*t)); 
figure, fplot(h_lp), grid on, title('fplot() h_{lp}(t)')
y_step_lp=real(R_lp_step.'*exp(P_lp_step*t)); 
figure, fplot(y_step_lp), grid on, title('fplot() y_{Steplp}(t)')

% Lowpass RLC frequency response:
sys = tf([1],[0.02,0.04,1])
figure, bode(sys,[1:1:1000]), grid on
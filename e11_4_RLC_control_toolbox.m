% file: e11_4_RLC_control_toolbox.m   
% RLC circuit: frequency and step responses via Control System Toolbox
clear; close all; set(0,'defaultAxesFontSize',13);
R=4; L=2; C=0.01;               % component values 
% H(s) = R/(L*s + R + 1/(s*C))  % bandpass filter transfer function
N=[R 0]; D =[L R 1/C];          % numerator, denom coefficients of H(s) after multiplying by s/s
sys = tf(N, D)                  % tf() creates an s-domain transfer function
figure('position',[10 100 600 250]), 
   subplot(1,2,1), impulse(sys),grid on,
   subplot(1,2,2), step(sys),grid on,
figure('position',[600 100 300 400]), bode(sys),grid on 
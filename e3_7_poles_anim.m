% file: e3_7_poles_anim.m  Laplace for RC lowpass with u(t) and exp(-t) input   
clear; close all; fpv =[100, 100, 850, 180]; set(0,'defaultAxesFontSize',13);
syms s t %a   % make 'a' symbol if you want the printed equations in terms of 'a'
a = -1;
vi(t) = exp(-t)* heaviside(t)   % heaviside(t) is step function u(t)
Vi(s) = laplace(vi)
Vo(s) = Vi/(s+a) 
%Vo(s) = 1/(s+1) * a/(s^2 + a^2) % sanity-check of MATLAB's laplace() 
vo=ilaplace(Vo)* heaviside(t)    % heaviside needed here due to MATLAB "feature"
figure('position',fpv),
 subplot (1,2,1),fplot(vi,'g','linewidth',2),axis([-2,4,-1,4]),grid on,title('v_i(t)'),
 subplot (1,2,2),fplot(vo,'r','linewidth',2),axis([-2,4,-1,4]),grid on,title('v_o(t)')


%file: LV2_1.m             convolution of two decaying exponentials
clear; close all; set(0,'defaultAxesFontSize',13); fpv=[100 100 800 250];
decay1 = 10, decay2 = 1  % vary these decay rates (exponent coefficients)
s = 1e-3;                % time step size
Tmax = 5;  Tm2= 2*Tmax;  % time limits
t = [0:s:Tmax];          % vector of times
h = exp(-decay1*t);      % h(t) = e^{-decay1*t)
x = exp(-decay2*t);      % x(t) = e^{-decay2*t)

y_n = conv(h,x)*s;       % numerical convolution (result length is 2*Tmax)
t_a = [0:s:Tm2];         % analytical convolution time range
% analytical convolution using "commonly encountered convolutions" table #3
y_a = 1/(decay2-decay1)*(exp(-decay1*t_a) - exp(-decay2*t_a));

figure('position',fpv), 
  subplot(1,2,1), plot(t_a,y_a), grid on, title('Convolution (analytic)'),
  subplot(1,2,2), plot(t_a,y_n,'r'), grid on, title('Convolution (numeric)')
figure, plot(t,h, t,x),grid on, title('Signals')
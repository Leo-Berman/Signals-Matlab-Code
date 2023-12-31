% file: e5_10_dirlichet2.m  % Plot discontinuous and infinite-count-maxima signals
clear; close all; set(0,'defaultAxesFontSize',14);

T0 = 1;
t1 = [0:0.001:T0];
x1 = 1./(T0/2 - t1);      % signal with discontinuity
figure, plot(t1,x1, 'r', 'Linewidth', 1.5), title('x(t) = 1/(T_0/2 - t)'), grid on,
  xticks(0:0.25:1);

T0 = 0.1;
t = [-T0/2:0.00001:T0/2];
x2 = sin(1./t);           % signal with infinitely many maxima
figure, plot(t,x2), title('x(t) = sin(1/t)');
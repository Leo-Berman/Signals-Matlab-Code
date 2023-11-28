% file: e6_5_lowpass_impulse_resp2.m   
clear; close all; set(0,'defaultAxesFontSize',15); fpv=[100,100,1800,300];
%syms f t
t=linspace(-2*pi, 2*pi, 200);
fc = 1;  % bandwidth=fc
h = sin(2*pi*fc*t)./(pi*t);
u = [zeros(1,100), ones(1,100)]; % unit step function u(t)
ystep = conv(h,u,'same');  %convolution of h(t) and u(t) 
%ystep = conv(h,u,'valid');  %convolution of h(t) and u(t)
figure('position',fpv),
 subplot(1,2,1), plot(t,h,'r','LineWidth',2),title('h_{LP}(t)'),
 subplot(1,2,2), plot(t,ystep,'b','LineWidth',2),title('y_{step}(t)')
 
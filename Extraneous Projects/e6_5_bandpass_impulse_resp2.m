% file: e6_5_bandpass_impulse_resp2.m   
clear; close all; set(0,'defaultAxesFontSize',15); fpv=[100,100,1000,300];
fc = 1; f0 = 3;  % bandwidth=2*fc=2 Hz, carrier (center freq) = f0 = 3 Hz
t=linspace(-1,1,200);
h = 2*sin(2*pi*fc*t)./(pi*t) .* cos(2*pi*f0*t);
figure('position',fpv),
 plot(t,h,'r','LineWidth',2),grid(gca,'minor'),title('h_{BP}(t)')
 
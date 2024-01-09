% e6_13_modulated_spectra.m
clear; close all; set(0,'defaultAxesFontSize',13); 
set(0, 'defaultFigurePosition',[100,100,600,200]);
n = 1;  % number of seconds
s = 6;  % samples/sec
P = 200; % point count
t= linspace(-n, n, P);  % times for continuous signal
ts = [-n: 1/s :n]; % times for sampled signal

x = sin(2*pi*t).*(1+2*cos(4*pi*t))./(pi*t);
xsamp = sin(2*pi*ts).*(1+2*cos(4*pi*ts))./(pi*ts);

figure, 
  plot(t,x, 'linewidth',2), grid on;
figure, hold on,
  plot(t,x, 'linewidth',2), grid on,
  stem(ts, xsamp, 'filled', 'r'),
  hold off;
X = fftshift(fft(x));  % plot approximate freq spectra
figure, plot(abs(X)/length(X)), grid on, title('X(f)')

Xsamp = fftshift(fft(xsamp));
figure, plot(abs(Xsamp)/length(Xsamp)), grid on, title('X_s(f)')
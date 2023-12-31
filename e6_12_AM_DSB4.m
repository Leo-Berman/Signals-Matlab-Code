% e6_12_AM_DSB4.m   % 1kHz cosine x(t) = 2cos(2000?t) modulated by 50kHz carriers, both AM and DSB.
clear; close all; set(0,'defaultAxesFontSize',13);
w=2000*pi;
A = 2;
maxtime = 0.002; n =2000;     % n = number of points to plot
t = linspace(0, maxtime, n);  % time range for cosines
 
x = A*cos(w*t);
c = cos(50*w*t);  % carrier wave
ydsb = x.*c;      % DSB modulated
yam = (A+x).*c;   % AM modulated

numpeaks = round(maxtime*50*w/(2*pi));   % number of carrier peaks, for envelope detector
t_env = linspace(0, 0.002, numpeaks);    % time range for envelope detector, to emulate LP filtering
peak_interval = n/numpeaks;
env_dsb = abs(ydsb(1:peak_interval:end)); % envelope detectors
env_am = abs(yam(1:peak_interval:end)); % envelope detectors

figure, plot(ydsb), grid on, title('DSB');
figure, plot(yam), grid on, title('AM');
figure, plot(t, ydsb, t_env, env_dsb,'r'), grid on, title('DSB with envelope');
figure, plot(t, yam, t_env, env_am,'r'), grid on, title('AM with envelope');

am_spectrum = abs(fftshift(fft(yam)))/n;
figure, plot(am_spectrum(800:1200)),grid on, title('X_{AM}(f)');

dsb_spectrum = abs(fftshift(fft(ydsb)))/n;
figure, plot(dsb_spectrum(800:1200)),grid on, title('X_{DSB}(f)');
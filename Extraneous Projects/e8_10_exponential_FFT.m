%  file:  e8_10_exponential_FFT.m    
%  equivalent of Labview module 8_10a, calculate and plot time/freq
% for 2-sided exponential, analytically and via FFT
clear; close all; fpv = [0 300 900 700]; 
set(0,'defaultAxesFontSize',13,'DefaultAxesXGrid','on','DefaultAxesYGrid','on'); 
set(0,'DefaultStemLineWidth',1.5); 
tmax = 5; fmax =2;
T=2*tmax;  B=2*fmax;
t=[-tmax:1/B:tmax-1/B];
f=[-fmax:1/T:fmax-1/T];
X=exp(-abs(t));              % time-domain signal, for sampled plot (stem plots in blue)
FX=fftshift(abs(fft(X)))/B;  % FFT (stem plots in blue)

t2 = linspace(t(1), t(end), 2000);  % times for high-res continuous time-domain plot (red lines)
X2 = exp(-abs(t2));
f2 = linspace(f(1), f(end), 2000);  % freqs for continuous freq-domain plot (red lines)
fX2=2./(4*pi*pi*f2.*f2+1);   % analytically-derived Fourier transform for continuous plot

figure, hold on, 
  stem(f,FX,'b'),title('Frequency domain |X[k]|')%,axis tight
  plot(f2,fX2,'r'), hold off;
figure, hold on, 
  stem(t,X,'b'),title('Time domain x[n]')%,axis tight
  plot(t2,X2,'r'), hold off;
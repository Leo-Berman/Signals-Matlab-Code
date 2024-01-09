% file:  e8_10_Gaussian_FFT.m      
% Calculate and plot time/freq
% for 2-sided Gaussian exponential, analytically and via FFT
clear; close all; fpv = [0 300 300 200]; 
set(0,'defaultAxesFontSize',14,'DefaultAxesXGrid','on','DefaultAxesYGrid','on'); 
set(0,'DefaultStemLineWidth',1); 
tmax = sqrt(-18*log(0.01))   % approx 9.105
fmax = 0.4942/2 
Td=2*tmax,  Bb=2*fmax
t=[-tmax:1/Bb:tmax];
%t=[-tmax:2.5:tmax];   % override calculated values to N0 = 8, T_s=2.5 sec for stem plot #1
f=[-fmax:1/Td:fmax];
X=exp(-t.^2/18);              % time-domain signal, for sampled plot (stem plots in blue)
FX=fftshift(abs(fft(X)))/Bb;  % FFT (stem plots in blue)

t2 = linspace(t(1),t(end),2000); % times for high-res continuous time plot (red lines)
X2 = exp(-t2.^2/18);
f2 = linspace(f(1),f(end),2000); % freqs for continuous freq-domain plot (red lines)
FXa= 3*sqrt(2*pi)*exp(-18*pi^2*f2.^2); % analytical Fourier transform for continuous plot

n = [-4:4]; Xk = zeros(1,9);     % for Fourier spectral components
for k = -4:4
  exponent = -2.*n.*(n+j*pi*k)/9;
  Xk(k+5)= 2*sum(exp(exponent))  % calculate Fourier spectral components
end

figure('position',fpv*2),     % plot analytical continuous time x(t) and |X(f)|
  subplot(1,2,1),plot(t2,X2,'r'),xticks(-8:2:8),yticks(0:0.2:1),title('x(t)'), axis tight,
  subplot(1,2,2),plot(f2,FXa,'r'),yticks(0:2:8),title('|X(f)|')%,axis tight
  
figure('position',fpv), hold on, 
  stem(t,X,'b'),xticks(-8:2:8),title('Time domain x[n]'),
  plot(t2,X2,'r'),yticks([0:0.2:1]), hold off;
  
f_offset = 1/(2*Td)           % align sampled plot with continuous 
figure('position',fpv), hold on, 
  stem(f+f_offset,FX,'b'),title('Frequency domain |X[k]|'),
  plot(f2,FXa,'r'),yticks([0:2:8]), hold off;
  
figure('position',fpv), hold on, % plot Xk components atop continuous FT 
  stem(n,abs(Xk),'b'),title('FT spectral components |X_k|'),
  plot(Td*f2,FXa,'r'),yticks([0:2:8]),xticks(-4:4),hold off;
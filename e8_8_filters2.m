% file = e8_8_filters2.m, FFT brickwall lowpass/highpass filters   
% time and frequency spectra plots for dc + 2 cosines,

clear; close all; fpv = [0 300 600 250]; 
set(0,'defaultAxesFontSize',13,'DefaultAxesXGrid','on','DefaultAxesYGrid','on'); 

f = 1000; f3 =3200;    % example signal cosine frequencies
f_c = 3000;            % filter cutoff freq
f_s = 8192;            % sample rate, samples/sec (Hz)
L = 1024;              % total number of sample points and length of FFT
ns = [0:1:L-1];        % array of sample indices
t = [0:0.02:L-1];      % higher resolution array for continuous-time plot

x = 1 + cos(2*pi*f*t/f_s) + 2*cos(2*pi*f3*t/f_s);     % continuous-time signal
xs = 1 + cos(2*pi*f*ns/f_s)+ 2*cos(2*pi*f3*ns/f_s);   % sampled signal
% plot continuous-time signal overlaid with sampled signal
figure('position', fpv);  hold on; 
  plot(t(1:1000),x(1:1000),'r'); 
  stem(ns(1:20),xs(1:20),'filled','b','Linewidth',1.5); hold off; 
fx = fft(xs); % fx = fftshift(fx); 
figure('position', fpv), stem(ns,abs(fx/length(fx)),'.r','LineWidth',1.5),axis tight,
title('|X(\Omega)|'),yticks([0:0.2:3]) %  length(fx)to get proper magnitude
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LowPass filter in freq domain (zero out fft frequency values >= f_c, at index K)
K = ceil(L*f_c/f_s)+1  % the "+1" compensates for array indices, which start at 1, not 0
X_LP = fx; 
X_LP(K:end-K+1) = 0;  % zero all frequency components above F/S Hz, which actually
                      % are in the middle of the FFT data array 
figure('position', fpv),axis tight, % plot FFT 
 stem(ns,abs(X_LP/length(fx)),'.r','LineWidth',1.5),axis tight,    
  yticks([0:0.2:2]),xlabel('Frequency'); title('Lowpass filtered |X(\Omega)|')
x_LP = real(ifft((X_LP)));    % transform back to time domain and plot
figure('position',fpv),stem([0:25],x_LP(1:26),'r'); title('Lowpass filtered x[n]'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HighPass filter in freq domain (zero out fft frequency values <= f_c)
X_HP = fx; 
X_HP(1:K)= 0;         % zero frequencies at and below f_c Hz, which 
X_HP(end-K+2:end)= 0;   %  are at start and end of FFT data array 

figure('position', fpv),axis tight, % plot FFT 
 stem(ns,abs(X_HP/length(fx)), '.r', 'LineWidth', 1.5),     
 yticks([0:0.2:2]), xlabel('Frequency'),axis tight,title('Highpass filtered |X(\Omega)|')

x_HP = real(ifft(X_HP));   % transform back to time domain and plot
figure('position',fpv),stem([0:25],x_HP(1:26),'r'); title('Highpass filtered x[n]'); 
%file: e9_1_anim_cos_Hamming.m  Cosine signal spectra, rectangular & Hamming windows
clear; close all; set(0,'defaultAxesFontSize', 12);
N=512;                        % FFT order (number of points)
n1=[0:24]; LN=length(n1);     % the sample indices
K=[0:N/2-1]; W=2*pi*K/N;      % frequency scale for spectra
X=cos(0.2*pi*n1);

FX=abs(fft(X,N))/LN;          % rectangle window: no coefficients
H=0.54-0.46*cos(2*pi*n1/(LN-1));  % Hamming window
Y=X.*H;FY=abs(fft(Y,N))/LN;   % apply Hamming window, get FFT
 
figure('position',[100,100,500,800]),    % plot input x[n] and windows and FFTs
 subplot(511), stem(n1,X, 'filled'),axis tight
 subplot(512),plot(W,FX(K+1),'Linewidth',3),axis tight, % FFT of rect window
 subplot(513),stem(n1,H,'r','filled'),axis tight,       % time plot Hamming window 
 subplot(514),stem(n1,Y,'r','filled'),axis tight,       % Hamming window times x[n]
 subplot(515),plot(W,FY(K+1),'Linewidth',3),axis tight
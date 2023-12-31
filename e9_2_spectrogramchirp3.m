% file: e9_2_spectrogramchirp3.m   
% Spectrogram of chirp signal x(t)=cos(t^2), with A=1, alpha=1, Tau=81.91 sec, 100 samples/sec
clear; close all; set(0,'defaultAxesFontSize',14); set(0,'defaultLineLineWidth',1); 
LX = 8191; N = 32; L=floor((LX+1)/N);   % LX = length of chirp signal (minus 1)
X=cos([0:LX].*[0:LX]/10000);            % generate LX+1 samples of increasing-frequency chirp
T=linspace(0,19.99,2000);
figure,subplot(211),plot(T,X(1:2000)) % plot first 20 seconds of chirp signal in time domain
FXX=abs(fft(reshape(X(1:L*N),L,N)));  % partition to N intervals of L samples each, then FFT
FXX=FXX(180:256,:);                   % eliminate extra mirror-image copy of spectrum, and unused freqs
figure,imagesc(log(FXX)),colormap(jet)
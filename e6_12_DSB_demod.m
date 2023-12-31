% file: e6_12_DSB_demod.m
% demodulate p661.mat, which contains variable S, the sum of two DSB-modulated signals, 
% modulated at different carrier frequencies (one is 10kHz, other 20 kHz), and sampled @ 20us. 
clear; close all;
load p661.mat % data samples in  array S, length 50000
L = length(S); Lm1=L-1; 
f1 = 10000; f2=20000; f5= 5000; % f5 is 5000 kHz limit for FFT filtering
% demodulate by multiplying with carrier frequency
Hallel=S.*cos(2*pi*f1*[0:Lm1]/L);
Train=S.*cos(2*pi*f2*[0:Lm1]/L);

soundsc(Hallel,L),pause(2),soundsc(Train,L);

% These sound  better if lowpass filtered to eliminate freq >5 kHz using:
FHallel=fft(Hallel);FHallel(f5:L-f5)=0;  % brickwall lowpass on FFT data
FTrain=fft(Train);  FTrain(f5:L-f5)=0;
pause(3);
IHallel=real(ifft(FHallel));  % transform back to time domain
ITrain=real(ifft(FTrain)); %using abs() instead of real() messes up the sounds

soundsc(IHallel,L),pause(2),soundsc(ITrain,L);
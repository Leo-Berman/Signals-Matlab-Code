% file: e6_13_sound_alaised2.m
clear; close all; set(0,'defaultAxesFontSize',13);
load P673.mat;   % contains array X with speech signal sampled at 24k samp/s
soundsc(X,24000); % play at 24k samp/sec

% display lower 8 kHz of freqency spectrum
N=length(X)/3; 
F=linspace(0,8000,N); 
FX=abs(fft(X)); 
figure, plot(F,FX(1:N)), grid on, axis tight, title('X(f) sampled at 24000 samp/s');

pause(3);
% Reduce sample rate to 3000 samples/s, by keeping only every eighth sample
Y=X(1:8:end); soundsc(Y,3000);

% display 1.5 kHz of freqency spectrum
N=length(Y)/2; 
F3=linspace(0,1500,N); 
FY=8*abs(fft(Y)); 
figure, plot(F3,FY(1:N)), grid on, axis tight, title('Y(f) sampled at 3000 samp/s');

% display 3 kHz of freqency spectrum
N=length(Y); 
F3=linspace(0,3000,N); 
FY=8*abs(fft(Y)); 
figure, plot(F3,FY(1:N)), grid on, axis tight, title('Y(f) sampled at 3000 samp/s');


% file:  e9_12_autocorr3.m   Generate stems for various signals and correlations
%X = [1 2 3];
%X = [1 1 1 1];
clear; close all; set(0,'defaultAxesFontSize',14); fpv = [0 100 400 200];
X = [0 1 0 0 2 0 1 0 0 2]; % 0 1 0 0 2];  % periodic signal, T=5
noise = [-1 -0.4 0.4 0.7 -0.2 -0.6 -0.8 -0.5 0.3 0.7]; % 0 -0.8 0.5 0.9 -1];  % noise signal

Xn = X+noise;  % noisy periodic signal, T=5
%X = [0 1 0 2 0 1 0 2 0 1 0 2];  % periodic signal, T=5
 %Y= [2 7 1 2 7 1];
%Y= [2 7 1];
% X = [1 2 3 1 2 3 1 2 3 1 2 3];
 Y = [1-i 1+i -1-i -1];
%X = [2 2 2 2 2];
%N=length(X);  M=2*N-1  %M = length of autocorr result
%RX=real(ifft(abs(fft(X,M)).^2));
%RX=fftshift(RX) % puts rx (0) in the middle.
RXX = conv(X,conj(fliplr(X)))
RXn = conv(Xn,conj(fliplr(Xn)))
Rn = conv(noise,conj(fliplr(noise)))
RYY = conv(Y,conj(fliplr(Y)))

RXY = conv(X,conj(fliplr(Y)))
RXY2 = xcorr(X,Y)

figure('position', fpv); stem([0:1:length(X)-1],X, 'r'); ylabel('x[n]');
figure('position', fpv); stem([0:1:length(Xn)-1],noise, 'b'); ylabel('noise[n]');
figure('position', fpv); stem([0:1:length(Xn)-1],Xn, 'm'); ylabel('x_{noisy}[n]');
%figure('position', fpv); stem([0:1:length(Y)-1],Y, 'b'); ylabel('y[n]');

%figure('position', fpv); stem([0:1:length(RXY)-1],RXY, 'r'); ylabel('r_{xy}[n]');
RXX_axis = [-ceil(length(RXX)/2)+1:1:ceil(length(RXX)/2)-1]
figure('position', fpv); stem(RXX_axis,RXX, 'r'); ylabel('r_x[n]');
figure('position', fpv); stem(RXX_axis,Rn, 'r'); ylabel('r_{noise}[n]');
figure('position', fpv); stem(RXX_axis,RXn, 'r'); ylabel('r_{xnoisy}[n]');
%figure('position', fpv); stem([0:1:length(RYY)-1],RYY, 'r'); ylabel('r_y');

%M=length([X Y]) - 1;                          % M = length of corr result
%RXY1=real(ifft((fft(X,M)).*conj(fft(Y,M))));    
%RXY1=fftshift(RXY1)                             % fftshift() puts r_{xy}(0) in the middle.

%RYX = conv(Y,conj(fliplr(X)))


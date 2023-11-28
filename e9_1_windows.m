% file: e9_1_windows.m 
% Example: Resolving two closely-spaced sinusoids, using various window types and lengths.
% Requires MATLAB signal processing toolbox for hamming() function
clear; close all; set(0,'defaultAxesfontsize',13);

L=125;N=512;       % 1st case, with short lengths and rectangular window
X=cos(0.3*pi*[0:L-1])+cos(0.31*pi*[0:L-1]);  % the signal, 2 closely-spaced cosines
FX=abs(fft(X,N))/L;
K=[1:N/2];W=(K-1)*2*pi/N;
figure, plot(W,FX(K)),axis tight, ylabel('L=125, N=512, W_{Rect}')

L=125;N=1024;      % 2nd case, with doubled FFT dataset and rectangular window
FX=abs(fft(X,N))/L;
K=[1:N/2];W=(K-1)*2*pi/N;
figure, plot(W,FX(K)),axis tight, ylabel('L=125, N=1024, W_{Rect}')

L=140;N=512;        % 3rd case, with slightly longer rectangular window
X=cos(0.3*pi*[0:L-1])+cos(0.31*pi*[0:L-1]);  % repeat formula with new length L
FX=abs(fft(X,N))/L;
K=[1:N/2];W=(K-1)*2*pi/N;
figure, plot(W,FX(K)),axis tight, ylabel('L=140, N=512, W_{Rect}')

L=140;N=512;        % 4th case, with Hamming window
Xh=X.*hamming(L)';  % hamming() function is in MATLAB signal processing toolbox
FX=abs(fft(Xh,N))/L;
K=[1:N/2];W=(K-1)*2*pi/N;
figure, plot(W,FX(K)),axis tight, ylabel('L=140, N=512, W_{Hamming}')


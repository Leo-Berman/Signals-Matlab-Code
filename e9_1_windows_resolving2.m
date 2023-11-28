% file: e9_1_windows_resolving2.m 
% Example: Resolving two closely-spaced sinusoids, using various window types and lengths.
clear; close all; set(0,'defaultAxesfontsize',13); 
 set(0, 'defaultFigurePosition',[100,100,600,300]);
w1 = 0.3, w2=0.31  % two closely spaced frequencies
L=125;N=512;       % 1st case, with short lengths and rectangular window
X=cos(w1*pi*[0:L-1])+cos(w2*pi*[0:L-1]);  % the signal, 2 closely-spaced cosines
FX=abs(fft(X,N))/L;
K=[1:N/2];W=(K-1)*2*pi/N;
figure, plot(W,FX(K),'r'),axis tight,grid, ylabel('L=125, N=512, W_{Rect}')

L=125;N=1024;      % 2nd case, with doubled FFT dataset and rectangular window
FX=abs(fft(X,N))/L;
K=[1:N/2];W=(K-1)*2*pi/N;
figure, plot(W,FX(K),'r'),axis tight,grid, ylabel('L=125, N=1024, W_{Rect}')

L=140;N=512;        % 3rd case, with slightly longer rectangular window
X=cos(w1*pi*[0:L-1])+cos(w2*pi*[0:L-1]);  % repeat formula with new length L
FX=abs(fft(X,N))/L;
K=[1:N/2];W=(K-1)*2*pi/N;
figure, plot(W,FX(K),'r'),axis tight,grid, ylabel('L=140, N=512, W_{Rect}')

L=140;N=512;        % 4th case, with Hamming window
X=cos(w1*pi*[0:L-1])+cos(w2*pi*[0:L-1]);  % repeat formula with new length L
h = 0.54-0.46*cos(2*pi*[0:L-1]/(L-1));    % Hamming window values
Xh=X.*h;                                  % apply Hamming window
FX=abs(fft(Xh,N))/L;
K=[1:N/2];W=(K-1)*2*pi/N;
figure, plot(W,FX(K),'r'),axis tight,grid, ylabel('L=140, N=512, W_{Hamming}')

figure,hold,plot(X),axis tight,grid, title('x[n] and w_{Hamming}'),
  plot(h),axis tight,grid,hold off
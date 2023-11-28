% file: e9_6_cosine_downsampled_aliased3  time and frequency plots for cosine and downsampled-by-L cosine     
% downsample cos(0.5pi n) by factor L=3
% demonstrates aliasing of downsampling a signal that already is nearly undersampled
% The 0.5pi frequency downsamples to 0.5*pi*3 = 1.5pi, but replica of the
%  spectrum occurs at 1.5pi-2pi = -0.5pi = 0.5pi, the same as original signal
clear; close all; set(0,'defaultAxesFontSize',13);
L = 3;                 % downsampling (decimation) factor
N = 4;                 % N = 2*pi/W_0 = 4 samples per cycle
Nf = 30; Nfft=128;     % longer fft length improves resolution; x[n] is a pulse 30 samples=7.5 cycles long

nf = [0:1:Nf-1];  nfft=[0:1:Nfft-1];    
xf = cos(2*pi/N*nf);   % sampled signal

% plot continuous-time cosine overlaid with 4 samples/cycle
t = [0:0.2:Nf-1];      % 7.5 cycles of 100 Hz cosine = 75 msec
x = cos(2*pi/N*t);
figure, subplot (2,1,1); plot(t,x,'m'),
 subplot (2,1,2), hold on, plot(t,x,'m'), stem(nf,xf); hold off;

yf = xf(1:L:end);                 % y is x downsampled by factor L
ny = nf(1:L:end);
figure; subplot(2,1,1); stem(xf); subplot(2,1,2); stem(yf,'r');
Hx = ones(1,Nf);  %Hx = 0.54-0.46*cos(2*pi*[0:Nf-1]/(Nf-1));  % Rectangular or Hamming windows
Hy = ones(1,Nf/L);%Hy = 0.54-0.46*cos(2*pi*[0:Nf/L-1]/(Nf/L-1));

w = linspace(0,2*pi,Nfft);        % frequency omega range (0 to 2pi)
% calculate ffts (DFT)
fx = fft(xf.*Hx,Nfft); Fx = fftshift(fx);  % fftshift(): show plot with freq 0 in center
fy = fft(yf.*Hy,Nfft); Fy = fftshift(fy);  % using Hamming windows to reduce sidelobes
 
figure; hold on; axis tight;
 plot(w-pi,abs(Fx/Nf), 'LineWidth', 2), % scale ffts by sample count Nf to get proper magnitude 
 plot(w-pi,abs(Fy/Nf), 'LineWidth', 2), xlabel('Frequency'); ylabel('Magnitude')

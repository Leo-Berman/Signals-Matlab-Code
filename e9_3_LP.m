% file: e9_3_LP.m  % brickwall discrete lowpass filter, Hamming windowed
clear; close all; set(0,'defaultAxesFontSize',13);
L = 5;      % impulse response is of length 2*L+1, noncausal
fc = 250;    % corner (cutoff) frequency (actually is where |H(f)|=0.5, not 0.707)
S = 1000;    % sampling rate
Lw = 256;    % window length for FFT
n = [-L:L];
h = sin(2*pi*fc/S*n)./(n*pi);   % set impulse response to sinc
h(L+1) = 2*fc/S;                % force middle n=0 value of sinc (instead of 0/0)
%h = h.*(0.54+0.46*cos(pi*n/L)); % multiply impulse response by Hamming window
f = S*[0:Lw/2-1]/Lw;            % frequencies for plot
FH = fft(h, Lw);                % get spectrum via FFT
FH = abs(FH(1:Lw/2));           % one-sided spectrum

subplot(2,1,1), plot(f,FH,'r', 'linewidth',2),%grid minor,title('Frequency response |H(f)|'),xlabel('f (Hz)')
subplot(2,1,2), stem(n,h)%,grid minor,title('Impulse response h[n]'),xlabel('n')
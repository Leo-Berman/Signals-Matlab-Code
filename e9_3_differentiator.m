% file: e9_3_differentiator.m
%  Differentiator, with 5-point hamming window, 5-point rectangular, and 21-point rectangular
clear; close all; set(0,'defaultAxesFontSize',13);
n = linspace(-10,10, 21);
H = ((-1).^n)./n;  %impulse response of differentiator, graphed for 21 points, -10 to 10
H(11)=0  % impulse response value is 0 at n=0 (formula above would make it infinite)
figure; stem(H, 'Linewidth', 2)

Hm = [-0.04 0.54 0 -0.54 0.04];  % 5-point hamming window times impulse response
figure; stem(Hm, 'Linewidth', 2) %  plot Hamming times impulse response
Fx = fft(Hm);  % does not look much like a differentiator frequency spectrum
figure; plot(abs(Fx),'r')

FH = fft(H);  %freq spectrum of original impulse response, with 21 points, does look like H(jw) = w
figure; plot(abs(FH),'r')

Hr = H(9:13); % 5-point rectangular window on original impulse response
Fr = fft(Hr)
figure; plot(abs(Fr))

% Triangle wave input, see how close output is to squarewave
% See https://www.mathworks.com/help/signal/ref/sawtooth.html  

% Generate 2 periods of a triangle wave, 50 Hz. Sample rate is 500 Hz. 
%%%%%%%%%%%%%%%%%%%%%% Uncomment the following line if using Octave:
% pkg load signal    % sawtooth function is in signal processing package
T = 2*(1/50);
fs = 500;
t = 0:1/fs:T-1/fs;
x = sawtooth(2*pi*50*t,1/2);
figure; stem(x, 'Linewidth', 2) %  plot input sawtooth

y = conv(x, H); %output of differentiator with rectangular window of length 21
figure; stem(y, 'Linewidth',2) %looks somewhat like squarewave

yr = conv(x,Hr); %output of differentiator with rectangular window of length 5
figure; stem(yr, 'Linewidth',2) %looks like differentiator output that should occur with squarewave input

ym = conv(x,Hm); %output of differentiator with Hamming window of length 5
figure; stem(ym, 'Linewidth',2) %looks like differentiator output that should occur with squarewave input
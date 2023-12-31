% file: e6_7_tri_resonator.m  % Resonator filter to eliminate noise from triangle wave
% GOAL: Reject triangle#1, keep triangle#2 
% Triangle period 0.02->harmonics k*50 Hertz, k odd
% Sample=10000/second. Duration=1 second.
clear; close all; set(0,'defaultAxesFontSize',13); 

T=[[-50:49]'*ones(1,50);[50:-1:-49]'*ones(1,50)]/50; T=T(:); % Triangle wave
LT = length(T);
N=randn(LT,1); 
SNR=10*log10(sum(T.*T)/sum(N.*N))    %-4.82 dB SNR noise
Y=T+N;
FY=abs(fft(Y))/LT;  %translate noisy signal to frequency domain via FFT

t = [0:9999]/LT; f=[1:200];  % time and freq ranges for plotting
t1 = [1:1000];t10=(t1-1)/LT; 
figure % Triangle+noise and its spectrum
 subplot(211),plot(t10,Y(t1),'r'),axis([0 0.1 -3 3]), grid on, title('Noisy triangle wave y(t)'),
 subplot(212),plot(f-1,FY(f),'LineWidth',2),title('Spectrum Y(f)'), grid on

% RESONATOR: Emphasize triangle harmonics at 50,150,250 Hertz
% Compute frequency response H(f)
% Ask user for alpha value for poles:
A = input('Type real part of filter poles (Ex: -3): ') %smaller a better, but h(t) gets too long
Z = j*2*pi*[-250:100:250]';  P=Z+A;      % poles and zeros at -250,-150, -50, 50, 150, 250 Hz
NUM = poly(Z); DEN=poly(P);
H = polyval(NUM,j*2*pi*f)./polyval(DEN,j*2*pi*f);  H=1-H; % reson filter Hres = 1-Hcomb

[R P]=residue(NUM,DEN);  %Compute impulse response h(t) via partial fractions
h = -real(R.'*exp(P*t));
figure, %Plot filter H(f) and h((t)
 subplot(211),plot(f-1,FY(f),'r',f-1,abs(H(f)),'g'),
   title('H_{res}(f) in green, and signal spectrum in red'), grid on,
 subplot(212),plot(t,h),title('h_{res}(t)'), grid on
%Convolve noisy signal with impulse response h,via multiplication Y(f) times H(f)
% then return to time domain via ifft()
Z= real(ifft(fft(Y).*fft(h')/LT));
figure, %Plot noisy and filtered waves
 subplot(211),plot(t10,Y(t1)),axis([0 0.1 -3 3]),title('Noisy signal'),grid on,
 subplot(212),plot(t10,Z(t1)),title('Resonator-filtered signal'), grid on
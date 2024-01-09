% file: e6_7_tri_cosine_notch.m  % Notch filter to remove a cosine from sum of triangle and cosine
% cosine: (red)  (red) frequency 50 Hertz, period 0.02
% Triangle: (blue) period 0.04 -> harmonics 25*k Hertz, k odd
% Sample=10000/second. Duration=1 second.
clear; close all; set(0,'defaultAxesFontSize',13);
t=[0:9999]/10000;
S=cos(2*pi*50*t); S=S'; % 50 Hertz sinusoid, then convert to column vector
T = [[-100:99]'*ones(1,25);[100:-1:-99]'*ones(1,25)]/100; T=T(:);  % 25 Hz triangle

FS=abs(fft(S))/10000;  % take FFTs to convert to freq domain
FT=abs(fft(T))/10000;   
t = [0:9999]/10000; f=[1:200];  % time and freq ranges for plotting
t1 = [1:1000];t10=(t1-1)/10000; 

figure % Signals and their spectra
 subplot(121),plot(t10,S(t1),'r',t10,T(t1),'b'),axis([0 0.1 -1 1]), grid on, title('Waves'),
 subplot(122),plot(f-1,FS(f),'r',f-1,FT(f),'b'),title('Spectra'), grid on

% Notch filter: Eliminate 50 Hz cosine
% Compute frequency response H(f)
% Ask user for alpha value for poles:
A = input('Type real part of notch filter poles (Ex: -3): ')  % -5 is optimal value
Z = j*2*pi*[-50, 50]'; P=Z+A;        % poles and zeros
NUM = poly(Z); DEN=poly(P);
H = polyval(NUM,j*2*pi*f)./polyval(DEN,j*2*pi*f);

[R P]=residue(NUM,DEN);  %Compute impulse response h(t) via partial fractions
h = real(R.'*exp(P*t));
figure, %Plot filter H(f) and h(t)
 subplot(211),plot(f-1,FS(f),'r',f-1,FT(f),'b',f-1,abs(H(f)),'g'),
   title('H_{notch}(f), and signal spectra'), grid on,
 subplot(212),plot(t,h),title('h_{notch}(t)'), grid on
% Convolve sum with impulse response h.
Z=(T+S)+real(ifft(fft(T+S).*fft(h')/10000)); 
figure, %Plot sum and filtered sum
 subplot(211),plot(t10,S(t1)+T(t1)),title('Sum of signals'), grid on,
 subplot(212),plot(t10,Z(t1)),title('Filtered sum'), grid on
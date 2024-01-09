%file: e6_7_tri_tri.m  % COMB FILTER APPLIED TO SUM OF TWO TRIANGLE WAVEFORMS
% GOAL: Reject triangle#1, keep triangle#2 
% Triangle#1 (red)  period 0.02->harmonics k*50 Hertz, k odd
% Triangle#2 (blue) period 0.04->harmonics k*25 Hertz, k odd
% Sample=10000/second. Duration=1 second.
clear; close all; set(0,'defaultAxesFontSize',13);

T = [[-50:49]'*ones(1,50);[50:-1:-49]'*ones(1,50)]/50;    T1=T(:);
T = [[-100:99]'*ones(1,25);[100:-1:-99]'*ones(1,25)]/100; T2=T(:);
FT1 = abs(fft(T1))/10000;  % take FFTs to convert to freq domain
FT2 = abs(fft(T2))/10000;   
t = [0:9999]/10000; f=[1:500];  % time and freq ranges for plotting
t1 = [1:1000];t10=(t1-1)/10000; 
figure %Two triangles and their spectra
 subplot(211),plot(t10,T1(t1),'r',t10,T2(t1),'b'),axis([0 0.1 -2 2]), grid on, title('Waves'),
 subplot(212),plot(f-1,FT1(f),'r',f-1,FT2(f),'b'),title('Spectra'), grid on

% COMB filter: Eliminate harmonics at 50,150,250,350 Hertz
% Compute frequency response H(f)
% Ask user for alpha value for poles:
A = input('Type real part of comb filter poles (Ex: -3): ')  % -5 is optimal value
Z = j*2*pi*[-350:100:350]'; P=Z+A;        % poles and zeros
NUM = poly(Z); DEN=poly(P);
H = polyval(NUM,j*2*pi*f)./polyval(DEN,j*2*pi*f);

[R P]=residue(NUM,DEN);  %Compute impulse response h(t) via partial fractions
h = real(R.'*exp(P*t));
figure, %Plot comb filter H(f) and h((t)
 subplot(211),plot(f-1,FT1(f),'r',f-1,FT2(f),'b',f-1,abs(H(f)),'g'),
   title('H_{comb}(f), and signal spectra'), grid on,
 subplot(212),plot(t,h),title('h_{comb}(t)'), grid on
%Convolve sum of two triangles T1+T2 with impulse response h.
%Add in impulse separately (T1+T2+)
Z=(T1+T2)+real(ifft(fft(T1+T2).*fft(h')/10000));
figure, %Plot sum of two triangles and filtered sum
 subplot(211),plot(t10,T1(t1)+T2(t1)),title('SUM OF TWO TRIANGLES'), grid on,
 subplot(212),plot(t10,Z(t1)),title('FILTERED SUM OF TWO TRIANGLES'), grid on
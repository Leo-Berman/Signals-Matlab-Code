% file: e9_1_zyexer2.m   FFT for sum of two closely spaced cosines, various window lengths
clear; close all; 
L=50; N=100;
x=sin(0.3*pi*[0:L-1])+sin(0.4*pi*[0:L-1]);
figure, stem([0:L-1],x),title('x[n]'),grid minor;
figure, plot(abs(fft(x,N))),grid minor,
   xticks([0:L:N]), title(strcat('Rectangular window,L=',num2str(L),', N=',num2str(N)))
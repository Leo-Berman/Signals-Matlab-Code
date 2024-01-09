% file: e9_2_chirps2.m  % chirp sound with constant tone
clear; close all; set(0,'defaultfigureposition',[100,100,600,900]);set(0,'defaultAxesFontSize',14);
X1 = cos(1:10000) + cos([1:10000].*[1:10000]/10000); % cosine tone plus ascending tone
figure, 
 subplot(3,1,1), plot(X1(1:500)),title('x_1(t) (first 500 samples)'),
 subplot(3,1,2), plot(5001:5500,X1(5001:5500)),title('x_1(t) (middle 500 samples)'),
 subplot(3,1,3), imagesc(abs(fft(reshape(X1,100,100)))),colormap(jet), title('X1 spectrogram');
soundsc(X1, 10000);  % for fun, try playing at some other sample freqs like 5000
% file: e9_2_chirps3.m  % chirp sounds 
clear; close all; set(0,'defaultfigureposition',[100,100,700,900]);set(0,'defaultAxesFontSize',14);
X2=cos([1:10000].*[1:10000]/10000)+cos([10000:-1:1].*[10000:-1:1]/10000); % ascending and descending tones
figure, 
 subplot(3,1,1), plot(X2(1:500)),title('x_2(t) (first 500 samples)'),
 subplot(3,1,2), plot(5001:5500,X2(5001:5500)),title('x_2(t) (middle 500 samples)'),
 subplot(3,1,3), imagesc(abs(fft(reshape(X2,100,100)))),colormap(jet), title('X2 spectrogram');
soundsc(X2, 10000);  % for fun, try playing at some other sample freqs like 5000
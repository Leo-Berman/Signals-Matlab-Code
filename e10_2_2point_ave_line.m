% file: e10_2_2point_ave_line.m
% generate Ln by Ln square image x[m,n], convolve with 2-point averager h[m,n] and display new image
% take DSFTs of x and h, multiply in frequency domain, transform back to time and compare to convolution result

clear; close all; set(0,'defaultAxesFontSize',13); fpv =[100 400 500 700]; % parameters for plots
Ln = 5;    % Side length of square input image
n = [0:1:Ln-1];
 
x = zeros(Ln); % array of zeros Ln by Ln
x(:,round(Ln/2)) = 10* ones(Ln,1)  % column of 10s
figure('position',fpv), subplot(3,2,1),imagesc(x), colormap(jet), ylabel('x matrix')

h = 0.25*[1 1; 1 1]; % 2-point 2-D averager impulse response
y1 = conv2(h,x);     % x**h convolution:

y1 = round(y1);  % bogus, extra last column of pixels is created by convolution
% if desired, you can remove bogus last column with y1=y1(1:end-1,1:end-1)
subplot(3,2,2), imagesc(y1),  ylabel('y matrix')

lenFFT = 20*Ln; % increase FFT2 resolution for prettier plots
X = fftshift(abs(fft2(x,lenFFT,lenFFT)));   %DSFT of x matrix. Pads x matrix with zeros to size of lenFFT
subplot(3,2,3), imagesc(X), ylabel('X DSFT')

H = fftshift(abs(fft2(h,lenFFT,lenFFT)));   %DSFT of h matrix (wavenumber response)
subplot(3,2,5), imagesc(H), ylabel('H DSFT')

Y1 = fftshift(abs(fft2(y1,lenFFT,lenFFT))); %DSFT of y matrix
subplot(3,2,4), imagesc(Y1), ylabel('Y DSFT')

Ln1 = Ln+1;  % because time-domain convolution produced Ln+1 points, we must lengthen freq domain
Xshort = fft2(x,Ln1,Ln1);
Hshort = fft2(h,Ln1,Ln1); % pads h with trailing zeros before the FFT, to match the size of X
Y2 = Hshort.*Xshort;      % multiply  FFTs in frequency domain, ELEMENT BY ELEMENT
y2 = round(ifft2(Y2));    % no need for abs(), as ifft2(Y2) is real-valued
subplot(3,2,6),imagesc(y2), ylabel('y2 from iDSFT')

diff = y1-y2   % compare the 2 versions of y (convolution vs. freq domain multiplication)
%figure; imagesc(diff), colormap(jet), ylabel('y1-y2')

H4 = fft2(h) % 4 points only, fft2 of 2-point averager
figure, imagesc(H4), ylabel('H(4) DSFT')
figure, imagesc(fftshift(abs(Hshort))), ylabel('Hshort DSFT')
figure, surf(H), colormap(jet), shading interp    % plot H spectrum as 3-D surface
figure, surf(X), colormap(jet), shading interp    % plot X spectrum as 3-D surface
figure, surf(Y1), colormap(jet), shading interp   % plot Y spectrum as 3-D surface

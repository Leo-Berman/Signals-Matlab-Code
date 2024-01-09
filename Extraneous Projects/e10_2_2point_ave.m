% file: e10_2_2point_ave.m
% generate Ln by Ln square image x[m,n], convolve with 2-point averager h[m,n] and display new image
% take DSFTs of x and h, multiply in frequency domain, transform back to time and compare to convolution result

close all;  %close all figures from previous runs
Ln = 10;    % Side length of square input image
n = [0:1:Ln-1];

x1 = [0:2:(Ln-1)];  x1 = [x1 fliplr(x1)];  % triangular pattern
x2 = Ln*(1-exp(-0.14*n))  %exponential rise
%x2 = x1;                               % makes a diamond pattern
x = round((x1')*x2)  % image matrix x is outer product of x1 (as a column vector) with x2 (row vector)
figure; imagesc(x), colormap(jet), ylabel('x matrix')

h = 0.25*[1 1; 1 1]; % 2-point 2-D averager impulse response
y1 = conv2(x,h);     % x**h convolution:

y1 = round(y1);  % bogus, extra last column of pixels is created by convolution
% if desired, you can remove bogus last column with y1=y1(1:end-1,1:end-1)
figure; imagesc(y1), colormap(jet), ylabel('y matrix')

lenFFT = 10*Ln; % increase FFT2 resolution for prettier plots
X = fftshift(abs(fft2(x,lenFFT,lenFFT))); %DSFT of x matrix. Pads x matrix with zeros to size of lenFFT
figure; imagesc(X), colormap(jet), ylabel('X DSFT')

H = fftshift(abs(fft2(h,lenFFT,lenFFT)));   %DSFT of h matrix (wavenumber response)
figure; imagesc(H), colormap(jet), ylabel('H DSFT')

Y1 = fftshift(abs(fft2(y1,lenFFT,lenFFT))); %DSFT of y matrix
figure; imagesc(Y1), colormap(jet), ylabel('Y DSFT')

Ln1 = Ln+1;  % because time-domain convolution produced Ln+1 points, we must lengthen freq domain
Xshort = fft2(x,Ln1,Ln1);
Hshort = fft2(h,Ln1,Ln1); % pads h with trailing zeros before the FFT, to match the size of X
Y2 = Hshort.*Xshort;      % multiply  FFTs in frequency domain, ELEMENT BY ELEMENT
y2 = round(ifft2(Y2));    % no need for abs(), as ifft2(Y2) is real-valued
figure; imagesc(y2), colormap(jet), ylabel('y2 from iDSFT')

diff = y1-y2   % compare the 2 versions of y (convolution vs. freq domain multiplication)
figure; imagesc(diff), colormap(jet), ylabel('y1-y2')

H4 = fft2(h) % 4 points only


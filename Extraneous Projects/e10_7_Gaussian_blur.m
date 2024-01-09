% file: e10_7_Gaussian_blur  
% Blur an image with a Gaussian exponential convolution, deconvolve to restore
close all; clear; set(0, 'DefaultFigurePosition', [100 400 1100 200]);
L = 20;                          % to make L+1 order Gaussian filter
L2 = floor(L/2);ex = [-L2: L2];  % exponent vector for filter
Hr = exp(-ex.^2/L);              % row vector for filter
H =  Hr' * Hr;                   % Gaussian matrix values = e^{-(m^2+n^2)/L}
%H = H/sum(H(:));                % scale filter to unity magnitude sum (OPTIONAL)

load letters;                    % loading letters.mat file, a 2-D array of doubles                    
% load clown; X = clown;         % try script on clown also!
% X = [1:1:30]' * [1:1:30];      % simple testcase to debug code, comment out when debugged
Y=conv2(X,H);                    % Y is convolved (blurred) image
s = size(Y)
FH = fft2(H,s(1),s(2));          % spectrum of blurring filter

Xhatd = fft2(Y)./FH;    % divide blurred spectrum by H spectrum to restore original
Xhat = abs(ifft2(Xhatd));  % take ifft to get image

figure,colormap(gray),
 subplot(141),imagesc(X),title('Original image'),subplot(142),imagesc(H), title('Blurring Gaussian PSF')
subplot(143),imagesc(Y),title('Blurred image'),subplot(144),imagesc(Xhat), title('De-convolved image')

figure,colormap(jet),
 subplot(141),imagesc(fftshift(log10(abs(fft2(X,s(1),s(2)))))), title('Original image spectrum')
 subplot(142),imagesc(fftshift(log10(abs(FH)))), title('Blurring H spectrum')
 subplot(143),imagesc(fftshift(log10(abs(fft2(Y))))), title('Blurred image spectrum')
 subplot(144),imagesc(fftshift(log10(abs(Xhatd)))), title('De-convolved spectrum') %  w/o regularization
Hreciprocal = fftshift(log10(abs(1./FH)));  % for plots
figure,colormap(jet),  % plot H and 1/H in 3-D for fun
  subplot(141),surf(fftshift(log10(abs(FH)))),shading interp, title('Blurring H spectrum (dB)')
  subplot(142),imagesc(Hreciprocal), title('1/H spectrum')
  subplot(143),surf(Hreciprocal),shading interp, title('1/H spectrum (dB)')
  subplot(144),surf(fftshift((abs(FH)))),shading interp, title('Blurring |H| spectrum')
  
% compare deconvolution (after removing convolution margins) to original image
diff = Xhat(1:end-L,1:end-L) - X;
maxdiff = max(abs(diff(:)))
sumsquared_diff = sum(sum(diff.^2))
figure, surf(diff),shading interp, title('Errors in deconvolution')
% file: e10_7_Gaussian_blur_noise
% Blur an image with a Gaussian exponential convolution, deconvolve to restore
% Optionally add noise, and do Wiener filter deconvolution to restore image
close all; clear; set(0, 'DefaultFigurePosition', [100 400 1100 200]);
L = 20; L2 = floor(L/2);          % to make L+1 order Gaussian filter
ex = [-L2: L2];                  % exponent vector for filter
Hr = exp(-ex.^2/L);              % row vector for filter
H =  Hr' * Hr;                   % Gaussian matrix values = e^{-(m^2+n^2)/L}
%H = H/sum(H(:));                % scale filter to unity magnitude sum (but messes up Wiener filter precision)

load letters;                    
% load clown; X = clown;         % try script on clown also!
% X = [1:1:30]' * [1:1:30];      % simple testcase to debug code, comment out when debugged
Yc =conv2(X,H);                  % Yc is convolved (blurred) image
s = size(Yc)
FH = fft2(H,s(1),s(2));                  % spectrum of blurring filter

NoiseMax = max(Yc(:))/100;  % noise level (vary the denominator to adjust SNR. 100 is SNR=26 dB, 8 is 6.8 dB)
Noise = NoiseMax*abs(randn(s(1),s(2)));  % arbitrary non-negative noise (OPTIONAL)
Y = Yc + Noise;                          % add noise (OPTIONAL)
figure('position',[400 650 530 200]),colormap(gray), 
 subplot(1,2,1),imagesc(Noise),title('Noise')  % (OPTIONAL)
 subplot(1,2,2),imagesc(Y), title('Noisy blurred image')  % (OPTIONAL)

Xhatd = fft2(Y)./FH;    % divide blurred spectrum by H spectrum to restore original
Xhat = abs(ifft2(Xhatd));  % take ifft to get image

figure('position',[100 400 1100 200]),colormap(gray),
 subplot(141),imagesc(X), title('Original image')
 subplot(142),imagesc(H), title('Blurring Gaussian PSF')
 subplot(143),imagesc(Y), title('Blurred image')
 subplot(144),imagesc(Xhat), title('De-convolved image')

figure('position',[100 100 1100 200]),colormap(jet),
 subplot(141),imagesc(fftshift(log10(abs(fft2(X,s(1),s(2)))))), title('Original image spectrum')
 subplot(142),imagesc(fftshift(log10(abs(FH)))), title('Blurring H spectrum')
 subplot(143),imagesc(fftshift(log10(abs(fft2(Y))))), title('Blurred image spectrum')
 subplot(144),imagesc(fftshift(log10(abs(Xhatd)))), title('De-convolved spectrum') %  w/o regularization
Hreciprocal = fftshift(log10(abs(1./FH)));  % for plots
figure('position',[400 950 1200 200]),colormap(jet),  % plot H and 1/H in 3-D for fun
  subplot(141),surf(fftshift(log10(abs(FH)))),shading interp, title('Blurring H spectrum (dB)')
  subplot(142),imagesc(Hreciprocal), title('1/H spectrum')
  subplot(143),surf(Hreciprocal),shading interp, title('1/H spectrum (dB)')
  subplot(144),surf(fftshift((abs(FH)))),shading interp, title('Blurring |H| spectrum')
  
% compare deconvolution (after removing convolution margins) to original image
diff = Xhat(1:end-L,1:end-L) - X;
maxdiff = max(diff(:))
sumsquared_diff = sum(sum(diff.^2))
figure, surf(diff),shading interp, title('Errors in deconvolution')

% Deblur the image using a Wiener filter
for Lambda2 = 0:2:8                   % Lambda squared, test various values
 FW = fft2(Y).*conj(FH)./(FH.*conj(FH)+Lambda2);  % Wiener filtered version
 W = abs(ifft2(FW));
 figure('position',[100 700 750 200]),colormap(jet),
  subplot(1,3,1),imagesc(fftshift(log10(abs(FW)))), title("Wiener spectrum, L^2="+Lambda2)
  subplot(1,3,2),surf(fftshift(log10(abs(FW)))),shading interp, title("Wiener spectrum (dB), L^2="+Lambda2)
  subplot(1,3,3),surf(fftshift((abs(FW)))),shading interp,title("Wiener spectrum, L^2="+Lambda2), colorbar
 figure('position',[100 990 220 200]),imagesc(W),colormap(gray), title("Wiener image, L^2="+Lambda2)
end

% calculate signal/noise ratio SNR (for blurred image)
sigpower = sum(sum(Y.^2))  % sum of squares of pixels
noisepower = sum(sum(Noise.^2))
SNR = 10*log10(sigpower/noisepower), SNRpercent = 100*sigpower/noisepower
noisemean = mean(abs(Noise(:))), signalmean = mean(abs(Y(:))) % print  average noise and signal values
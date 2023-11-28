% file: e10_7_disk_blur.m  %Blur an image with a disk-shaped convolution, then deconvolve to restore
clear; close all; set(0,'defaultfigureposition',[100,100,900,250]);
r = 12;         % r = radius of disk
H = zeros(2*r); % initialize square array to zeros
for I=1:2*r     % make center disk of ones
    for J=1:2*r
        if((I-r)^2+(J-r)^2 < r^2)
            H(I,J)=1;
        end;
    end;
end;
%H=1/(sum(sum(H)))*H; % normalize to unity total energy magnitude

X = imread('letters.bmp');  % this .bmp has uint8 pix values 0 to 255
%X = rescale(X);            % (optionally) scale pixel values to 0 to 1 double precision
Y=conv2(X,H);               % Do the Guassian blur
s = size(Y)
 
figure, subplot(131),imagesc(H),colormap(gray), title('Blurring PSF')
 subplot(132),imagesc(X),title('Original image')
 subplot(133),imagesc(Y),title('Disk blurred image')
FH = fft2(H,s(1),s(2));  % spectrum of blurring disk

figure, 
 subplot(131),imagesc(fftshift(log10(abs(FH)))),colormap(jet), title('Blurring H spectrum')
 subplot(132),imagesc(fftshift(log10(abs(fft2(X))))),title('Original image spectrum')
 subplot(133),imagesc(fftshift(log10(abs(fft2(Y))))), title('Blurred image spectrum')
 
Xhatd = fft2(Y)./FH;  % divide blurred spectrum by H spectrum to restore original
Xhat=abs(ifft2(Xhatd));
figure,imagesc(fftshift(log10(abs(Xhatd)))),colormap(jet), title('De-blurred spectrum')
figure,imagesc(Xhat),colormap(gray), title('De-blurred image')

figure, surf(fftshift(log10(abs(FH)))), colormap(jet), title('Blurring H spectrum (log plot)')
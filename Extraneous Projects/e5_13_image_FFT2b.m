% file: e5_13_image_FFT2b.m   % Photo image FFTs, effects of mixing phase*magnitude of 2 images
clear; fpv = [10 100 900 800]; set(0,'defaultAxesFontSize',11); close all; %figure size, fonts
XL = rgb2gray(imread('lady225.png'));       % these are 225x225, grayscale but true-color 3-plane images
Xs = rgb2gray(imread('surveyor225.png'));   % rgb2gray() converts to single-plane 8-bit pixels

FXs=fftshift(fft2(Xs)); absFXs = abs(FXs); aFXs=angle(FXs); 
FXL=fftshift(fft2(XL)); absFXL = abs(FXL); aFXL=angle(FXL); 
XL_recon = abs(ifft2(fftshift(FXL)));   %verify that ifft2() produces original image
FX_sL = absFXs.*cos(aFXL) + j*absFXs.*sin(aFXL); % mix magnitude of image Xs with phase of image XL
X_sL = abs(ifft2(fftshift(FX_sL)));     % reconstruct image via inverse Fourier transform

FX_Ls = absFXL.*cos(aFXs) + j*absFXL.*sin(aFXs); % mix magnitude of image XL with phase of image Xs
X_Ls = abs(ifft2(fftshift(FX_Ls)));     % reconstruct image via inverse Fourier transform

figure('position',fpv), subplot(2,2,1), imagesc(XL), colormap(gray), title('Lady (L) image'),
 subplot(2,2,2), imagesc(Xs), title('Surveyor (S) image'),
 subplot(2,2,3), imagesc((X_sL)), title('Surveyor |X_s|, Lady \phi_L'),
 subplot(2,2,4), imagesc((X_Ls)), title('Lady |X_L|, Surveyor \phi_s')
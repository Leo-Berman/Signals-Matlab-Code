% file: e5_13_image_FFT2.m   % Image FFTs, effects of mixing phase with magnitude of 2 images
clear; fpv = [10 100 800 500]; set(0,'defaultAxesFontSize',12); close all; %figure size, fonts
L=128; L2=round(L/2); L4 = round(L/4); L8= round(L/8); L16= round(L/16); L38 = 3*L8;  % sizes
Xz=zeros(L16); X1=ones(L4); X2=zeros(L-L4-L16); Xs=blkdiag(Xz,X1,X2); %small white square upper left 
Xz=zeros(L2); X1=ones(L38); X2=zeros(L-L2-L38); Xb=blkdiag(Xz,X1,X2); %large white square lower right 

FXs=fftshift(fft2(Xs)); absFXs = abs(FXs); aFXs=angle(FXs); 
FXb=fftshift(fft2(Xb)); absFXb = abs(FXb); aFXb=angle(FXb); 
Xs_recon = ifft2(fftshift(FXs));   %verify that ifft2() produces original image
FX_sb = absFXs.*cos(aFXb) + j*absFXs.*sin(aFXb); % mix magnitude of image Xs with phase of image Xb
X_sb = ifft2(fftshift(FX_sb));   % reconstruct image via inverse Fourier transform

FX_bs = absFXb.*cos(aFXs) + j*absFXb.*sin(aFXs); % mix magnitude of image Xb with phase of image Xs
X_bs = ifft2(fftshift(FX_bs));   % reconstruct image via inverse Fourier transform

figure('position',fpv), subplot(2,3,1), imagesc(Xs), colormap(gray), title('Image x_s'),
 subplot(2,3,2), imagesc(Xs_recon), title('Reconstructed x_s'),
 subplot(2,3,3), imagesc(Xb), title('Image x_B'),
 subplot(2,3,5), imagesc(X_bs), title('Reconstructed |X_B|*\phi_s'),
 subplot(2,3,6), imagesc(X_sb), title('Reconstructed |X_s|*\phi_B')
% file: e5_13_image_FFT.m   %2D Image FFTs, and effects of phase
clear; close all; fpv = [100 100 900 250]; set(0,'defaultAxesFontSize',12);  % figure size, fonts
L=64; L2=round(L/2); L4 = round(L/4); L8= round(L/8); L38 = 3*L8;  % size of simple image with squares

Xz=zeros(L38); X1=ones(L4); X=blkdiag(Xz,X1,Xz); % array of zeros (black) L by L, with L/4 white center
%Xz=zeros(L8); X1=ones(L4); X2=zeros(L-L4-L8); X=blkdiag(Xz,X1,X2);   % small white square, upper left 
%Xz=zeros(L2); X1=ones(L38); X2=zeros(L-L2-L38); X=blkdiag(Xz,X1,X2); % larger white square, lower right 

FX=fftshift(fft2(X)); aFX=angle(FX); mFX=abs(FX);
logFX=log10(mFX+1);           %add small value before log, to prevent -infinity logs
figure('position',fpv), subplot(1,3,1), imagesc(X), colormap(gray), title('Original image'),
 subplot(1,3,2), imagesc(mFX,[0 150]), title('|X(\omega_1,\omega_2)|'),
 subplot(1,3,3), imagesc(aFX), title('\phi(\omega_1,\omega_2)')
figure('position',fpv),       % also plot spectra as 3-D surfaces
 subplot(1,2,1), surf(logFX), colormap(jet), shading interp, axis tight, title('log|X(\omega_1,\omega_2)|') 
 subplot(1,2,2), surf(aFX),shading interp,axis tight,title('\phi(\omega_1,\omega_2)')
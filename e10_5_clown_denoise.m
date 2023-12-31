% file: e10_5_clown_denoise.m 
% read image, add noise, lowpass filter via FFT at various cutoff frequencies, to denoise 
clear; close all; set(0,'defaultAxesFontSize',13);
clown = imread('clown.png');  % this .png has uint8 pix values 0 to 255
clown = rescale(clown);       % scale pixel values to 0 to 1 double precision
figure('position',[100,100,1100,1100]),
 subplot(3,3,1), imagesc(clown), colormap(gray), title('Original');
s = size(clown)                   % size() returns [rows, columns] of array 
Y = clown + 0.2*randn(s(1),s(2)); % randn() = array of random numbers from standard normal
                                  % distribution, max value 5. 
subplot(3,3,2), imagesc(Y), colormap(gray), title('Noise added');
FY=fft2(Y);
% FFT (and image) sizes s(1:2) correspond to 2*pi, so s(1)/2 is a pi-cutoff freq
for n = 2:8  % loop through various filter cutoff frequencies
 cutoff  = 1/n
 L = round(s/2 * cutoff)  %indices into image array for cutoff 
 FZ = FY; 
 FZ(L(1):s(1)-L(1),:)=0; FZ(:,L(2):s(2)-L(2))=0; % zero high frequencies in both directions
 % high frequencies are in the middle of array 
 %(EG, for L=50, this statement zeros rows 50 through 150 of 200, which is pi/2 cutoff)
 % subplot(3,3,n), imagesc(log10(abs(fftshift(FZ)))), colormap(jet)  %show filtered spectrum
 Z = real(ifft2(FZ)); 
  subplot(3,3,n+1), imagesc(Z), colormap(gray), title("LP filtered, \Omega_c = "+cutoff+"\pi");
end

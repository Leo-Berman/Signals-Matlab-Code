% file: e10_5_letters_denoise_.m   Image with added noise and effect of lowpass filtering
clear; close all; fpv = [100 100 300 250]; set(0,'defaultAxesFontSize',11);      %figure size, fonts
load letters.mat;    %letters image data file has array X() values 0=black and 255=white
figure('position',fpv); imagesc(X), colormap(gray), title('Original');
s = size(X)          % size() returns [rows, columns] of array (256 x 256 here)
noise = 200*(randn(s(1),s(2)));  % randn() returns array of random nums from standard normal distribution, max value 5
Y = X + noise;   
figure('position',fpv); imagesc(Y), colormap(gray), title('Noisy');

FX=fft2(X);  FY=fft2(Y);
clims =[2,5.5]; % constrain color range for log freq plots. Logs are 2 to 7. We want more shades for the middle values
figure('position',fpv); imagesc(log10(abs(fftshift(FX))),clims), colormap(jet),title('Original FX(\Omega_1,\Omega_2)')
figure('position',fpv); imagesc(log10(abs(fftshift(FY))),clims), colormap(jet),title('Noisy FY(\Omega_1,\Omega_2)')

for W = 25:25:75   % W = width of lowpass passband, in samples.  Try several values...
  FZ = FY; 
  cutoff = W*pi/128
  L=round(s(1)*cutoff/(2*pi)); L2=round(L*s(2)/s(1));  
  FZ(L:s(1)-L,:)=0; FZ(:,L2:s(2)-L2)=0;  % zero high freqs in both directions (high f is the middle of the fft2 array)
  YLP = real(ifft2(FZ)); 
  figure('position',fpv); imagesc(YLP), colormap(gray), title(strcat('Filtered, cutoff=',num2str(W),'\pi/128')); 
  figure('position',fpv);
    imagesc(log10(abs(fftshift(FZ))),clims), colormap(jet),
     title(strcat('Filtered Y_{LP}(\Omega_1,\Omega_2), cutoff=',num2str(W),'\pi/128'))
end
% calculate signal/noise ratio SNR
sigpower = sum(sum(X.^2))          %sum of squares of pixels
noisepower = sum(sum(noise.^2))
SNR = 10*log10(sigpower/noisepower), SNRpercent = 100*sigpower/noisepower
noise_abs_mean = mean(abs(noise(:))), signalmean = mean(X(:)) % print average noise and signal values
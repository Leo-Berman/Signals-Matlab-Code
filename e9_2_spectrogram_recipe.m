%file e9_2_spectrogram_recipe.m 
clear; close all;
N=27;
X=cos([1:10000].*[1:10000]/10000)+cos([10000:-1:1].*[10000:-1:1]/10000); %example values              
L = floor(length(X)/N);      % L=interval length, N=number of intervals
XX = reshape(X(1:L*N),L,N);  % convert 1-dimensional X to 2-d matrix XX of N columns 
FX2 = abs(fft(XX).*fft(XX)); % squaring the FFT values to get energy values
imagesc(FX2)                 % imagesc() displays image with scaled colors
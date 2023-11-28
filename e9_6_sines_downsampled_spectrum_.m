% file: e9_6_sines_downsampled_spectrum_.m 
% time and frequency spectra plots for sine and downsampled-by-2 sine     
clear; close all; set(0,'defaultAxesFontSize',12);  % erase all previous plots
N = 20; Nfft= 256;    % N = number of time sample points and Nfft = FFT size.
L = 2;                % downsample factor
n = [0:1:N-1];   
x = sin(2*pi/N*n);    % one period of input wave in N samples
x2 = x;
neven = n(2:2:end)+1; % even index #s (actually are odd, since MATLAB arrays start at index 0)
x2(neven) = 0;        % pick odd values of x to plot, before compressing to y
y = x(1:L:end);       % y is x downsampled by factor L

figure; subplot(2,1,1); stem(n,x); subplot(2,1,2); stem(n,x2,'r');
figure; subplot(2,1,1); stem(n,x); subplot(2,1,2); stem(y,'r');

% calculate ffts (DFT)
w= linspace(0,pi,Nfft/2);   % frequency omega range (0 to pi)
fx = fft(x, Nfft);  Fx =fx(1:Nfft/2);  % plot only positive half of spectra
fy = fft(y, Nfft);  Fy =fy(1:Nfft/2);
figure; hold on
plot(w,abs(Fx/N), 'LineWidth', 2);  % scale ffts by number of points to get proper magnitude
plot(w,abs(Fy/N), 'LineWidth', 2), xlabel('Frequency'); ylabel('Magnitude')
% file: e9_8_cosine_upsampled_interpolated_lowpass_.m  
% time and frequency spectra plots for cosine and upsampled-by-L, interpolated cosine     
% upsample cos(0.2pi n) by factor L (configurable)
% interpolate by lowpass filtering in frequency domain
clear; close all; set(0,'defaultAxesFontSize',13);
fpv = [0 300 500 300]; % position and size vector for figures
L = 2;                 % upsampling factor
N = 10;                % number of sample points N = 2*pi/W_0 per cycle. W_0 = 2/10 pi = 0.2pi
Nf = 8*N;              % increase number of sample points (# cycles) for fft resolution improvement
nf = [0:Nf-1];      
xf = cos(2*pi/N*nf);   % sampled signal

% plot continuous-time cosine overlaid with 10 samples/cycle
t = [0:0.2:Nf-1];      
x = cos(2*pi/N*t);
figure('position', fpv); 
 subplot (2,1,1); plot(t,x,'m'); subplot (2,1,2); hold on; plot(t,x,'m'); stem(nf,xf);

temp = [xf; zeros(L-1,length(xf))]; yf=temp(:)';     % yf is xf upsampled (zero-stuffed) by factor L
ny = length(yf);
figure('position', fpv); subplot(2,1,1); stem(xf); subplot(2,1,2); stem(yf,'r');
w = linspace(-pi,pi,Nf); wy = linspace(-pi,pi,ny);         % frequency omega range 
 % frequency omega range (0 to 2pi)temp

% calculate ffts (DFT)
fx = fft(xf); fx = fftshift(fx);  % fftshift(): show plot with freq 0 in center
fy = fft(yf); fy = fftshift(fy); 
% draw smooth plots of DFTs 
figure('position', fpv),hold on,axis tight, % scale ffts by 1/N to get proper magnitude
  plot(w,abs(fx/Nf), 'LineWidth', 2), plot(wy,abs(fy/Nf), 'LineWidth', 2); 
  xlabel('Frequency'); ylabel('Zero-stuffed Magnitude'), hold off;

% interpolate via lowpass in freq domain (zero out fft frequency values > pi/L, scale remaining values by L)
zcount = length(fy) - length(fy)/L;  % number of values to replace with zero
fyLP = [zeros(1,zcount/2) L*fy(1+zcount/2: length(fy) - zcount/2) zeros(1,zcount/2)];

% draw smooth plots of DFTs 
figure('position', fpv); hold on; axis tight;
  plot(w,abs(fx/Nf), 'LineWidth', 2);  plot(wy,abs(fyLP/Nf), 'LineWidth', 2);
  xlabel('Frequency'); ylabel('Interpolated (lowpass) Magnitude'), hold off;

% transform back to time domain y[n], and plot the interpolated signal
yi = ifft(fftshift(fyLP));
figure('position', fpv); stem(yi,'r'); ylabel('Interpolated (lowpass) signal ')
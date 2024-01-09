% file: e9_11_audio_cosine_downsampled_upsampled.m
% time  plots for cosine, downsampled by factor D, then upsampled by L     
% 440 Hz cos(880 pi t) sampled at 4400 sample/sec --> 4400/880 pi rad/sec = cos(0.4167pi n) 
% downsample by factor D (configurable)
% upsample by factor L (configurable)
% (optionally) interpolate by lowpass filtering in frequency domain
clear; close all; set(0,'defaultAxesFontSize',14);
L = 2;                 % upsampling factor
D = 2;                 % downsampling factor
f = 440;               % cosine frequency
r = 4400;              % sample rate, samples/sec (Hz)
N = r/f;               % number of sample points per cycle
num = 5;               % number of cycles to plot
Nf = ceil(num*N);      % number of sample points 
nf = [0:1:Nf-1];      
xs = cos(2*pi/N*nf);   % sampled signal

t = [0:0.03:Nf-1];     % high res timescale for continuous plot
x = cos(2*pi/N*t);
fpv = [0 100 450 120]; % position and size vector for figures
figure('position', fpv);  plot(t,x,'m'); %plot continuous signal
% plot continuous-time cosine overlaid with N samples/cycle
figure('position', fpv); hold on; 
 plot(t,x,'m'); stem(nf,xs,'b'); hold off; 

% downsample by factor D=2 to shift tone up to next octave
yd = xs(1:D:length(xs)); % downsampled by factor D
nydvec = [0:1:length(yd)-1];
t = [0:0.2:length(yd)-1];
xyd = cos(2*pi*t*num/length(yd));       
figure('position', fpv); hold on; plot(t,xyd,'m'); 
 stem(nydvec,yd,'b'); ylabel('Downsampled'); hold off; 
yd2 = [yd yd];   % restore original samples/sec (D times as many samples)
nydvec2 = [0:1:length(yd2)-1];
% plot downsampled signal overlaid with continuous cosine 
t2 = [0:0.2:length(yd2)-1];
xyd2 = cos(2*pi*t2*num*D/length(yd2));  % D times the frequency
figure('position', fpv); hold on; plot(t2,xyd2,'m'); 
 stem(nydvec2,yd2,'b'); ylabel('Downsampled,same sample rate'); hold off; 

% upsampled (zero-stuff) by factor L
temp = [yd; zeros(L-1,length(yd))]; yu=temp(:)';     % yf is xf upsampled (zero-stuffed) by factor L
ny = length(yu); nyvec = [0:1:ny-1];      
figure('position', fpv); stem(nyvec,yu,'b'); ylabel('Upsampled')

% calculate fft (DFT) of upsampled signal
fyu = fft(yu); fyu = fftshift(fyu); % fftshift(): show plot with freq 0 in center

% interpolate via lowpass in freq domain (zero out fft frequency values > pi/L, scale remaining values by L)
zcount = ceil((length(fyu) - length(fyu)/L)/2);  % half the number of values to replace with zeros
fyLP = [zeros(1,zcount) L*fyu(1+zcount: length(fyu) - zcount) zeros(1,zcount)];

L2 = 2;
% transform back to time domain y[n], and plot the interpolated signal
yi = ifft(fftshift(fyLP));
yi = yi(1:length(yi)/L2 -1);   %grab only N samples
t = [0:0.1:length(yi)/L2 -1];
figure('position', fpv);  stem( abs(yi),'b'); ylabel('Up/Interpolated'); 
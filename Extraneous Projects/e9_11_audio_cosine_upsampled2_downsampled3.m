% file: e9_11_audio_cosine_upsampled2_downsampled3.m
% time plots for cosine, upsampled by factor L, then downsampled by D     
% 440 Hz cos(880 pi t) sampled at 4400 sample/sec --> 4400/880 pi rad/sec = cos(0.4167pi n) 
% upsample by factor L=2 (configurable)
% downsample by factor D=3 (configurable),  yields new frequency D/L *original
% interpolate linearly, hardwired to L=2

clear; close all; set(0,'defaultAxesFontSize',14); fpv = [0 100 450 120]; % size of figures
L = 2;               % upsampling factor
D = 3;               % downsampling factor
f = 440;             % cosine frequency
r = 6600;            % sample rate, samples/sec (Hz)
N = r/f;             % number of sample points per cycle
num = 4;             % # of cycles to plot
Nf = ceil(num*N);    % total number of sample points 
nf = [0:1:Nf-1];      
t = [0:0.03:Nf-1];   % high res timescale for continuous plot
x = cos(2*pi/N*t);
figure('position', fpv);  plot(t,x,'m'); % plot cosine

% plot continuous-time cosine overlaid with N samples/cycle
xs = cos(2*pi/N*nf);   % sampled signal
figure('position', fpv);  hold on; plot(t,x,'m'); 
  stem(nf,xs,'b'); hold off; 

% upsample linearly (for simplicity) by factor L=2
xs1 = [xs(1) xs];                     % pad first element
xsL = [xs xs(end)];                   % pad last element
xi = (xs1+xsL)/2; xi = xi(1:(end-1)); % average adjacent values
yu = [xi;xs]; yu= yu(:)'; % interleave xs with averages
ny = length(yu)/2; nyvec = [0:1:ny-1]; % plot only first half of samples     
figure('position', fpv);  stem(nyvec,yu(1:ny),'b'); ylabel('Up/Interpolated'); 

% downsample by factor D=3 to shift tone up 
yd = yu(1:D:length(yu)); % downsampled by factor D
yd3 = [yd yd yd];  % restore original samples/sec (D times as many samples)
nydvec3 = [0:1:length(yd3)-1];
% plot downsampled signal 
figure('position', fpv); stem(nydvec3,yd3,'b'); ylabel('Downsampled');  
 




% file: e9_7_cosine_upsampled_L4_.m 
% time and spectral plots for upsampled cos(0.4pi n) by factor L=4     
% The 0.4pi frequency upsamples to (0.1pi, 0.4pi, 0.6pi, 0.9pi) replicas 
clear; close all; set(0,'defaultAxesFontSize',13);
fpv = [0 100 450 120]; % position and size vector for figures
L = 2;                 % upsampling factor
N = 5;                 % number of sample points N = 2*pi/W_0 per cycle. W_0 = 2/5 pi = 0.4pi
Nf = 8*N;              % increase number of sample points (# cycles) for fft resolution improvement
nf = [0:1:Nf-1];       % indices of samples
xf = cos(2*pi/N*nf);   % sampled signal

% plot continuous-time cosine overlaid with 5 samples/cycle
t = [0:0.2:Nf-1];     
x = cos(2*pi/N*t);
figure; subplot (2,1,1); plot(t,x,'m'); subplot (2,1,2); hold on; plot(t,x,'m'); stem(nf,xf);

temp = [xf; zeros(L-1,length(xf))]; yf=temp(:)'; % yf is xf upsampled (zero-stuffed) by factor L
ny = length(yf);
figure; subplot(2,1,1); stem(xf); subplot(2,1,2); stem(yf,'r');
% calculate ffts (DFT)
fx = fft(xf); fx = fx(1:length(fx)/2);  % show just 0 to pi range in plots
fy = fft(yf); fy = fy(1:length(fy)/2); 
w = linspace(0,pi,Nf/2);                % frequency omega range (0 to pi)
wy = linspace(0,pi,ny/2);               % frequency omega range (0 to pi)
% draw smooth plots of DFTs 
figure; hold on; axis tight;
plot(w,abs(fx/Nf), 'LineWidth', 2);     % scale ffts by 1/N to get proper magnitude 
plot(wy,abs(fy/Nf),'LineWidth', 2);     
xlabel('Frequency'); ylabel('Magnitude')

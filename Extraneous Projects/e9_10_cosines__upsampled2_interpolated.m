% file: e9_10_cosine_upsampled2_interpolated.m
% time and frequency spectra plots for 3 cosines with DC component and upsampled-by-L, interpolated cosines     
% upsample sum of 3 cosines by factor L=1 (try L=2 and L=3 also)
% interpolate by lowpass filtering in frequency domain
clear; close all; set(0, 'defaultAxesFontSize',14);
fpv = [0 300 900 200]; % position and size vector for figures

L = 1;                % upsampling factor
N = 3;                 % number of sample points per cycle N = 2*pi/W_0 per cycle.  W_0 = 2/3 pi = 0.67pi
Nf = 10*N;             % increase number of sample points (# cycles) for fft resolution improvement

nf = [0:1:Nf-1];      
xf = 2.5+ cos(2*pi/N*nf) + 2*sin(2.4*pi/N*nf)+ 0.5*sin(2.7*pi/N*nf);   % sampled signal

% plot continuous-time cosine overlaid with N samples/cycle
t = [0:0.2:Nf-1];      % 7.5 cycles of 100 Hz cosine = 75 msec
x = 2.5+ cos(2*pi/N*t) + 2*sin(2.4*pi/N*t)+ 0.5*sin(2.7*pi/N*t);

figure('position', fpv); 
 hold on; plot(t,x,'m'); stem(nf,xf); hold off;
 
 % convolve samples with various first-order RC lowpasses, plot
 h = [1 exp(-2) exp(-4) exp(-6)];  % Tau = 0.5 -- plot looks like connect-the-dots
 out = conv(xf, h);
 figure('position', fpv); plot(out,'m');

 h = [1 exp(-1) exp(-2) exp(-3) exp(-4) exp(-5)];  % Tau = 1
 out = conv(xf, h);
 figure('position', fpv); plot(out,'m');
 
 h = [0.5  exp(-1/2)/2 exp(-1)/2 exp(-3/2)/2 exp(-2)/2 exp(-2.5)/2];  % Tau = 2
 out = conv(xf, h);
 figure('position', fpv); plot(out,'m');

temp = [xf; zeros(L-1,length(xf))]; yf=temp(:)';     % y is x upsampled (zero-stuffed) by factor L
ny = length(yf);
figure('position', fpv);  stem(xf);  figure('position', fpv); stem(yf,'r');
w = linspace(0,2*pi,Nf);          % frequency omega range (0 to 2pi)
wy = linspace(0,2*pi,ny); % frequency omega range (0 to 2pi)temp
% calculate ffts (DFT)
fx = fft(xf); fx = fftshift(fx);  % fftshift(): show plot with freq 0 in center
fy = fft(yf); fy = fftshift(fy); 
% draw smooth plots of DFTs 
%figure('position', fpv); hold on; axis tight;
%plot(w-pi,abs(2*pi*fx/Nf), 'LineWidth', 2);        % scale ffts by sampling freq Omega... 
%plot(wy-pi,abs(2*pi*fy/Nf), 'LineWidth', 2); %   Omega=2*pi/N to get proper magnitude
%xlabel('Frequency'); ylabel('Zero-stuffed Magnitude')
%hold off;

% interpolate via lowpass in freq domain (zero out fft frequency values > pi/L, scale by L)
numvalues = length(fy)/L;
zerocount = length(fy) - numvalues;
fyLP = [zeros(1,zerocount/2) L*fy(1+zerocount/2: length(fy) - zerocount/2) zeros(1,zerocount/2)];

% draw smooth plots of DFTs 
figure('position', fpv); hold on; axis tight;
plot(w-pi,abs(2*pi*fx/Nf), 'LineWidth', 2);        % scale ffts by sampling freq Omega... 
plot(wy-pi,abs(2*pi*fyLP/Nf), 'LineWidth', 2);     %   Omega=2*pi/N to get proper magnitude
xlabel('Frequency'); ylabel('Interpolated (lowpass) Magnitude')
hold off;

% transform back to time domain y[n]
yi = ifft(fftshift(fyLP));
nyi = [0:1:length(yi)-1];
figure('position', fpv); hold on; plot(nyi,yi, 'b'); stem(nyi,yi,'r'); ylabel('Interpolated (lowpass) signal ')

% redraw as zero-order hold
nyi2 = [0.5:1:length(yi)-0.5];
figure('position', fpv); stem(nyi2,yi,'r', 'Marker','none', 'Linewidth',16); ylabel('Interpolated (lowpass) signal ')
 

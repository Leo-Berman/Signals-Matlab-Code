% file: e9_9_cosine_upsampled_interpolated_downsampled.m
% time and frequency spectra plots for cosine, upsampled-by-U, interpolated, and then downsampled by D     
% 500 Hz cos(1000 pi t) sampled at 2400 sample/sec --> 1000/2400 pi rad/sec = cos(0.4167pi n) 
% upsample by factor U (configurable)
% interpolate by lowpass filtering in frequency domain
% downsample by factor D (configurable)

clear; close all; set(0,'defaultAxesFontSize',13);
fpv = [0 300 400 200]; % position and size vector for figures
U = 2;                 % upsampling factor
D = 3;                 % downsampling factor
f = 500;               % cosine frequency
r = 2400;              % sample rate, samples/sec (Hz)
N = r/f                % number of sample points per cycle
scale=5; Nf = ceil(scale*N); % increase number of sample points (# cycles) for fft resolution improvement
nf = [0:Nf-1];      
x_n = cos(2*pi/N*nf);   % sampled signal

% plot continuous-time cosine overlaid with N samples/cycle
t = [0:0.2:Nf-1];      % higher resolution for continuous plot
x = cos(2*pi/N*t);
figure('position', fpv); subplot (2,1,1), plot(t,x,'m'), title('x(t) = cos(2\pi ft)'); 
subplot (2,1,2); hold on; plot(t,x,'m'); stem(nf,x_n),title('x[n] = cos(2\pi f T_s)'), hold off; 

temp = [x_n; zeros(U-1,length(x_n))]; y_n=temp(:)';  % y_n is x_n upsampled (zero-stuffed) by factor U
ny = length(y_n);

figure('position', fpv), subplot(2,1,1), stem(nf,x_n),title('x[n] = cos(2\pi f T_s)'), 
  subplot(2,1,2), stem([0:ny-1],y_n,'r'), title('y_U[n] (upsampled x[n])'); 
w = linspace(-pi,pi,Nf); wy = linspace(-pi,pi,ny);   % frequency omega range 

% calculate ffts (DFT)
fx = fft(x_n); fx = fftshift(fx);  % fftshift(): show plot with freq 0 in center
fy = fft(y_n); fy = fftshift(fy); 
% draw smooth plots of DFTs 
figure('position', fpv); hold on; axis tight, title('FFTs X[n] and Y_U[n]'),
 plot(w,abs(fx/Nf), 'LineWidth', 2),        % scale ffts by 1/Nf to get proper magnitude
 plot(wy,abs(fy/Nf),'LineWidth', 2),xlabel('Frequency'),ylabel('Zero-stuffed Magnitude'),hold off;

% interpolate via lowpass in freq domain (zero out fft frequency values > pi/U, scale remaining values by U)
zcount = ceil((length(fy) - length(fy)/U)/2);  % # of values to replace with zeros on each end 
fyLP = [zeros(1,zcount), U*fy(1+zcount: length(fy) - zcount), zeros(1,zcount)];

% draw smooth plots of DFTs 
figure('position', fpv);  axis tight; % hold on;
% plot(w,abs(fx/Nf), 'LineWidth', 2);     % re-plot X(e^jW) 
plot(wy,abs(fyLP/Nf), 'r', 'LineWidth', 2),xlabel('Frequency'), title('Interpolated spectrum Y_{UI}[n]')

% transform back to time domain y[n], and plot the interpolated signal
yi = ifft(fftshift(fyLP));
figure('position', fpv); stem([0:ny-1],real(yi),'r'), title('Interpolated signal y_{UI}[n]')

% downsample by factor D, and plot
yd = yi(1:D:length(yi));   nydvec = [0:length(yd)-1];
figure('position', fpv); stem(nydvec,real(yd),'m'), title('Downsampled signal y_D[n]')
% plot downsampled signal overlaid with continuous cosine to validate frequency
t = [0:0.1:length(yd)-1];
xyd = cos(2*pi*t*scale/length(yd));   
figure('position', fpv); hold on; plot(t,xyd,'b'), title('Downsampled y_D[n] and cos(2\pi *500t)'),
  stem(nydvec,real(yd),'m'); hold off; 

% get frequency spectrum of downsampled signal
fyd = fft(yd); fyd = fftshift(fyd); 
wyd = linspace(-pi,pi,length(fyd)); % frequency omega range 
figure('position', fpv),axis tight,plot(wyd,abs(fyd/length(fyd)),'r','LineWidth',2), 
  xlabel('Frequency'), title('Downsampled magnitude')
% file: e10_4_down_clown4_.m  
% Show effects of downsampling image, with and without lowpass filtering
close all; clear; set(0,'defaultaxesfontsize',14); % close images, free memory
x = double(imread('clown.png')); clown = x/max(x(:)); % normalize image to 1.0 max
L = 4;                        % downsampling factor
figure; imagesc(clown), colormap(gray), title('Original');
Yd1= clown(1:L:end,1:L:end);  % downsampled version, no filtering
figure; imagesc(Yd1),title("Unfiltered, downsampled"),colormap(gray)

% examine some pixel details, near clown's left eye
row1 = 77;  row2 = row1+L; col1 = 161; col2 = col1 + 4*L; % pixel locations
row1d = (row1+L-1)/L; col1d = (col1+L-1)/L;               % downsampled pixel indices 
samp1 = clown(row1:row2, col1:col2);
sampd = Yd1(row1d:row1d+1,col1d:col1d+L); 
clims = [0.1 1]; % color limits to make different range imagesc() map same pixels to same color
figure; imagesc(samp1,clims), colormap(gray), title("Eye pixels, rows "+row1+" - "+ row2)
figure; imagesc(sampd,clims), colormap(gray), title("Downsampled eye pixels, rows "+row1d+" - "+ (row1d+1))

% try filtering AFTER downsampling, for comparison
s = size(Yd1)  % size() returns [rows, columns] dimensions of matrix
FXd=fft2(Yd1);
denom = 3;      % cutoff frequency Omega_C = 2*pi/denom
L1d= round(s(1)/denom); L2d = round(s(2)/denom); % smaller L1 means more filtering (more zeros)
FYd1=FXd;
FYd1(:,L2d:s(2)-L2d)=0; FYd1(L1d:s(1)-L1d,:)=0;  %zero the frequencies greater than L1 and L2
% note: in the unshifted FFT2, the high frequencies are in the middle of the omega-plane!
Yd1=real(ifft2(FYd1));
figure; imagesc(Yd1),colormap(gray), title("LP filtered after downsampling");

s = size(clown)  % size() returns [rows, columns] dimensions of matrix
FX=fft2(clown);  % filter original image in wavenumber space
denom = 2*L;       % cutoff frequency Omega_C = 2*pi/denom  (denom = 2*L = 2*4 gives pi/4 cutoff)
L1= round(s(1)/denom); L2 = round(s(2)/denom); % smaller L1 means more filtering (more zeros)
FY=FX;
FY(:,L2:s(2)-L2)=0; FY(L1:s(1)-L1,:)=0;  % zero the frequencies greater than L1 and L2
Y=real(ifft2(FY));
figure; imagesc(Y),colormap(gray), title("LP filtered original");
Yd = Y(1:L:end,1:L:end);  % downsample filtered image
figure; imagesc(Yd),title("Downsampled after LP filtered"),colormap(gray)

% plot the filtered spectra
clims =[0,5]; % constrain color range. Logs are -2 to +9, but we want more grayshades for the middle values
figure; imagesc(log(abs(fftshift(FY))),clims), colormap(gray),title('log of original with LP filter Y_{LP}(W1,W2)')
figure; imagesc(log(abs(fftshift(fft2(Yd)))),clims), colormap(gray),title('log of downsampled after filtering, Yd(W1,W2)')

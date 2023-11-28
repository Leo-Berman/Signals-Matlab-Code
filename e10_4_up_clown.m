% file: e10_4_up_clown.m 
% Show effects of upsampling a downsampled image, with and without interpolation
close all; clear; set(0,'defaultAxesFontSize',13);    % close images, free memory
x = double(imread('clown.png')); clown = x/max(x(:)); % normalize image to 1.0 max
L = 4;        % downsampling factor
figure; imagesc(clown), colormap(gray), title('Original');
clims =[0,5]; % constrain color range for log freq plots. Logs are -2 to +9, but we want more grayshades for the middle values

s = size(clown)  % size() returns [rows, columns] dimensions of matrix
FX=fft2(clown);  % filter original image in wavenumber space
figure; imagesc(log(abs(fftshift(FX))),clims), colormap(gray),title('log of original FX(\Omega_1,\Omega_2)')

fac = 2*L;       % cutoff frequency Omega_C = 2*pi/fac  (fac = 2*L = 2*4 gives pi/4 cutoff)
L1= round(s(1)/fac); L2 = round(s(2)/fac); % smaller L1 means more filtering (more zeros)
FY=FX;
FY(:,L2:s(2)-L2)=0; FY(L1:s(1)-L1,:)=0;  % zero the frequencies greater than L1 and L2
Y=abs(ifft2(FY));
figure; imagesc(Y),colormap(gray), title("LP filtered original");

Yd = Y(1:L:end,1:L:end);  % downsample filtered image
figure; imagesc(Yd),title("Downsampled after LP filtered"),colormap(gray)
% plot the filtered spectra
figure; imagesc(log(abs(fftshift(FY))),clims), colormap(gray),title('log of original with LP filter Y_{LP}(\Omega_1,\Omega_2)')
figure; imagesc(log(abs(fftshift(fft2(Yd)))),clims), colormap(gray),title('log of downsampled after filtering, Yd(\Omega_1,\Omega_2)')

%upsample the downsampled image
u = 4;
upzeros = zeros(u); upzeros(1,1) = 1;
Yup = kron(Yd,upzeros);      % interleaves u-1 zeros with values of Y, in both directions
figure; imagesc(Yup),title("Upsampled"),colormap(gray)

Yupdup = kron(Yd,ones(u));   % replicates each value of Y, in both directions u times (zero-order hold)
figure; imagesc(Yupdup),title("Upsampled, replicated"),colormap(gray)

% interpolate upsampled zero-stuffed image via LP filter
fac = 2*u;                  % larger fac means lower omega cutoff frequency
s = size(Yup)
FYu = fft2(Yup);
figure; imagesc(log(abs(fftshift(FYu))),clims), colormap(gray),title('log of upsampled Yu(\Omega_1,\Omega_2)')
FYud = fft2(Yupdup);
figure; imagesc(log(abs(fftshift(FYud))),clims), colormap(gray),title('log of upsampled replicated Y(\Omega_1,\Omega_2)')

L1u= round(s(1)/fac); L2u = round(s(2)/fac); % smaller L1 means more filtering (more zeros)
FYu(:,L2u:s(2)-L2u)=0; FYu(L1u:s(1)-L1u,:)=0; 

YupLP=abs(ifft2(FYu));   
clims = [0 1]; % color limits for comparing images with and without scaling
figure; imagesc(YupLP, clims),title("Upsampled, LP filter interpolated, without L_1*L_2 scaling"),colormap(gray)
YupLPs = YupLP.*(u*u); % Due to zero-stuffing reducing total energy, multiply by u*u to restore original amplitude after LP filtering
figure; imagesc(YupLPs, clims),title("Upsampled, LP filter interpolated"),colormap(gray)
figure; imagesc(log(abs(fftshift(FYu))),clims), colormap(gray),title('log of upsampled with LP filter Yu_{LP}(\Omega_1,\Omega_2)')

% interpolate upsampled image via linear interpolation
Yupdup2 = [Yupdup(:,(u):end) Yupdup(:,(end-u+2):end)];
Yupinterp = (Yupdup2 + Yupdup)/2;     % interpolate upsampled values horizontally (nonlinear unless u=2)
Yupdup3 = [Yupinterp((u):end,:) ; Yupinterp((end-u+2):end,:)];
Yupinterpv = (Yupdup3 + Yupinterp)/2; % interpolate upsampled values vertically also
figure; imagesc(Yupinterpv),title("Upsampled, linearly interpolated"),colormap(gray)

% examine some upsampled pixel details, near clown's left eye
row1 = 77;  row2 = row1+L; col1 = 161; col2 = col1 + 3*L; % pixel locations
samp1 = clown(row1:row2, col1:col2);
sampLP = Y(row1:row2, col1:col2);
sampu = YupLPs(row1:row2, col1:col2); 
clims = [0.1 1]; % color limits to make different range imagesc() map same pixels to same color
figure; imagesc(samp1,clims), colormap(gray), title("Original eye pixels, rows " + row1 + "-" + row2)
figure; imagesc(sampLP,clims), colormap(gray), title("Original LP filtered eye pixels")
figure; imagesc(sampu,clims), colormap(gray), title("Upsampled filtered eye pixels")

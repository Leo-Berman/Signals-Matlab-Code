% Demo 2D wavelet transform for Daubechies D1, D2, and D3, similar to Labview Mod 10.4
% file: e10_13_D3_wavelet2p.m      
clear; close all;                       % clear previous images from memory, close all figures
X = linspace(3,16,64); X = X'* (X-3);  X(50,:) = 250; X(:,40) = 170;  % simple test image, 64x64
%X = double(imread('clown.png'));       % imread() reads .png, .bmp, .jpg, .gif files
%X = double(imread('letters.bmp'));          
%X = X/max(X(:));                       % normalize to 1.0 max (not needed)
fpv1 = [10 10 300 280]; set(0,'defaultAxesFontSize',14);  % figure position and font
fpv3 = [100 100 1100 280]; fpv4 =[1 600 700 640]; 
figure('position', fpv1); imagesc(X), colormap gray, title('Original x[m,n]');  % display with axes
threshold = 0.0;  % value below which transformed pixels get forced to zero.  Set this = 0 to avoid thresholding.
threshold2 = 0.05; % value for counting pixels below threshold

G=[sqrt(2)/2, sqrt(2)/2];   % D1 Daubechies (Haar) filter
%G=[1/2, 1/2];              % similar to D1, but does NOT allow good reconstruction. Keeps max pix value < 255
%G=[0.483, 0.8365, 0.2241, -0.1294];                     %D2 Daubechies filter
%G=[0.3327, 0.8069, 0.4599, -0.1350, -0.0854, 0.0352];   %D3 Daubechies filter
L=length(G); H=fliplr(G).*(-1).^[0:L-1];

[XLL1, XLH1, XHL1, XHH1] = wave(G,H,X);     % 1st Stage Wavelet Transform
XX1 = [XLL1, XLH1; XHL1, XHH1];             % compile collage image

[XLL2, XLH2, XHL2, XHH2] = wave(G,H,XLL1);  % 2nd Stage Wavelet Transform
XX2 = [XLL2, XLH2; XHL2, XHH2];             % compile collage image
XX2 = [XX2, XLH1; XHL1, XHH1];  

[XLL3, XLH3, XHL3, XHH3] = wave(G,H,XLL2);  % 3rd Stage Wavelet Transform
XX3=[XLL3 XLH3;XHL3 XHH3];                  % compile collage image
XX3=[XX3 XLH2;XHL2 XHH2]; XX3=[XX3 XLH1;XHL1 XHH1];

pixelRange_X = [min(X(:)) mean(X(:))  max(X(:))]   % get image statistics
pixelRange_XX1 = int32([min(XX1(:)) mean(XX1(:))  max(XX1(:))])   
pixelRange_XX2 = int32([min(XX2(:)) mean(XX2(:))  max(XX2(:))])   
pixelRange_XX3 = int32([min(XX3(:)) mean(XX3(:))  max(XX3(:))])   

non0pixcount_X = pix_thresh_count(X, threshold2)  % count values greater than threshold
non0pixcount_XX1 = pix_thresh_count(XX1, threshold2)
non0pixcount_XX2 = pix_thresh_count(XX2, threshold2)
non0pixcount_XX3 = pix_thresh_count(XX3, threshold2)

figure('position', fpv4),   % draw all levels transformed
 subplot(2,2,1),imagesc(abs(XLL1)),colormap gray, title('XLL1');
 subplot(2,2,2),imagesc(abs(XLH1)),title('XLH1'); subplot(2,2,3),imagesc(abs(XHL1)),title('XHL1'); 
 subplot(2,2,4),imagesc(abs(XHH1)),title('XHH1'); 
figure('position', fpv4),
 subplot(2,2,1),imagesc(abs(XLL2)),colormap gray, title('XLL2');
 subplot(2,2,2),imagesc(abs(XLH2)),title('XLH2'); subplot(2,2,3),imagesc(abs(XHL2)),title('XHL2'); 
 subplot(2,2,4),imagesc(abs(XHH2)),title('XHH2'); 
figure('position', fpv4),
 subplot(2,2,1),imagesc(abs(XLL3)),colormap gray, title('XLL3');
 subplot(2,2,2),imagesc(abs(XLH3)),title('XLH3'); subplot(2,2,3),imagesc(abs(XHL3)),title('XHL3'); 
 subplot(2,2,4),imagesc(abs(XHH3)),title('XHH3'); 
% draw transformed collage images
figure('position', fpv3), subplot(1,3,1), imagesc(abs(XX1)), colormap gray, title('1 stage');
 subplot(1,3,2), imagesc(abs(XX2)),title('2 stage'); subplot(1,3,3), imagesc(abs(XX3)),title('3 stage');
figure('position', fpv3),subplot(1,3,1),imagesc(log(abs(XX1))), colormap gray, title('1 stage (log)');
 subplot(1,3,2),imagesc(log(abs(XX2))),title('2 stage (log)');
 subplot(1,3,3),imagesc(log(abs(XX3))),title('3 stage (log)');

if (threshold > 0)  % optionally zero the near-zero pixels to sparsify matrix, to allow compression:
 [XLH3,XHL3,XHH3] = zero_thresh(XLH3,XHL3,XHH3, threshold);
 [XLH2,XHL2,XHH2] = zero_thresh(XLH2,XHL2,XHH2, threshold);
 [XLH1,XHL1,XHH1] = zero_thresh(XLH1,XHL1,XHH1, threshold);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%Inverse Wavelet Transform (image synthesis) of {XLL3,XLH?,XHL?,XHH?}
ZLL2 = synth(G,H, XLL3, XLH3, XHL3, XHH3);  %3rd Stage Reconstruction
ZLL1 = synth(G,H, ZLL2, XLH2, XHL2, XHH2);  %2nd Stage Reconstruction (uses ZLL from previous stage)
ZLL0 = synth(G,H, ZLL1, XLH1, XHL1, XHH1);  %1st Stage Reconstruction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%compare original to reconstruction:
if (~isfloat(X))    ZLL0 = uint8(ZLL0);  end;    % if input array was UINT8, convert output to match
diff = abs(X - ZLL0);mean_abs_error = mean(diff(:)),maxerror = max(diff(:))
percenterror=mean_abs_error/mean(X(:))*100

figure('position', fpv4),subplot(2,2,3), imagesc(ZLL0), colormap gray, title('Synthesized x^{(0)}_{LL}[m,n]');
 subplot(2,2,2),imagesc(ZLL1),title('Synthesized x^{(1)}_{LL}[m,n]');
 subplot(2,2,1),imagesc(ZLL2),title("Synthesized x^{(2)}_{LL}[m,n], D"+L/2);
 subplot(2,2,4),imagesc(diff),title('Errors: |x[m,n] - x^{(0)}_{LL}[m,n]|');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
function [XLL, XLH, XHL, XHH] = wave(G,H,X) % wavelet transform, 1 stage. Returns downsampled matrices
  L = length(G);  
  P = padarr(X, L);   % pad X with duplicated borders to minimize convolution artifacts
  XLL = conv2(G,G,P,'same'); XLL = XLL(L:2:end-L, L:2:end-L); % convolve, strip padding, and downsample by 2
  XHH = conv2(H,H,P,'same'); XHH = XHH(L:2:end-L, L:2:end-L);
  XHL = conv2(H,G,P,'same'); XHL = XHL(L:2:end-L, L:2:end-L);
  XLH = conv2(G,H,P,'same'); XLH = XLH(L:2:end-L, L:2:end-L);
end % function wave
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
function Z = synth(G,H, XLL, XLH, XHL, XHH) % image synthesis, one stage. Returns upsampled by 2 matrix
  GM = flip(G);  HM = flip(H);  % g[-m] and h[-m]
  up = [1 0; 0 0];              % 2x2 upsample kron matrix
  L = length(G); L2=2*(L-1); % amount to strip after pad is 2*(L-1)
  % pad images with duplicated borders to minimize convolution artifacts:
  XLL = padarr(XLL, L); XLH = padarr(XLH, L); XHL = padarr(XHL, L); XHH = padarr(XHH, L);
  %upsample, then convolve, then strip padding
  ALL = kron(XLL, up); ALL = conv2(GM,GM,ALL,'same'); ALL= ALL(L2+1:end-L2, L2+1:end-L2);
  ALH = kron(XLH, up); ALH = conv2(GM,HM,ALH,'same'); ALH= ALH(L2+1:end-L2, L2+1:end-L2);
  AHL = kron(XHL, up); AHL = conv2(HM,GM,AHL,'same'); AHL= AHL(L2+1:end-L2, L2+1:end-L2);
  AHH = kron(XHH, up); AHH = conv2(HM,HM,AHH,'same'); AHH= AHH(L2+1:end-L2, L2+1:end-L2);
 
 figure('position', [1 400 700 640]),  % see reconstruction partial results
  subplot(2,2,1),imagesc(abs(ALL)), colormap gray, title('ALL');
  subplot(2,2,2),imagesc(abs(ALH)), title('ALH'); subplot(2,2,3),imagesc(abs(AHL)),title('AHL'); 
  subplot(2,2,4),imagesc(abs(AHH)),title('AHH'); 
  Z = ALL + ALH + AHL + AHH; %Average signal is the sum of the above four outputs
  % correct for shift from convolutions by replicating 1st row, col. Works best for G1, but improves G2, G3:
  Z = [Z(1,:); Z(1:end-1, :)]; Z = [Z(:,1) Z(:,1:end-1)];
  end % function synth
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
function count = pix_thresh_count(X, threshold) % count values in X greater than threshold * max of X
 thresh = threshold*max(abs(X(:)));
 count = sum(abs(X(:)) > thresh);
end  %function pix_thresh_count
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
function [ZLH ZHL ZHH] = zero_thresh(XLH, XHL,XHH, threshold) % zero values < threshold in 3 matrices 
 ZLH = XLH; ZLH(abs(ZLH) < (threshold*max(abs(ZLH(:))))) = 0;
 ZHL = XHL; ZHL(abs(ZHL) < (threshold*max(abs(ZHL(:))))) = 0;
 ZHH = XHH; ZHH(abs(ZHH) < (threshold*max(abs(ZHH(:))))) = 0;
end  %function pix_thresh_count
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Z = padarr(X, L) % padd array Y on all sides with L-1 copies of borders (similar to padarray() in image toolbox)
 Z = [repmat(X(1,:),L-1,1); X; repmat(X(end,:),L-1,1)];  Z = [repmat(Z(:,1),1,L-1) Z repmat(Z(:,end),1,L-1)];
end  %function padarr
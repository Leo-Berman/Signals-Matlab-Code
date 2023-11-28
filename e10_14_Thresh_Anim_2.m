% file: e10_14_Thresh_Anim_2.m    De-noising images using D1 and D3, thresholding, shrinkage
% Add noise to image, then threshold to reduce noise. 
% Threshold  small values of wavelet xform (those less than T*pix_max_value) to 0.
% Shrink all other values of wavelet xform by T*pix_max_value.
clear; close all;
fpv2 =[1 300 470 190];fpv4 =[1 200 470 450]; set(0,'defaultAxesFontSize',12);

%G=[sqrt(2)/2, sqrt(2)/2];  % D1 Daubechies (Haar) filter
%G=[0.483, 0.8365, 0.2241, -0.1294];                    %D2 Daubechies filter
G=[0.3327, 0.8069, 0.4599, -0.1350, -0.0854, 0.0352];   %D3 Daubechies filter
L=length(G); H=fliplr(G).*(-1).^[0:L-1];

X = double(imread('clown.png')); % imread() reads .png, .bmp, .jpg, .gif files, but returns uint8
%X = linspace(1,16,64); X = X'* (X);  X(20:24,:) = 254; X(:,15:19) = 170;  % simple test image, 64x64
s = size(X); x2_mean = mean(mean(X.^2))
noise = 30*randn(s(1),s(2));  % add noise.  randn() returns numbers between -4 and 4.
XN = X + noise; noise2_mean= mean(mean(noise.^2)), SNR = x2_mean/noise2_mean, SNRdB= 10*log10(SNR)
figure('position', 2*fpv2),
  subplot(1,2,1), imagesc(X),colormap(gray), title('Original image')
  subplot(1,2,2), imagesc(XN),colormap(gray), title('Image + noise')
Tmin = 0.01;      % Threshold (range 0 to 1) for XLH?,XHL?,XHH? (not XLL3)
Tincrement = 0.05; Tmax= Tmin + 5*Tincrement;

[XLL1, XLH1, XHL1, XHH1] = wave(G,H,XN);   %1st stage decomposition
[XLL2, XLH2, XHL2, XHH2] = wave(G,H,XLL1); %2nd stage decomposition
[XLL3, XLH3, XHL3, XHH3] = wave(G,H,XLL2); %3rd stage decomposition

figure('position', fpv4),   
 subplot(2,2,1),imagesc(XLH1),colormap gray, title('x_{LH}^{(1)} before denoise');
 subplot(2,2,2),imagesc(XLH3),title('x_{LH}^{(3)} before denoise'); 
 subplot(2,2,3),imagesc(XHL1),title('x_{HL}^{(1)} before denoise'); 
 subplot(2,2,4),imagesc(XHL3),title('x_{HL}^{(3)} before denoise');
 
figure('position', fpv4),   
 subplot(2,2,1),imagesc(XLL1),colormap gray, title('x_{LL}^{(1)}');
 subplot(2,2,2),imagesc(XLH1),title('x_{LH}^{(1)}'); 
 subplot(2,2,3),imagesc(XHL1),title('x_{HL}^{(1)}'); 
 subplot(2,2,4),imagesc(XHH1),title('x_{HH}^{(1)}'); 
figure('position', 1.5*fpv4),   
 subplot(2,2,1),imagesc(XLL2),colormap gray, title('x_{LL}^{(2)}');
 subplot(2,2,2),imagesc(XLH2),title('x_{LH}^{(2)}'); 
 subplot(2,2,3),imagesc(XHL2),title('x_{HL}^{(2)}'); 
 subplot(2,2,4),imagesc(XHH2),title('x_{HH}^{(2)}'); 
figure('position', 1.5*fpv4),   
 subplot(2,2,1),imagesc(XLL3),colormap gray, title('x_{LL}^{(3)}');
 subplot(2,2,2),imagesc(XLH3),title('x_{LH}^{(3)}'); 
 subplot(2,2,3),imagesc(XHL3),title('x_{HL}^{(3)}'); 
 subplot(2,2,4),imagesc(XHH3),title('x_{HH}^{(3)}'); 
 
%Threshold small values (<T) of detail images XLH?,XHL?,XHH? to 0, and shrink remaining values by T. 
for T=Tmin:Tincrement:Tmax
  Thresh = T; % round(T*PixMax) 
  [YHL1 YLH1 YHH1] = ThreShrink(XHL1, XLH1, XHH1, Thresh);
  [YHL2 YLH2 YHH2] = ThreShrink(XHL2, XLH2, XHH2, Thresh);
  [YHL3 YLH3 YHH3] = ThreShrink(XHL3, XLH3, XHH3, Thresh);
 figure('position', fpv4),  
 subplot(2,2,1),colormap gray,imagesc(YLH1),title("x_{LH}^{(1)} denoised, T="+T); 
 subplot(2,2,2),imagesc(YLH3),title('x_{LH}^{(3)} denoised'); 
 subplot(2,2,3),imagesc(YHL1),title('x_{HL}^{(1)} denoised');
 subplot(2,2,4),imagesc(YHL3),title('x_{HL}^{(3)} denoised'); 
  
%Inverse wavelet transform
  WLL2 = synth(G,H,XLL3,YLH3,YHL3,YHH3);
  WLL1 = synth(G,H,WLL2,YLH2,YHL2,YHH2);
  W =    synth(G,H,WLL1,YLH1,YHL1,YHH1);
  figure('position', [1,200,500,460]),imagesc(W),colormap(gray), title("Denoised, T = "+T)
end

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
function Z = synth(G,H,XLL,XLH,XHL,XHH) % image synthesis, one stage. Returns upsampled by 2 matrix
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
 
  Z = ALL + ALH + AHL + AHH; %Average signal is the sum of the above four outputs
  % correct for shift from convolutions by replicating 1st row, col. Works best for G1, but improves G2, G3:
  Z = [Z(1,:); Z(1:end-1, :)]; Z = [Z(:,1) Z(:,1:end-1)];
  end % function synth
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Z = padarr(X, L) % padd array Y on all sides with L-1 copies of borders (similar to padarray() in image toolbox)
 Z = [repmat(X(1,:),L-1,1); X; repmat(X(end,:),L-1,1)];  Z = [repmat(Z(:,1),1,L-1) Z repmat(Z(:,end),1,L-1)];
end  %function padarr
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
function [ZHL ZLH ZHH] = ThreShrink(ZHL, ZLH, ZHH, Th)    % zero values in 3 matrices whose |magnitude|<T
 T = Th*max(abs(max(ZHL(:))),abs(max(ZLH(:))))  %scale thresh for this image; assumes HL, LH, HH similar ranges
 ZHL(abs(ZHL)<T)=0;  ZLH(abs(ZLH)<T)=0;  ZHH(abs(ZHH)<T)=0;
if(1)  % set to (1) to shrink, or (0) to not shrink, only thresholding
 ZHL(abs(ZHL)>T)=ZHL(abs(ZHL)>T)-T*sign(ZHL(abs(ZHL)>T)); % shrink remaining values in 3 matrices by T
 ZLH(abs(ZLH)>T)=ZLH(abs(ZLH)>T)-T*sign(ZLH(abs(ZLH)>T));
 ZHH(abs(ZHH)>T)=ZHH(abs(ZHH)>T)-T*sign(ZHH(abs(ZHH)>T));
end 
end % function ThreShrink


% file: e10_14_ThresHaar_.m    De-noising images using Haar, thresholding, shrinkage
% Add noise to letters (or other image) then threshold to reduce noise. 
% Threshold  small values of wavelet xform (those less than T*pix_max_value) to 0.
% Shrink all other values of wavelet xform by T*pix_max_value.
clear; close all; set(0,'defaultAxesFontSize',13);
X = imread('letters.bmp');    % this .bmp has uint8 pix values 0 to 255
%X = linspace(3,16,64); X = X'* (X-3); X(50:55,:) = 250; X(:,40:45) = 170; % simple test image,32x32

s = size(X);
XN = double(X) + 40*randn(s(1),s(2));  % add noise. randn() returns numbers between -4 and 4.
T = 0.11;      % Threshold (range 0 to 1) for XLH?,XHL?,XHH? (not XLL3)

[ZLL1, ZLH1, ZHL1, ZHH1] = HaarWave(XN);   %1st stage decomposition
[ZLL2, ZLH2, ZHL2, ZHH2] = HaarWave(ZLL1); %2nd stage decomposition
[ZLL3, ZLH3, ZHL3, ZHH3] = HaarWave(ZLL2); %3rd stage decomposition

%Threshold small values (<T) of detail images XLH?,XHL?,XHH? to 0, and shrink remaining values by T.
[ZHL1 ZLH1 ZHH1] = ThreShrink(ZHL1, ZLH1, ZHH1, T);
[ZHL2 ZLH2 ZHH2] = ThreShrink(ZHL2, ZLH2, ZHH2, T);
[ZHL3 ZLH3 ZHH3] = ThreShrink(ZHL3, ZLH3, ZHH3, T);

%Inverse Haar 
WLL2 = HaarSynth(ZLL3,ZLH3,ZHL3,ZHH3);
WLL1 = HaarSynth(WLL2,ZLH2,ZHL2,ZHH2);
W =    HaarSynth(WLL1,ZLH1,ZHL1,ZHH1);

figure('position',[1 600 700 280]),
  subplot(1,2,1), imagesc(X),colormap(gray), title('Original image')
  subplot(1,2,2), imagesc(XN),colormap(gray), title('Image + noise')
figure,imagesc(W),colormap(gray), title("De-noised via Thresh/Shrink, T="+T)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ZLL, ZLH, ZHL, ZHH] = HaarWave(X) % do 1 stage Haar transform 
s = size(X); sc = 1/2;  %sc = scale to normalize Haar
Z = sc*X;
row1col1 = Z(1:2:s(1),1:2:s(2)); row2col2= Z(2:2:s(1),2:2:s(2));  % create 4 downsampled matrices
row1col2 = Z(1:2:s(1),2:2:s(2)); row2col1 = Z(2:2:s(1),1:2:s(2)); % the corners of 2x2 pix blocks
ZLL = row2col2 + row1col1 + row1col2 + row2col1;  % accomplish convolution via adding/subtracting
ZLH = row1col2 + row2col2 - row1col1 - row2col1;  % column difference
ZHL = row2col1 + row2col2 - row1col1 - row1col2;  % row difference
ZHH = row1col1 + row2col2 - row1col2 - row2col1;  % diagonal difference
end % function HaarWave
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
function Z = HaarSynth(ZLL, ZLH, ZHL, ZHH) % Haar image synthesis, one stage. Returns upsampled by 2 matrix
s = 2*size(ZLL);
% upsample, then fill each 2x2 pixel block
Z(2:2:s(1),2:2:s(2))=(ZLL+ZLH+ZHL+ZHH)/2; % upsample, set even rows and columns = 1/2 of sum of inputs
Z(2:2:s(1),1:2:s(2))=(ZLL-ZLH+ZHL-ZHH)/2; % set even rows and odd columns = 1/2 of sum/diff of inputs
Z(1:2:s(1),2:2:s(2))=(ZLL+ZLH-ZHL-ZHH)/2; % set odd rows and even columns = 1/2 of sum/diff of inputs
Z(1:2:s(1),1:2:s(2))=(ZLL-ZLH-ZHL+ZHH)/2; % set odd rows and odd columns = 1/2 of sum/diff of inputs
end % function HaarSynth
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
function [ZHL ZLH ZHH] = ThreShrink(ZHL, ZLH, ZHH, Th)    % zero values in 3 matrices whose |magnitude|<T
 T = Th*max(abs(max(ZHL(:))),abs(max(ZLH(:))))  %scale thresh for this image; assumes HL, LH, HH similar ranges
 ZHL(abs(ZHL)<T)=0;  ZLH(abs(ZLH)<T)=0;  ZHH(abs(ZHH)<T)=0;
 ZHL(abs(ZHL)>T)=ZHL(abs(ZHL)>T)-T*sign(ZHL(abs(ZHL)>T)); % shrink remaining values in 3 matrices by T
 ZLH(abs(ZLH)>T)=ZLH(abs(ZLH)>T)-T*sign(ZLH(abs(ZLH)>T));
 ZHH(abs(ZHH)>T)=ZHH(abs(ZHH)>T)-T*sign(ZHH(abs(ZHH)>T));
end % function ThreShrink
%file: e10_6_Laplacian_edge1.m   
% read image file, use Laplacian to edge detect
clear; close all; set(0,'defaultAxesFontSize',13);
X1 = imread('letters.bmp'); % this .bmp has uint8 pix values 0 to 255
X = rescale(X1);            % scale pixel values to 0 to 1 double precision

h = [0 1 0; 1 -4 1; 0 1 0]  % Laplacian matrix
Y=conv2(h,X);
figure('position',[100,100,1100,800]),
 subplot(2,3,1), imagesc(X), colormap(gray), title('Original');

for n = 1:5
  threshold = 0.4*n + 0.6    % try tresholds from 1 to 2.6
  Yedge = (abs(Y)>=threshold); % convert to 2-color edge (logical) image
  subplot(2,3,n+1),imagesc(Yedge),colormap(gray),
    title(strcat('Edge detect threshold = ',num2str(threshold)))
end
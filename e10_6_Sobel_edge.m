% file: e10_6_Sobel_edge.m  
% Demonstrate Sobel edge detection convolution at various thresholds for various images
clear; close all; set(0,'defaultAxesFontSize',13);
Hh = [1 0 -1; 2 0 -2; 1 0 -1]  % vertical edge detector, HORIZONTAL direction, vertical zeros
Hv = Hh'                       % horizontal edge detector,VERTICAL direction, row of zeros
figure('position', [300 400 400 150]),
subplot(121),imagesc(Hh),colormap(gray), title('h_H')
subplot(122),imagesc(Hv),colormap(gray), title('h_V')

X1 = [1 2 1 1; 1 2 1 1; 1 2 1 1 ; 1 2 1 1]  % image matrix, just a vertical line
% X1 = [ 1 1 1 1; 1 1 1 1; 2 2 2 2 ; 1 1 1 1]  % image matrix, just a horizontal line
% image matrix, vertical and horizontal lines (L shape, 7x7):
% X1 =[1,1,1,1,1,1,1;1,1,1,2,1,1,1;1,1,1,2,1,1,1;1,1,1,2,1,1,1;1 1 1 2 2 2 2;1,1,1,1,1,1,1;1,1,1,1,1,1,1]      
% X1 = [1 1 1 1 1; 1 1 2 1 1 ; 1 1 2 1 1; 1 1 2 1 1; 1 1 2 2 2; 1 1 1 1 1] % 6x5 version of L  
% X1 = imread('clown.png');             % try with clown image

X2 =  [X1(1,:); X1; X1(end,:)];            % padded image matrix extra rows at top, bottom
X22 = [X2(:,1) X2  X2(:,end)];             % padded image matrix extra cols/rows at all edges
figure('position', [100 200 400 150]),
subplot(121),imagesc(X1),colormap(gray), title("Original image")
subplot(122),imagesc(X22),colormap(gray), title("Padded image")

Dh=conv2(Hh,X22)         % apply horizontal direction vert edge detector
Dh = Dh(3:end-2,3:end-2) % discard margin pixels at borders, restoring size of original image 
Dv=conv2(Hv,X22)         % apply vertical direction horiz edge detector
Dv = Dv(3:end-2,3:end-2)
g = sqrt(Dv.^2 + Dh.^2); % compute gradient 
g_rounded = round(g)
figure, imagesc(g_rounded),colormap(gray), title("Gradient values")

for threshold = 1:1:5
 Z = (g>threshold)       % convert to 2-color edge image by comparing g to threshold 
 figure('position', [300*threshold 100 200 200]),
   imagesc(Z),colormap(gray), title(strcat('Edge indicator z, T=',num2str(threshold)))
end

% file: e10_1_imread.m                                        % Ways to read and display images 
clear; close all; set(0,'defaultAxesFontSize',13);            % close displayed figures  
IM = imread('zybooks.png'); % can read .png, .bmp, .jpg, .gif,... file, which must be in script’s folder 
% IM returned by imread() is a uint8 (byte) or uint16 matrix, dimensions = height x width x depth
%  if file was truecolor, depth = 3   (3-D matrix, the 3rd dimension is colors, R, G, and B)
%  if file was grayscale, depth = 1   (2-D matrix)
s = size(IM)                                                  % print and save image dimensions 
if length(s) > 2       % if 3 dimensions, a truecolor image
    X = rgb2gray(IM);  % convert truecolor to grayscale 2-D matrix X
else
    X = IM;
end                         

figure('position',[100,100,1200,500]), 
 subplot(2,3,1),imshow(IM),title('imshow() of full color original'); % full color image, native size
 subplot(2,3,2),image(IM),title('image() of full color original');   % full color image, larger, with axes
 subplot(2,3,3),imshow(X),title('imshow(X), after X = rgb2gray(RGB)');
 subplot(2,3,4),imagesc(X),title('imagesc(X), default colormap');
 subplot(2,3,5),imagesc(X),colormap(gray),title('imagesc(X),colormap(gray)');
                                % imagesc() scales pixel values, so smallest displays black, largest white
 subplot(2,3,6),image(X),colormap(gray),title('image(X)') % image() does not scale pixels; may show all white 

% redraw imagesc(X) in separate figure, as subplot colormap(gray) overrides the default for figure above
figure; imagesc(X),title('imagesc(X), default colormap');  

X2 = rescale(X);             % scales pixel values to 0 to 1 range, double precision, if needed
save X_file.mat X;           % saves X as data array to file, for processing later, with "load X_file.mat"
imwrite(IM, 'newfile.bmp');  % saves image as image file.  Supports .png, .bmp, .jpg, .gif,... types
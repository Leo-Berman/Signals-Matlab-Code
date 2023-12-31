% file: e10_3_FFT2_SA_PA.m
% generate Ln by Ln line image x[m,n]
% take FFT2, plot with and without fftshift()
clear; close all; set(0,'defaultAxesFontSize',13); fpv =[100 400 300 900]; % parameters for plots
Ln = 2;    % Side length of input image
 
x = ones(Ln); % array of ones Ln by Ln
s = size(x);
x(:,s(end)) = 10  %column of 10s
%x(round(Ln/4)+1:3*round(Ln/4),round(Ln/4)+1:3*round(Ln/4)) = 10* ones(round(Ln/2),round(Ln/2))  % square of 10s

Xs = fft2(x) % Ln points only, fft2 
Xss = fftshift(Xs)
figure('position',fpv), subplot(3,1,1),imagesc(x), colormap(jet), title('x matrix')
subplot(3,1,2), imagesc(abs(Xs)), title("X_s = fft2(x)")
subplot(3,1,3), imagesc(abs(Xss)), title("X_{ss} = fftshift(X_s)")

% calculate the intermediate 1-D column FFTs to show the intermediate results
Xi = fft(x) % fft(x) (instead of fft2(x)) just does individual 1-D ffts on columns

lenFFT = 80*Ln; % increase FFT2 resolution for prettier plots
X = (abs(fft2(x,lenFFT,lenFFT))); %DSFT of x matrix. Pads x matrix with zeros to size of lenFFT
figure('position',fpv), subplot(3,1,1),imagesc(x), colormap(jet), title('x matrix')
subplot(3,1,2), imagesc(X), title("X = fft2(x,"+lenFFT+","+lenFFT+")")
Xsh = fftshift(X); %DSFT of x matrix. Pads x matrix with zeros to size of lenFFT
subplot(3,1,3), imagesc(Xsh), title("X_{sh} = fftshift(X)")

fpv3 =[100 400 700 700];
figure('position',fpv3), 
subplot(2,2,1), surf(abs(Xs)), colormap(jet), shading interp, title("X_s = fft2(x_s)") % plot spectra as 3-D surfaces
subplot(2,2,2), surf(abs(Xss)), colormap(jet), shading interp, title("X_{ss} = fftshift(X_s)") 
subplot(2,2,3), surf(abs(X)), colormap(jet), shading interp, title("X = fft2(x,"+lenFFT+","+lenFFT+")") 
subplot(2,2,4), surf(abs(Xsh)), colormap(jet), shading interp, title("X_{sh} = fftshift(X)")    



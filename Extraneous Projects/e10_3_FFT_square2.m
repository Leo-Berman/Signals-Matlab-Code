% file: e10_3_FFT_square2.m       Generate Ln by Ln square image x[m,n]
% take FFT2, plot with and without fftshift(), both magnitude and phase

clear; close all; set(0,'defaultAxesFontSize',13); fpv =[100 400 300 900]; % parameters for plots
Ln = 8; Ln2 = round(Ln/2); Ln4 = round(Ln/4);       % Side length of square input image
x = zeros(Ln);                                      % array of zeros Ln by Ln
x(Ln/4+1:3*Ln4,Ln4+1:3*Ln4) = 10* ones(Ln2,Ln2);    % square of 10s

Xs = fft2(x)     % fft2 returns DFT of x matrix. 
Xss = fftshift(Xs)
figure('position',fpv), subplot(3,1,1),imagesc(x), colormap(jet), title('x matrix')
 subplot(3,1,2), imagesc(abs(Xs)), title("X_s = fft2(x)")
 subplot(3,1,3), imagesc(abs(Xss)), title("X_{ss} = fftshift(X_s)")

%  calculate 1-D column FFTs to show the intermediate results hidden inside fft2()
Xi = fft(x) % fft(x) (instead of fft2(x)) just does individual 1-D ffts on columns

lenFFT = 20*Ln;                   % increase FFT2 resolution for prettier plots
X = fft2(x,lenFFT,lenFFT);        % Pads x matrix with zeros to size of lenFFT
Xsh = fftshift(X); 
figure('position',fpv), 
 subplot(3,1,1), imagesc(abs(X)),colormap(jet), title("X = fft2(x,"+lenFFT+","+lenFFT+")"),
 subplot(3,1,2), imagesc(abs(Xsh)), title("X_{sh} = fftshift(X)"),
 subplot(3,1,3), imagesc(angle(Xsh)), title("Phase \phi of X_{sh}")
fpv3 =[100 400 1000 700]; figure('position',fpv3), % plot spectra as 3-D surfaces
 subplot(2,3,1), surf(abs(Xs)),colormap(jet), shading interp, title("X_s = fft2(x_s)"), 
 subplot(2,3,2), surf(abs(Xss)), shading interp, title("X_{ss} = fftshift(X_s)"), 
 subplot(2,3,3), surf(angle(Xss)), shading interp, title("Phase \phi of X_{ss}"), 
 subplot(2,3,4), surf(abs(X)), shading interp, title("X = fft2(x,"+lenFFT+","+lenFFT+")"), 
 subplot(2,3,5), surf(abs(Xsh)), shading interp, title("X_{sh} = fftshift(X)"),
 subplot(2,3,6), surf(angle(Xsh)), shading interp, title("Phase \phi of X_{sh}")
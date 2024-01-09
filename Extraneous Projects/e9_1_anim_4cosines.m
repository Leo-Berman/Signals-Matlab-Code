%file: e9_1_anim_4cosines.m  Rect and Hamming windows reveal presence of (4) cosines
clear; close all; set(0,'defaultAxesFontSize', 12);
L = 75;             % 75 samples
n1 = [0:L-1];       % the sample indices 
X1 = 7*cos(0.28*pi*n1+deg2rad(53));
X2 = 3*cos(0.54*pi*n1+deg2rad(45));
X3 = 13*cos(0.63*pi*n1+deg2rad(67));
X4 = 25*cos(0.73*pi*n1+deg2rad(73));
X = X1+X2+X3+X4;

N = 512;             % do 512-point FFT for smooth plots
FX=abs(fft(X,N))/L;  % FFT with rect window ( unity coefficients)
H = 0.54-0.46*cos(2*pi*[0:L-1]/(L-1)); % Hamming window
Y=X.*H;              % Signal times Hamming window
FY=abs(fft(Y,N))/L;% FFT with Hamming window

K=[0:N/2-1];  W=2*pi*K/N;   % W = frequency scale for plots
figure('position',[100,100,500,800]),
 subplot(311), % plot the time-domain x1 as samples and lines
   hold on, scatter(n1,X,'b','filled'), title('x[n] (sum of 4 cosines)'),
   plot(n1,X,'r','Linewidth',2),axis tight, hold off;
 subplot(312),plot(W,FX(K+1),'Linewidth',3),axis tight, title('X(w) (rectangular)'),
 subplot(313),plot(W,FY(K+1),'g','Linewidth',3),axis tight, title('Y(w) (Hamming)')

% stem-plot the sampling windows
figure, stem(n1,H,'k'),axis tight;
rect = ones(1,75);
figure, stem(n1,rect,'b'),axis tight;

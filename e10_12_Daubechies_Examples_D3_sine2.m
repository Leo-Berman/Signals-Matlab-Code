% e10_12_Daubechies_Examples_D3_sine2.m: Demonstrate Daubechies signals for sine input
clear; close all; set(0,'defaultAxesFontSize',13); 
fpv=[100 100 900 650]; fpv2=[100 700 300 140]; % figure positions

t= linspace(0,2*pi,32);                    % 32 times: 0, pi/16, pi/8,... to 2 pi
x = sin(t - pi/16); x = [x, sin(2*t)];     % 2 frequencies of sines
LX = length(x)                             % length of this x[n] is 2^N = 64
g = [0.3327, 0.8069, 0.4559, -0.1350 -0.0854 0.0352];     % D3 Daubechies scaling function
h = flip(g); h(2) = -h(2); h(4) = -h(4); h(6) = -h(6);    % D3 Daubechies wavelet function
%%%%%%%% uncomment the following 2 lines to do D2 instead of D3 wavelets  %%%%%%%%%%
%g = [0.483, 0.8365, 0.2241, -0.1294];     % D2 Daubechies scaling function
%h = flip(g); h(2) = -h(2); h(4) = -h(4);  % D2 Daubechies wavelet function

X1 = cconv(g,x,LX); X1 = X1(1:2:end)          % scaling: convolve with g, downsample
X2 = cconv(g,X1,length(X1)); X2 = X2(1:2:end) % convolve with g, downsample
X3 = cconv(g,X2,length(X2)); X3 = X3(1:2:end) % convolve with g, downsample (3rd level recursion)

x1 = cconv(h,x,LX); x1 = x1(1:2:end)          % wavelet (detail): convolve with h, downsample
x2 = cconv(h,X1,length(X1)); x2 =x2(1:2:end)  % convolve X1 with h, downsample
x3 = cconv(h,X2,length(X2)); x3 =x3(1:2:end)  % convolve X2 with h, downsample

n = 0:1:LX-1;  ng = [0:1:length(g)-1];        % n, ng, n2, n4, n6 = axis ranges for stem plots
n2 = 0:1:length(x1)-1; n4 = 0:1:length(X2)-1; n6 = 0:1:length(X3)-1;
figure('position',fpv),subplot(4,2,1),stem(n,x,'k','linewidth',2),title('x[n]') 
 subplot(4,2,3),stem(n2,X1, 'linewidth',2),title('X_1[n]')
 subplot(4,2,5),stem(n4,X2, 'linewidth',2),title('X_2[n]')
 subplot(4,2,4),stem(n2,x1,'r', 'linewidth',2),title('x_1[n]')
 subplot(4,2,6),stem(n4,x2,'r', 'linewidth',2),title('x_2[n]')
 subplot(4,2,7),stem(n6,X3,'linewidth',2),title('X_3[n]')
 subplot(4,2,8),stem(n6,x3, 'r','linewidth',2),title('x_3[n]')

figure('position',fpv2), subplot(1,2,1), stem(ng,g,'linewidth',2),title('g_{D3}[n]')
 subplot(1,2,2), stem(ng,h,'r','linewidth',2),title(' h_{D3}[n]')
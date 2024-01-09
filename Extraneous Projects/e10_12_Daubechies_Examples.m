% e10_12_Daubechies_Examples.m: Demonstrate Daubechies signals 
clear; close all; set(0,'defaultAxesFontSize',13); 
fpv=[100 100 900 500]; fpv2=[100 700 1100 140]; % figure positions

x = [[-2:1:3] [2.5:-0.5:-1] [-0.8:0.2:1] [0.75:-0.25:-1]] %input signal, piecewise linear
LX = length(x)                            % length of this particular x[n] is 2^N = 32
g = [0.483, 0.8365, 0.2241, -0.1294];     % D2 Daubechies scaling function
h = flip(g); h(2) = -h(2); h(4) = -h(4);  % D2 Daubechies wavelet function
hup = [h(1) 0 h(2) 0 h(3) 0 h(4)];        % upsampled h(n). Don't need the final 0 value
h2 = conv(g,hup);       % h^{(2)}[n] is (non-cyclic) convolution of g[n] and an upsampled h(n)
%%%%%%%% uncomment the following 3 lines to do D1 (Haar) instead of D2 wavelets  %%%%%%%%%%
%g = [0.707, 0.707]; h = [0.707, -0.707]; % D1 Daubechies (=Haar) scaling function
%hup = [h(1) 0 h(2) 0];                   % upsampled h(n)
%h2 = cconv(g,hup,length(hup)); % we get the same h2 using cyclic or linear convolution, for Haar

X1 = cconv(g,x,LX); X1 = X1(1:2:end)      % scaling: convolve with g, downsample
X2 = cconv(g,X1,length(X1)); X2B = X2; X2 = X2(1:2:end) % convolve with g, downsample
x1 = cconv(h,x,LX); x1 = x1(1:2:end)      % wavelet (detail): convolve with h, downsample
x2 = cconv(h,X1,length(X1)); x2d =x2(1:2:end) % convolve X1 with h, downsample
% calculate x2 by alternative method, directly from x[n] convolved with h2, then downsampled
x2al = cconv(h2,x,LX); x2alt = x2al(1:4:end)

n = 0:1:LX-1;  ng = [0:1:length(g)-1]; % n = axis range for stem plots
n2 = 0:1:length(x1)-1; n4 = 0:1:length(X2)-1;
figure('position',fpv), subplot (3,2,1), stem(n,x, 'linewidth',2),title('x[n]') 
subplot (3,2,3),stem(n2,X1, 'linewidth',2),title('X_1[n]')
subplot (3,2,5),stem(n4,X2, 'linewidth',2),title('X_2[n]')
subplot (3,2,2),stem(n2,x1,'r', 'linewidth',2),title('x_1[n]')
subplot (3,2,4),stem(n4,x2d,'r', 'linewidth',2),title('x_2[n]')
subplot (3,2,6),stem(n4,x2alt,'r', 'linewidth',2),title('x_2[n] via h^{(2)}[n]')
diff2 = x2d - x2alt         % compare the 2 methods of calculating x2[n]

figure('position',fpv2), subplot(1,5,1), stem(ng,g,'linewidth',2),title('g_{D2}[n]')
subplot(1,5,2), stem(ng,h,'r','linewidth',2),title(' h_{D2}[n]')
subplot(1,5,3), stem(h2,'r','linewidth',2),title(' h^{(2)}[n]')
subplot(1,5,4), stem(n2,X2B,'linewidth',2),title('X_2[n] without downsample')
subplot(1,5,5), stem(n2,x2, 'r','linewidth',2),title('x_2[n] without downsample')
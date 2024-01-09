% file: e9_3_freq_sampling5.m  %plot h[n] and spectrum for length 5 FIR filter
clear; close all; set(0,'defaultAxesFontSize',14); 
n = [-2:2];
h = [-1/16, 1/4, 5/8, 1/4, -1/16]
w = linspace(0,pi,1000);
H = polyval(h,exp(-j*w));  % calculate H(z) at z=e^(j Omega)
subplot(1,2,1),stem(n,h,'linewidth',2),grid minor,yticks([-0.25:0.25:1]), 
  set(gca,'YMinorTick','on')
subplot(1,2,2),plot(w,abs(H),'r','linewidth',2),axis tight,
  grid,xticks([0:0.5:3.14])
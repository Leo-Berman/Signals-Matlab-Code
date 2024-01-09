% file: e7_14_DTFT1.m:  % DTFT of discrete time finite sequence x[n]={3,1,4,2,5}
clear; close all; set(0,'defaultAxesFontSize',13);
W=[-3*pi:0.1:3*pi];             % frequency range (rad/s)
X= 3*exp(j*2*W)+ 1*exp(j*W)+ 4 + 2*exp(-j*W) + 5*exp(-j*2*W);

figure('position',[100 100 400 400]), 
 subplot(2,1,1), plot(W/pi,abs(X),'r','LineWidth',2),grid on, % magnitude plot
  title('M_1(e^{j\Omega})'),xlabel('\Omega/\pi (rad/s)'),axis tight  
 subplot(2,1,2), plot(W/pi,angle(X),'g','LineWidth',2),grid on,  % phase plot
  title('\phi_1(e^{j\Omega})'), xlabel('\Omega/\pi (rad/s)'),axis tight
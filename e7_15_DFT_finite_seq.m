% e7_15_DFT_finite_seq.m:  plots for DTFT (and DFT/FFT) magnitude spectra of finite sequence
clear; close all; set(0,'defaultAxesFontSize',14);
x = [3 1 4 2 5];  
xlong = [x zeros(1,27)];  % calculate 32-point fft (DFT)
f = fft(xlong)            % semicolon omitted, to show the values in command window
wf= linspace(0,2*pi-pi/16,32); %fft frequency Omega range (0 to 2pi-pi/16) for plotting 
% (the FFT does not calculate a 33rd point (for 2\pi))

W=linspace(0, 2*pi,100);  % "continuous" frequency range (rad/s) for DTFT
X= 3*exp(j*2*W)+ 1*exp(j*W)+ 4 + 2*exp(-j*W) + 5*exp(-j*2*W);  % DTFT

figure,hold on,scatter (wf/pi,abs(f),'filled'), % plot DFT (FFT) together with DTFT 
 plot(W/pi,abs(X),'LineWidth',2), title('M(\Omega)'), xlabel('\Omega/\pi')
% NOTE THAT A PHASSE PLOT shows the FFT nowhere near the phase of the DTFT !!
% e8_1_freq_plots.m     
% freq plots for various H(z) based on poles, zeros
clear; close all; set(0,'defaultAxesFontSize',14); set(0,'defaultLineLineWidth',2); 
fpv=[100 100 200 150];

w=[0:0.01:pi];  % freq range
p1 = [0.9, 0.8*exp(j*pi/4), 0.8*exp(-j*pi/4)];
z1 = -1;
H1 = (exp(j*w)-z1)./((exp(j*w)-p1(1)).*(exp(j*w)-p1(2)).*(exp(j*w)-p1(2))); 
figure('position',fpv), plot(w, abs(H1)), axis tight, grid on,
  xlabel('\Omega (rad/sample)'), xticks([0:3]) 

p2 = [0.9*exp(j*pi/4), 0.9*exp(-j*pi/4), 0.9*exp(3*j*pi/4), 0.9*exp(-3*j*pi/4)];
z2 = [j, -j];
H2 = (exp(j*w)-z2(1)).*(exp(j*w)-z2(2))./((exp(j*w)-p2(1)).*(exp(j*w)-p2(2)).*(exp(j*w)-p2(3)).*(exp(j*w)-p2(4))); 
figure('position',fpv), plot(w, abs(H2)), axis tight, grid on,
  xlabel('\Omega (rad/sample)'), xticks([0:3]) 
    
z3 = [0.7*exp(j*pi/4), 0.7*exp(-j*pi/4), 0.7*exp(3*j*pi/4), 0.7*exp(-3*j*pi/4)];
p3 = [0.9j, -0.9j];
H2 = (exp(j*w)-z3(1)).*(exp(j*w)-z3(2)).*(exp(j*w)-z3(3)).*(exp(j*w)-z3(4))./((exp(j*w)-p3(1)).*(exp(j*w)-p3(2))); 
figure('position',fpv), plot(w, abs(H2)), axis tight, grid on,
  xlabel('\Omega (rad/sample)'), xticks([0:3]) 

% 4: highpass  
p1 = [0.8*exp(3j*pi/4), 0.8*exp(-3j*pi/4)];
z1 = 0;
H1 = (exp(j*w)-z1)./((exp(j*w)-p1(1)).*(exp(j*w)-p1(2))); 
figure('position',fpv), plot(w, abs(H1)), axis tight, grid on,
  xlabel('\Omega (rad/sample)'), xticks([0:3]) 
  
% 5:  no zeros, gradual rolloff  
p1 = 1.1;
%z1 = -1;
H5 = 1./(exp(j*w)-p1); 
figure('position',fpv), plot(w, abs(H5)), grid on,
  xlabel('\Omega (rad/sample)'), xticks([0:3])%, yticks([0, 0.5, 1.3]) 
  
% 6:  no zeros, gradual rolloff  
p1 = 5;
%z1 = -1;
H6 = p1./(exp(j*w)-p1); 
figure('position',fpv), plot(w, abs(H6)), grid on,
  xlabel('\Omega (rad/sample)'), xticks([0:3])%, yticks([0, 0.5, 1.3])
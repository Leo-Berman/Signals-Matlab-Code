% e8_1_anim2_zero_radii.m     
% freq plots for one-pole, one-zero H(z) as zero moves along radius of unit circle
clear; close all; set(0,'defaultAxesFontSize',14); fpv=[100 100 350 307];

w=[0:0.01:pi];  % freq range
phase = pi/3;   % angle along which radii lie
terms = 6;      % number of radii length
dr  = 0.2;      % delta between radii
H = zeros(terms, length(w));   %initialize matrix of results 

for n = 0:(terms-1)
    H(n+1,1:end)= 1- n*dr*exp(j*(phase-w));  
end
figure('position',fpv), hold on, title('|H(e^{j\omega})|'),
 for n = 1:terms
  plot(w, abs(H(n,:)),'Linewidth',2),grid on  % plot various radii freq responses
 end 

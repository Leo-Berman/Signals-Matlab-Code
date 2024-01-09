% e8_1_pole_radii2_LP.m   
% freq plots for complex-pole-pair, one-zero H(z) as poles move toward center of unit circle
clear; close all; set(0,'defaultAxesFontSize',14); 
set(0,'defaultaxesxlim',[-pi/2 pi/2]); set(0,'defaultaxesylim',[0 30]);
fpv=[100 700 400 300];

w=[-pi/2:0.01:pi/2];  % freq range
terms = 4;        % number of radii length
H = zeros(terms+1, length(w));   %initialize matrix of results 
%phase of the poles = pi/4, because the roots of denominator are  a*(1 pm j)
r = 0.95;         % pole radius initial value
dr  = 0.05;       % delta between radii
e45 = exp(j*pi/4) % 45 degree unit circle radius point

figure('position',fpv), hold on, title('|H(e^{j\omega})|'),  % calculate and plot responses
colr = get(gca,'ColorOrder');  %get colors to assure all plot colors match
for n = 0:(terms-1)
    a = r - n*dr;
    H(n+1,1:end)= (exp(j*w) +1)./((exp(j*w) - a*e45).*(exp(j*w) - a*conj(e45)));
    plot(w, abs(H(n+1,:)),'color',colr(n+1,:),'Linewidth',2),
       xlim([-pi/2 pi/2]), ylim([0 30]),grid on  % plot various radii freq responses
    
end;
 % plot a lowpass filter as the limit as radius approaches 0 (a=0.2)
 a=0.2;
 n=terms;
 H(n+1,1:end)= (exp(j*w) +1)./((exp(j*w) - a*e45).*(exp(j*w) - a*conj(e45)));
    plot(w, abs(H(n+1,:)),'color',colr(n+1,:),'Linewidth',2),
       xlim([-pi/2 pi/2]), ylim([0 30]),grid on 
hold off; 

% plot cumulative responses in different colors
for n = 0:(terms-1)
    figure('position',fpv), hold on,
    plot(w, abs(H(n+1,:)),'color',colr(n+1,:), 'Linewidth',2), %emphasize most recent plot
       xlim([-pi/2 pi/2]), ylim([0 30]),grid on 
    for m = n:-1:0
      plot(w, abs(H(m+1,:)),'-.','color',colr(m+1,:)),
       xlim([-pi/2 pi/2]), ylim([0 30]),grid on   % plot various radii freq responses
    end
    hold off;
end;
% print out transfer function equations
syms z a
r95 = 0.95*e45
q = (z-r95)*(z-conj(r95))
expand(q)  % yields z^2 - 1.3435*z + 0.9025
r9=  0.9*e45
q9 = (z-r9)*(z-conj(r9))
expand(q9) % yields z^2 - 1.2728*z + 0.81

r85=  0.85*e45
q85 = (z-r85)*(z-conj(r85))
expand(q85) % yields z^2 - 1.2021*z + 0.7225
% e8_1_pole_angles0.m     
% freq plots for complex-pole-pair, one-zero H(z) as poles move around 0.9 radius circle
clear; close all; set(0,'defaultAxesFontSize',14); 
pip = pi+0.005; % a little beyond pi, for plotting purposes
set(0,'defaultaxesxlim',[-pip, pip]); set(0,'defaultaxesylim',[0 15]);
fpv=[100 700 500 320];

w=[-pip:0.01:pip];  % freq range
terms = 5;        % number of radii length
H = zeros(terms, length(w));   %initialize matrix of results 
%phase of the poles starts at pi/4, because the roots of denominator are  a*(1 pm j)
r = 0.9;         % pole radius  
phi  = 0; dphi  = pi/4;    % delta between phases


figure('position',fpv), hold on, title('|H(e^{j\omega})|'),  % calculate and plot responses
colr = get(gca,'ColorOrder');  %get colors to assure all plot colors match
for n = 0:(terms-1)
    p = phi + n*dphi;
    ep = r*exp(j*p); epcon= conj(ep), % complex exponential with phase angle and radius of pole
    H(n+1,1:end)= (exp(j*w) +1)./((exp(j*w) - ep).*(exp(j*w) - epcon));
    plot(w, abs(H(n+1,:)),'color',colr(n+1,:),'Linewidth',1),
       xlim([-pip pip]), ylim([0 200]),grid on  % plot various radii freq responses
end;
hold off; 

% plot cumulative responses in different colors
for n = 0:(terms-1)
    figure('position',fpv), hold on, title('|H(e^{j\omega})|'),
    plot(w, abs(H(n+1,:)),'color',colr(n+1,:), 'Linewidth',2), %emphasize most recent plot
       xlim([-pi pi]), ylim([0 30]),grid on 
    for m = n:-1:0
      plot(w, abs(H(m+1,:)),'-.','color',colr(m+1,:)),
       xlim([-pip pip]), ylim([0 15]),grid on   % plot various radii freq responses
    end
    hold off;
end;
% print out transfer function equations
%syms z a
%q = (z-ep)*(z-epcon)
%expand(q)  % yields z^2 - 1.2728*z + 0.81  for pi/4, r=0.9

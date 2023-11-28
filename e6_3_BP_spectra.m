% file: e6_3_BP_spectra.m   % RLC bandpass circuit: plot frequency response
clear; close all; set(0,'defaultAxesFontSize',13);
R=30; L=2.7; C=1e-5;        % component values
w=[0: 1e4];                 % frequency range (rad/s)
w_resonant = 1/sqrt(L*C), f_resonant = w_resonant/(2*pi) % print resonant frequency

Vs = 1;                      % Assume unity source magnitude for freq response plot
XL = j*w*L; XC = 1./(j*w*C); % arrays of reactances, at every freq w
Z = R + XL + XC;             % series circuit, just add impedances to get total
I = Vs./Z; V_R = I*R;        % get output voltage V_R

V_R_max = max(abs(V_R))      % resonant peak voltage magnitude
V_R_c = V_R_max*sqrt(2)/2    % voltage level at corner (half-power) frequencies
epsilon = 0.01;              % small delta, for floating point compare...
w_c = find(abs(abs(V_R) - V_R_c) < epsilon) % find the two corner frequencies, heuristically
BW = w_c(2) - w_c(1)         % print Bandwidth

figure('position',[100 100 1100 250]), 
subplot(1,3,1), plot(w(1:400),abs(V_R(1:400)),'r'), % linear plot, zoom in on low freq
  grid on, title('|M(\omega)|'),xlabel('\omega (rad/s)'),yticks(0:0.2:1),xticks(0:100:400),
subplot(1,3,2), semilogx(w,20*log10(abs(V_R))),     % dB magnitude plot
  grid on, title('|M(\omega)|'),ylabel('dB'), xlabel('\omega (rad/s)')  
subplot(1,3,3), semilogx(w,rad2deg(angle(V_R))),    % phase plot, log freq scale
  title('\phi(\omega)'),ylabel('degrees'),yticks(-90:30:90),xlabel('\omega (rad/s)'),
  grid on
  
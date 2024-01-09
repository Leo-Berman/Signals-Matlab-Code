%file: e9_4_bp_IIR2.m  Example 9-11: impulse invariance bandpass IIR Filter design
% sharp resonant peak at w_0=4 rad/s in analog version
% requires MATLAB control toolbox for functions sys() and bode()
% requires MATLAB signal processing toolbox for function zplane()
% pkg load control  % un-comment the pkg load lines if using Octave
% pkg load signal   % for zplane() pole/zero map
clear; close all; set(0,'defaultAxesFontSize',12,'DefaultAxesXGrid','on');
% Analog filter: H_a(s) = (s+0.1)/((s+0.1)^2 +16)
n= [1, 0.1];  % numerator of H_a(s)
d= [1, 0.2, (16+0.1^2)];
H_s_poles = roots(d)        % print poles of H(s)
sys=tf(n,d);
figure, subplot(1,2,1),bode(sys),grid on, % plots response in dB vs. freq (rad/s)
        subplot(1,2,2),pzmap(sys) 
t = linspace(0,50,501);     % for plotting impulse response h_a(t)
ha = exp(-0.1*t).*cos(4*t); % inverse Laplace transform of sys H(s)
figure, plot(ha)

% Discrete filter: H(z) 
Ts=0.01;                          % sample period T_s = 0.01 sec
b = [1, -exp(-0.1*Ts)*cos(4*Ts), 0]; % H(z) numerator coefficients
b = b.*Ts;                        % numerator actually is scaled by T_s
a = [1, -2*exp(-0.1*Ts)*cos(4*Ts),exp(-0.2*Ts)]; % H(z) denominator coefficients
H_z_poles = roots(a)              % print poles of H(z)
w = linspace(0, 0.1, 512); % focus on low frequencies where the resonant peak is 
figure, freqz(b,a,w); % plots frequency response in dB of H(z) as function of Omega

H = freqz(b,a,w);       % save frequency response in dB of H(z) as function of Omega
Hmag = db2mag(abs(H));  % convert to magnitude
figure, plot(w, Hmag);  % linear magnitude plot instead of dB
figure, zplane(b,a);    % plot H(z) pole/zero map 

%pkg load symbolic
%syms s t
%Ha = (s+0.1)/((s+0.1)^2 +16)
%ha = ilaplace(Ha)                       % returns impulse response of analog filter
%fplot(ha)
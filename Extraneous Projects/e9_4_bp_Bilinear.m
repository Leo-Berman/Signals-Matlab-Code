%File: e9_4_bp_Bilinear.m: bilinear transformation bandpass IIR Filter design
% sharp resonant peak at w_0=4 rad/s in analog version, discrete Omega_0 = pi/4
% Analog filter: H_a(s) = (s+0.1)/((s+0.1)^2 +16)
% requires MATLAB control toolbox to get functions sys() and bode()
% requires signal toolbox for function zplane()
% Analog filter to be converted: H_a(s) = (s+0.1)/((s+0.1)^2 +16)
clear; close all; set(0,'defaultAxesFontSize',12,'defaultAxesXGrid','on','defaultAxesYGrid','on');
% pkg load control       % un-comment the pkg loads if using Octave 
% pkg load signal          
n= [1,0.1];  d= [1,0.2,(16+0.1^2)]; % numerator, denominator of H_a(s)
H_s_poles = roots(d)
sys=tf(n,d);
figure; bode(sys),grid on % plot response in dB vs. freq (rad/s)

% Discrete filter: H(z) 
[b a] = bilinear(n,d,2)  % find H(z) coefficients using H_a coefficients
% Note: Octave bilinear() requires last parameter = T = 1/2.  
% MATLAB bilinear() requires it to be f = 1/T = 2. 

H_z_poles = roots(a), H_z_zeros =roots(b)     % print poles, zeros of H(z)

w = linspace(0, pi, 512); 
H = freqz(b,a,w);       % save frequency response in dB of H(z) as a function of Omega
Hmag = db2mag(abs(H));          % convert to magnitude
figure, plot(w, Hmag),title('H(e^{j\Omega})');  % linear magnitude plot instead of dB
figure, zplane(b,a),grid on     % plot H(z) pole/zero map
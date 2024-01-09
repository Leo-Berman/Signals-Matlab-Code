%e8_9_leakage_PA.m  
% plot cos/sin sum, show leakage 
clear; close all; fpv = [0 300 400 200]; 
set(0,'defaultAxesFontSize',13,'DefaultAxesXGrid','on','DefaultAxesYGrid','on'); 

T0 = 0.02,  f0= 1/T0, % fundamental period and freq 
fs=1000; Ts = 1/fs;   % sample rate
N = 32;               % fft length 
T_d = N*Ts, ratio= T_d/T0 % sample duration (no leakage if T_d*f0 = T_d/T_0 is integer)
r = 1;% 0.95;
t = linspace(0,(N-1)*Ts,round(r*N));     % times for FFT
tc = linspace(0,(N-1)*Ts,10*round(r*N)); % times for continuous wave plot
n = t;                 % sample time points n*Ts
%x = 2*sin(881*pi*t);  % single sine
%xs =2*sin(881*pi*n);  % sampled sine
dc = 1;   % dc offset in signal
xp = dc + 2*cos(200*pi*tc)+3*sin(700*pi*tc) ;  % signal for plot
xps = dc + 2*cos(200*pi*n)+3*sin(700*pi*n) ;   % sampled sum signal for plot
x = dc + 2*cos(200*pi*t)+3*sin(700*pi*t) ;     % sampled sum signal for FFT
 
p = [1:N]; pc=[1:10*N]; % plot lengths
figure %('position',fpv), 
 subplot(2,1,1), plot(1000*tc(pc),xp(pc),'r'),yticks([-4:2:6]),axis tight,
   xlabel('t (ms)'), title('x(t)') 
 subplot(2,1,2),hold on, plot(1000*tc(pc),xp(pc),'r'),yticks([-4:2:6]),axis tight,
   xlabel('t (ms)'), title('Sampled x(t)'),
   stem(p-1,xps(p), 'filled'),
   hold off
   
X2 =abs(fft(x,N))/N; 
w = 0:N-1;  % start FFT plots at 0
figure('position',fpv),stem(w,X2,'.r','Linewidth',2),xticks([0:5:N]),title('|X[k]|')% axis tight,
  
   
% e8_9_leakage.m      plot cos/sin sum and FFT, to show leakage
clear; close all; fpv = [0 300 400 200]; 
set(0,'defaultAxesFontSize',13,'DefaultAxesXGrid','on','DefaultAxesYGrid','on'); 

T0 = 0.02,  f0= 1/T0, fa=2*f0, fb=7*f0 % fundamental signal period and freqs 
fs=1000, Ts = 1/fs    % sample rate = fs and period = Ts
N = 40;               % fft length 
T_d = N*Ts, ratio= T_d/T0 % sample duration (no leakage if T_d*f0 = T_d/T0 is integer)
n = linspace(0,(N-1)*Ts,N);     % sample time points n*Ts
tc = linspace(0,(N-1)*Ts,10*N); % times for continuous wave plot
dc = 1;   % dc offset in signal
xc= dc + 2*cos(2*pi*fa*tc)+3*sin(2*pi*fb*tc) ;  % signal for continuous-wave plot
x = dc + 2*cos(2*pi*fa*n)+3*sin(2*pi*fb*n)   ;  % sampled signal for plot and FFT

p = [1:N]; pc=[1:10*N]; % lengths for plots 
figure 
 subplot(2,1,1), plot(1000*tc(pc),xc(pc),'r'),yticks([-4:2:6]),axis tight,
   xlabel('t (ms)'), title('x(t)') 
 subplot(2,1,2),hold on, plot(1000*tc(pc),xc(pc),'r'),yticks([-4:2:6]),axis tight,
   xlabel('t (ms)'), title('x(t), x[n]'),
   stem(1000/fs*(p-1),x(p), 'filled'),
   hold off
   
FX =abs(fft(x,N))/N; 
w = 0:N-1;  % start FFT plot at 0
figure('position',fpv),stem(w,FX,'.r','Linewidth',2),xticks([0:5:N]),title('|X[k]|')% axis tight  
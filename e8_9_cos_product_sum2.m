%e8_9_cos_product_sum2.m    
% plot some cos/sin sums, products, for MS PA
clear; close all; fpv = [0 300 400 800]; 
set(0,'defaultAxesFontSize',13,'DefaultAxesXGrid','on','DefaultAxesYGrid','on'); 

T0 = 0.02,  f0= 1/T0,  % fundamental period and freq  
N = 128;     % fft length
T_d  = T0   % time length of samples being integer multiple of T0
T_d1 = 1.6*T0 % sample period, non-integer multiple of T0
r = 1;% 0.95;
t = linspace(0,T_d1,round(r*N));   % times for continuous wave plot and FFT
n = t(1:round(N/25):end);     % this produces 17 samples/cycle
%x2 = 2*sin(881*pi*t);  % single sine
%x2s =2*sin(881*pi*n);  % sampled sine
x2 = 4 + 2*sin(300*pi*t) -3* cos(800*pi*t); % sum signal
x2s =4 + 2*sin(300*pi*n) -3* cos(800*pi*n); % sampled sum signal

xp = 2*cos(200*pi*t).*sin(300*pi*t);     % product signal
np = t(1:round(N/18):end);                        %  produces 11 samples/cycle
xps = 2*cos(200*pi*np).*sin(300*pi*np);  % sampled product signal

figure('position',fpv), 
  subplot(4,1,1),plot(1000*t,x2,'r'),yticks([-2:2:10]),% axis tight,
   xlabel('t (ms)'), title('x(t) = 4 + 2sin(300\pit) - 3cos(800\pit)') 
  subplot(4,1,2),hold on, plot(1000*t,x2,'r'),yticks([-2:2:10]),% axis tight,
   xlabel('t (ms)'), title('Sampled x(t) = 4 + 2sin(300\pit) - 3cos(800\pit)'),
   stem(1000*n,x2s),
   hold off,
  subplot(4,1,3),plot(1000*t,xp),yticks([-2:2]), %axis tight,
   xlabel('t (ms)'), title('x(t)= 2sin(300\pit) cos(200\pit) '),  %horizontal axis in msec
  subplot(4,1,4),hold on, plot(1000*t,xp,'r'),yticks([-2:2]),% axis tight,
   xlabel('t (ms)'), title('Sampled x(t)'),
   stem(1000*np,xps),
   hold off
   
  XP = abs(fft(xp,N))/N;  X2 =abs(fft(x2,N))/N; 
  w = 0:N-1;  % start FFT plots at 0
  figure, 
    subplot(2,1,1),stem(w,X2,'.r','Linewidth',1.5),xticks([0:10:N]),title('|X[k]|'),% axis tight,
     subplot(2,1,2),stem(w,XP,'.b','Linewidth',1.5),title('|X[k]|'),% axis tight,
   
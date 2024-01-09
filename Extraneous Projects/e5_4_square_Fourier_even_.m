% e5_4_square_Fourier_even_.m     
% Fourier series for even squarewave
clear; close all; set(0,'defaultAxesFontSize',14); fpv=[100 100 400 220];
A=1;         % amplitude of input wave
T0 = 1;      % period of input wave
t=linspace(-T0,T0,1024); lt=length(t); % 2 periods of wave
terms = 5;  % number of harmonics to calculate and plot

X = A*ones(1,lt); X(lt/8:3/8*lt) = -A;  X(5/8*lt:7/8*lt) = -A; % even square wave, original signal
figure('position',fpv), plot(t,X,'r','Linewidth',2),grid on, hold off  % plot  squarewave

x = zeros(2*terms,lt);  % initialize matrix of Fourier harmonics (row n is nth harmonic)
for n = 1:2:2*terms-1
    x(n,1:end)= 4*A/(n*pi)*sin(n*pi/2)*cos(2*n*pi*t/T0);  % even square wave Fourier series
end

figure('position',fpv), hold on, title("Terms = "+terms),
 for n = 1:2:2*terms-1
  plot(t, x(n,:)),grid on,       % plot harmonics
 end 
plot(t, sum(x),'-.k','Linewidth',1),grid on, hold off  % plot sum as dashed, atop harmonics  
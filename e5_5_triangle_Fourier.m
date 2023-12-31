% e5_5_triangle_Fourier.m     
% Fourier series for triangle into to RC lowpass, and lowpass output
clear; close all; set(0,'defaultAxesFontSize',14); fpv=[100 100 600 180];

T0 = 1 ;             % period of input wave
t=[-1*T0:0.01:1*T0]; % 2 periods of wave
terms = 5;           % number of highest harmonic to calculate and plot
x = zeros(terms, length(t));  xo = zeros(terms, length(t));

for n = 1:2:2*terms-1
    x(n,1:end)= 8/(n^2*pi^2)*cos(2*n*pi*t/T0);  % even triangle wave Fourier series
    xo(n,1:end) =1/sqrt(1+n^2)*8/(n^2*pi^2)*cos(2*n*pi*t/T0 -atan(n)); %output
end

figure('position',fpv), hold on, title('Input'),
 for n = 1:2:2*terms-1
  plot(t, x(n,:)),grid on,       % plot harmonics
 end 
 plot(t, sum(x),'r'), hold off  % plot sum
 
figure('position',fpv), hold on, title('Output'),
  for n = 1:2:2*terms-1
   plot(t, xo(n,:)),grid on,
  end
  plot(t, sum(xo),'r'), hold off  % plot sum
  
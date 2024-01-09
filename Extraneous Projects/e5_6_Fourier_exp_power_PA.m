% e5_6_Fourier_exp_power_PA.m     
% Fourier series for 0.5^n * cos(100*n*t + pi/3)
clear; close all; set(0,'defaultAxesFontSize',14); fpv=[100 100 500 180];
w0 = 100             % angular frequency
T0 = (2*pi)/w0       % period of input wave
t=[0:0.001:2*T0];     
terms = 10;          % number of highest harmonic to calculate and plot
xr = zeros(terms+1, length(t));  x = zeros(terms+1, length(t));

for n = 0:terms
    xr(n+1,1:end) = 0.5^n * cos(100*n*t + pi/3);    %   mag/phase Fourier series
    x(n+1,1:end) = 0.5^n *exp(j*(100*n*t + pi/3));  %   Exp Fourier series
end

figure('position',fpv),title('Exponential Harmonics'), hold on,
 for n = 1:terms+1
  plot(t, real(x(n,:))),grid on,ylim([-0.6 0.6]),xlim([0 4*pi/w0])  % plot harmonics
 end 
 hold off;
S = sum(x);

figure, % Exponential plots
 subplot (2,1,1), plot(t,abs(S),'m','LineWidth',2),grid on,ylim([0 2]),
   xlim([0 4*pi/w0]), title('Exponential |x(t)|')  % plot sum
 subplot (2,1,2), plot(t,real(S),t,imag(S),'-.'),grid on,ylim([0 2]),
   xlim([0 4*pi/w0]), title('Re[x(t)],Im[x(t)]')  % plot Re and Imaginary parts

% mag/phase plots, which turn out to exactly match Re[exponential]
figure('position',fpv),title('Harmonics'), hold on,
 for n = 1:terms+1
  plot(t, xr(n,:)),grid on,ylim([-0.6 0.6]),xlim([0 4*pi/w0])       % plot harmonics
 end 
 hold off;
S = sum(xr);
figure('position',fpv), plot(t,S,'k','LineWidth',2),grid on,ylim([0 1.5]),
xlim([0 4*pi/w0]), title('x(t)')  % plot sum

% calculate Power per Fourier series and Parseval's theorem:
n = [1:10]; % plenty of terms
coeff_sq = (1/2).^(2*n);
Pf = 1/4 + 0.5*sum(coeff_sq)

% check power formulas, using symbolic toolbox
syms m n
Pfs_real = 1/4 + 0.5*symsum(0.5^(2*m),m,1,Inf)
Pfs_exponetial = double(symsum(0.5^(2*n),n,0,10))  % 10 terms is more than enough 
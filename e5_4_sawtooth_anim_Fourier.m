% e5_4_sawtooth_anim_Fourier.m     
% Fourier series for sawtooth of 50% duty cycle, period 2, height 1
clear; close all; set(0,'defaultAxesFontSize',14); fpv=[100 100 350 220];

T0 = 2 ;             % period of input wave
t=[-1*T0:0.001:1*T0]; % 2 periods of wave
terms = 5;           % number of highest harmonic to calculate and plot
x = zeros(terms, length(t));  a=zeros(1,terms); b=zeros(1,terms); 
c=zeros(1,terms); phi=zeros(1,terms); 
phi2=zeros(1,terms); %double check phi calculations 
dc = 0.25 * ones(1,length(t));        % dc average

for n = 1:terms
    a(n) = 1/(n^2*pi^2)*(cos(n*pi)-1);
    b(n) = - 1/(n*pi)*cos(n*pi);
    c(n) = abs(a(n)-j*b(n));  
    phi(n) = rad2deg(angle(a(n) -j*b(n)));
    phi2(n) = -atand(b(n)/a(n));
    if a(n) < 0
        phi2(n) = phi2(n)+ rad2deg(pi);
        if phi2(n) > 180
          phi2(n) = phi2(n) -360
        end
    end %if
    
  x(n,:) = a(n)*cos(n*pi*t) + b(n)*sin(n*pi*t); %simplified version of MATLAB formulas
end

a,b,c,phi,phi2  % display values

figure('position',fpv), hold on, title("Terms="+terms),
 for n = 1:terms
  plot(t, x(n,:)),grid on,          % plot harmonics
 end 
 plot(t, sum(x)+ dc,'r','Linewidth',2), hold off  % plot sum
figure('position',fpv), plot(t, sum(x)+ dc,'-r', 'Linewidth',2) %plot sum alone
yt = [-120,-90, -60, -30, 0, 30, 60, 90]; ytc = linspace(0,0.4,9);
figure('position',fpv), stem([0:terms],[0 phi],'filled','Linewidth',2),grid on, yticks(yt) %, axis tight
figure('position',fpv), stem([0:terms],[0.25 c],'filled','r','Linewidth',2),grid on, yticks(ytc) %, axis tight
 
syms t m      % verify formulas for coefficients
a_0 = 1/T0* int(t,[0, T0/2])
a_m = 2/T0 * int(t*cos(m*pi*t),[0, T0/2])
b_m = 2/T0 * int(t*sin(m*pi*t),[0, T0/2])

 
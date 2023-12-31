% e5_8_animPA_Fourier_shifts_rect.m   
% rect(t/T) time function, effects on Fourier transform of time scaling and
% time delay (shift), for animation PA
close all; clear; set(0,'defaultAxesFontSize',14);fpv=[100 500 1200 220];

T= 2; % (initial) pulse width
syms x0 x1 x2 x3 w t

for T = 1:3 % time scaling (various widths of rect()
 x0 = 3*rectangularPulse(-T/2, T/2, t) % time-scaled pulse
 X0 = fourier(x0)
 %figure('position',fpv), 
 % subplot(1,3,1),fplot(x0,[-T, 2*T],'r','LineWidth',2),grid on, title("x(t)=rect(t/"+T+")")
 % subplot(1,3,2),fplot(abs(X0),[-3*pi,3*pi],'r','LineWidth',2),grid on, title('|X(w)|')
 % subplot(1,3,3),fplot(angle(X0),[-3*pi,3*pi],'r','LineWidth',2),grid on, title('\angle{X(w)}')
end

T=2; %restore to default width for time-shift plots
deg = linspace(-180,180,5);
for t0 = -2:2  % various time shifts 
 x1 = 3*rectangularPulse(-T/2+t0, T/2+t0, t) % shifted pulse
 X1 = fourier(x1)
 figure('position',fpv), 
  subplot(1,3,1),fplot(x1,[-T, 2*T],'r','LineWidth',2),grid on, title("x"+t0+" = x(t-"+t0+")")
  subplot(1,3,2),fplot(abs(X1),[-10,10],'r','LineWidth',2),grid on, title('|X_1(w)|')
  subplot(1,3,3),fplot(rad2deg(angle(X1)),[-10,10],'r','LineWidth',2),grid on, yticks(deg),axis tight, title('\angle{X_1(w)}')
end

% verify symbolic results using canned formula for time-shifted X(w)
ts = 1; % time shift
T = 2;  % time width of rectangle
w1 = linspace(-10,10, 200); %frequency range
Y = exp(-j*w1*ts).* sin(w1*T/2)./(w1/2);
figure('position',fpv), 
  subplot(1,2,1),plot(w1, abs(Y),'b','LineWidth',2),grid on, title('|Y(w)|')
  subplot(1,2,2),plot(w1, rad2deg(angle(Y)),'b','LineWidth',2),grid on,yticks(deg),axis tight, title('\angle{Y(w)}')
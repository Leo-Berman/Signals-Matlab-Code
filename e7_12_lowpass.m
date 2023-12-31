% file = e7_12_lowpass.m, frequency response of lowpass (geometric) filter
%  for anim PA 
clear; close all; set(0,'defaultAxesFontSize',12);
n5 = [0:5]; n15=[0:15]; n150=[0:0.1:15];
h = (1/2).^n5   % print out and plot a few values of impulse response
figure, stem(n5, h, 'r', 'LineWidth',2), title('h[n]'), grid on
W = [0,pi/10, pi/4, pi/3, pi/2, 3*pi/4, pi] % a few frequencies for transfer function
H = exp(j*W)./(exp(j*W)-0.5)
M = abs(H), Theta_rad = angle(H), Theta_deg = rad2deg(Theta_rad)

w=[-2*pi:0.1*pi:2*pi];   % w=[0:0.05*pi:pi];  %frequency ranges (rad/s) for spectra plots
Hplot = exp(j*w)./(exp(j*w) -0.5);
figure('position',[50 50 700 170]), % spectra plots
 subplot(1,2,1), plot(w/pi,abs(Hplot),'b','LineWidth',2),grid on,   % magnitude plot
  title('|M(e^{j\Omega})|'),xlabel('\Omega/\pi (rad/s)'),yticks([0.6:0.2:2]),xticks([-2:0.5:2]),  
 subplot(1,2,2), plot(w/pi,angle(Hplot),'g','LineWidth',2),grid on,  % phase plot
  title('\phi(e^{j\Omega})'),xlabel('\Omega/\pi (rad/s)'),yticks([-0.6:0.2:0.6]),xticks([-2:0.5:2])
  
x3 = cos(pi/3*n15); y3 = abs(H(4))*cos(pi/3*n15 + angle(H(4)));
yt3 =abs(H(4))*cos(pi/3*n150 + angle(H(4)));       % continuous time equivalent of y3
%y = H(4)* x; is the correct value, but can't easily stem-plot the phase shift 

figure('position',[100 100 700 170]), %input and output stem plots for x[n]=cos(pi/3*n)
 subplot(1,2,1),stem(n15,x3,'r','LineWidth',2),grid on,title('x[n]=cos(n\pi/3)'),xlabel('n')  
 subplot(1,2,2),stem(n15,y3,'r','LineWidth',2),grid on,title('y[n]'), xlabel('n')
 
figure('position',[100 100 700 170]), % stem and continuous plots for x[n]=cos(pi/3*n),
 subplot(1,2,1),stem(n15,x3,'r','LineWidth',2),grid on,title('x[n]=cos(n\pi/3)'),xlabel('n')  
 subplot(1,2,2),hold on,
   stem(n15,y3,'r','LineWidth',1),grid on,title('y[n]'), xlabel('n'),
   plot(n150,yt3,'LineWidth',2), hold off

x10 = cos(pi/10*n15); y10 = abs(H(2))*cos(pi/10*n15 + angle(H(2)));
figure('position',[200 200 700 170]), %input and output stem plots for x[n]=cos(pi/10*n)
 subplot(1,2,1),stem(n15,x10,'r','LineWidth',2),grid on,title('x[n]=cos(n\pi/10)'),xlabel('n')  
 subplot(1,2,2),stem(n15,y10,'r','LineWidth',2),grid on,title('y[n]'), xlabel('n'), hold off
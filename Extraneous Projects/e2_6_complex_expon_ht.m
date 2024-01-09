% file = e2_6_complex_expon_ht.m   for T/F PA on BIBO stability
clear; close all; set(0,'defaultAxesFontSize',14);
t = linspace(-0.1,3*pi,200);

h1 = heaviside(t).*((3+4j)*exp(-(1-2j)*t) +(3-4j)*exp(-(1+2j)*t));
h2 = heaviside(t).*((3+4j)*exp( 2j*t) +(3-4j)*exp(-2j*t));
figure, subplot(2,1,1), plot(t,h1,'Linewidth',2),grid on,axis tight,
  subplot(2,1,2), plot(t,h2,'r','Linewidth',2),grid on,axis tight;
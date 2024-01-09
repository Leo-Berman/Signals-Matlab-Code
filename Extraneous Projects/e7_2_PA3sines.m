% file e7_2_PA3sines.m
% plot two discrete sines 
set(0,'defaultAxesFontSize',13); close all;
n=[0:50];
n1=[0:0.1:50];  n2=[0:1:50]; 
x1 = 3*cos(0.056*pi*n1); x1_ = 3*cos(0.056*pi*n2);

x2=2*cos(0.51*pi*n1); x2_=2*cos(0.51*pi*n2);
figure('position',[100 100, 700,250]),
 plot(n1,x1,'b',n2,x1_,'ob',n1,x2,'r',n2,x2_,'or', 'LineWidth',2),grid on; 

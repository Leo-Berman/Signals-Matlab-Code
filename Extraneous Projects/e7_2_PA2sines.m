% file e7_2_PA2sines.m
% plot two discrete sines 
set(0,'defaultAxesFontSize',13); close all;
n=[0:30];
x1 = 3*cos(0.56*pi*n+1); x2=2*cos(5.1*pi*n+1);
figure('position',[100 100, 700,500]),
 subplot(2,1,1),stem(n,x1,'b','filled','LineWidth',2'),grid on, 
 subplot(2,1,2),stem(n,x2,'r','filled','LineWidth',2),grid on; 

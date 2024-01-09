% file e7_2_PA2sines.m
% plot two discrete sines 
set(0,'defaultAxesFontSize',13); close all;
n=[0:30];
x1 = cos(pi*n/3); x2=cos(pi*n/4);
figure('position',[100 100, 600,450]),
 subplot(3,1,1), stem(n,x1,'r','LineWidth',2), subplot(3,1,2), stem(n,x2,'g','LineWidth',2); 
 subplot(3,1,3), stem(n,x1+x2,'b','LineWidth',2)
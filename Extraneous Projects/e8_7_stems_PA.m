% file = e8_7_stems_PA.m   
% plot some 2-sided discrete geometrics
% both the bilateral z transform of z/(z+2)
clear; close all; set(0,'defaultAxesFontSize',16); fpv=[100 100 650 150];
L=10;
nn=[-L:-1]; np = [0:L]; 
x_a(1:L) = -((-2).^nn)       % noncausal version
x_c(1:L+1)= (-2).^np

figure('position',fpv), 
 subplot(1,2,1), stem([nn,0],[x_a,0],'b','LineWidth',1.5),grid on,xticks([-L:2:0]),axis tight,yticks([-1/4 0 1/4 1/2]) ;
 subplot(1,2,2), stem(np(1:5),x_c(1:5),'r','LineWidth',1.5),grid on,axis tight,yticks([-8:4:16]),xticks([0:4])% 
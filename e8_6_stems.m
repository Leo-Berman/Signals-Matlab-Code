% file = e8_6_stems.m  
% plot some 2-sided discrete geometrics
% both the inverse bilateral z transform of z/(z-2)
clear; close all; set(0,'defaultAxesFontSize',16); fpv=[100 100 600 120];
L=4;
nn=[-L:-1]; np = [0:L]; 
x_a(1:L) = -(2.^nn);       % noncausal version
x_c(1:L+1)= 2.^np;

figure('position',fpv), 
 subplot(1,2,1), stem(nn,x_a,'b','LineWidth',1.5),grid on,xticks([-L:0]),axis tight,yticks([-1/2 -3/8 -1/4 -1/8 0]) ;
 subplot(1,2,2), stem(np,x_c,'r','LineWidth',1.5),grid on,xticks([0:L]),axis tight,yticks([0:4:16]) 
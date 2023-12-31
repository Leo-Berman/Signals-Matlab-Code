% file = e8_5_stems2.m   
% plot some 2-sided discrete geometrics
% cannot use heaviside(n) because it =0.5 at n=0
clear; close all; set(0,'defaultAxesFontSize',15); fpv=[100 100 300 250];
L=3;
nn=[-L:-1]; np = [0:L]; n = [nn np];
x1(1:L) = -7*(4.^nn)+6*(5.^nn);       % negative half, n < 0
x1(L+1:2*L+1) = 0.5*(2.^np)+0.3*(3.^np);  % positive half, n geq 0
x2(1:L)= (0.5).^nn;
x2(L+1:2*L+1)= (-2).^np;

figure('position',fpv), 
 stem(n,x1,'b','LineWidth',1.5),grid on,axis tight,xticks([-3:3]),yticks([-2:2:12]) ;
figure('position',fpv), 
 stem(n,x2,'r','LineWidth',1.5),grid on,axis tight,xticks([-3:3]),yticks([-8:2:8]) %,title('x[n] = (-2)^nu[n] + (0.5)^nu[-n-1]')
 
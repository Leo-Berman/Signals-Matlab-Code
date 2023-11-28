% file = e7_4_BIBO_unstable.m   
% plot BIBO_unstable h[n] and sum(h[n])
clear; close all; set(0,'defaultAxesFontSize',13); 
n = [0:30];
h = ((-1).^n )./(n+1);
sum_h = cumsum(h); asum_h = cumsum(abs(h));

figure('position',[100 100 1000 200]), 
 subplot(1,3,1), stem(n,h,'b','LineWidth',1.5),title('h[n]'),grid on,
 subplot(1,3,2), stem(n,sum_h,'m','LineWidth',1.5),title('\Sigma_0^n h[n]'),grid on,
 subplot(1,3,3), stem(n,asum_h,'r','LineWidth',1.5),title('\Sigma_0^n |h[n]|'),grid on
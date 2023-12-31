% e10_9_Haar_freq_plots.m: Demonstrate Debauchies wavelets  
clear; close all; set(0,'defaultAxesFontSize',12); 
s = 1;% /sqrt(2); %Normalization factor for Haar functions
syms n z w

G(z) = s*(1 + 1/z)             % for g[n]={1,1}
Gw(w) = s*(1 + exp(-j*w)); Gw2(w) = abs(Gw*Gw)

H(z) = s*(1 - 1/z)
Hw(w) = s*(1 - exp(-j*w)); Hw2(w) = abs(Hw*Hw)

fpv=[100 100 700 200];
figure('position', fpv), 
subplot (1,2,1), fplot(abs(Gw),[0,pi],'r','LineWidth',2),title('|G_{haar}(e^{j\Omega})|'),grid on % plot freq spectrum
subplot (1,2,2), fplot(abs(Hw),[0,pi],'LineWidth',2), title('|H_{haar}(e^{j\Omega})|'),grid on 

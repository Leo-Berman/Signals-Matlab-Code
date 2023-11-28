% file: e6_6_filters_p_z.m 
% plot magnitude spectrum of H(w) having 3 complex poles and 2 complex zeros
clear; close all; set(0, 'defaultAxesFontSize',13);
w=linspace(-8,8,1000);  V=j*w;            % V is  1000 imaginary values between -j8 and j8
N=(V+2j).*(V-2j).*(V-0.1+4j).*(V-0.1-4j); % N: 1000 complex values, the numerator of H(w)
D=(V+0.5+1j).*(V+0.5-1j).*(V+0.5+3j).*(V+0.5-3j).*(V+0.5+5j).*(V+0.5-5j); % H(w)Denominator 
plot(w,abs(N./D),'r','linewidth',2),grid on,title('|M(\omega)|'),print -dpng m2.png  

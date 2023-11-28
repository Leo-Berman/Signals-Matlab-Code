% file: e9_4_Bilinear_Butter_LP.m   %IIR Butterworth lowpass filter design via bilinear tranformation 
% REQUIRES MATLAB's SYMBOLIC TOOLBOX FOR FIRST 2 LINES
% Butterworth H(s)=1/(s^3+2s^2+2s+1). Substitute s=sqrt(3)*(z-1)/(z+1) in denominator, for bilinear transform:
clear; close all;
syms z;
simplify( (sqrt(3)*(z-1)/(z+1))^3+2*(sqrt(3)*(z-1)/(z+1))^2+2*(sqrt(3)*(z-1)/(z+1))+1, 'Steps',30)
% Some versions of MATLAB yield: 
%  ans=(5*3^(1/2)*z^3-7*3^(1/2)*z^2+7*3^(1/2)*z-5*3^(1/2)+7*z^3-3*z^2-3*z+7)/(z+1)^3
% From which the coefficients of numerator and denominator are:
N=[1 3 3 1]; D=[5*sqrt(3)+7 -(3+7*sqrt(3)) 7*sqrt(3)-3 7-5*sqrt(3)];

%Plot frequency response:
w=linspace(0,pi,100);H=fft(N,200)./fft(D,200);
figure; plot(w,abs(H(1:100)));
figure; zplane(N,D);
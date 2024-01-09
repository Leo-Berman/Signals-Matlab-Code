% e8_2_trumpet_notch_template.m     
% reads sound samples (44100 sample rate), adds 750 Hz sine, 
% plays sound before and after the addition, then notch filters to remove the 750 Hz, 
% NOTE: use the exact (double precision) values of transfer function coefficients, 
%  not approximations, else the filter may be unstable, results grow to infinity
clear; close all; set(0,'defaultAxesFontSize',14);  
load trumpet.mat;             % 278 kB double-precision X array data file, must be in same folder
LX=length(X)-1;
a=0.99                        % the filter's resolution parameter
W_i = 2*pi*750/44100          % interference frequency for the notch to eliminate
XN = X + cos(W_i*[0:LX]);     % signal plus noise
y = zeros(1,LX+3);            % array to hold output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% insert code here to calculate filter coefficient values and
%%%   process XN via the filter to produce output array y
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nvec = 1:2:200;               % for stem plots
figure, subplot(3,1,1), stem(nvec, X(nvec)), grid on,title('x[n]'),
   subplot(3,1,2), stem(nvec, XN(nvec),'r'), grid on,title('x_{noisy}[n]')
   subplot(3,1,3), stem(nvec, y(nvec),'g'), grid on,title('y_{filtered}[n]')
   
soundsc(X,44100),pause(2),      % play the sounds before and after
  soundsc(XN,44100),pause(2),
    soundsc(y,44100)            % filtered sound

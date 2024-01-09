%file: e6_11_EKG_generate.m   % create simulated EKG plus noise, save as .MAT file
clear; close all;
V = [0, 1, 1.5, 1, 0, -0.5, zeros(1,10)]; % heartbeat-like signal points
X = spline(0:15, V, 0:0.0625:15.9375);    % connect the dots of V smoothly
for I = 1:6
  X=[X X];   % repeat X many cycles: 2^6 = 64 (about 1 minute of heartbeats)
end
Y = X + randn(1,length(X));               % add random Gaussian noise
figure, 
 subplot(2,1,1), plot(X),grid on, title('EKG') % see the original and noisy signals
 subplot(2,1,2), plot(Y,'r'),grid on, title('Noisy EKG')
save ekg.mat Y                           % output data file
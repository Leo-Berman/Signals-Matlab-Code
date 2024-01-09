%  file:  e8_8_Exer_filter_template.m    
%  Read trumpet sound data file, add 750 (or whatever) Hz tone, filter tone out
%  Plot the sound, sound+tone in time and freq domains.  Play the sounds.
clear; close all; fpv = [0 300 900 200]; 
set(0,'defaultAxesFontSize',13,'DefaultAxesXGrid','on','DefaultAxesYGrid','on'); 

load trumpet.mat;      % contains array X with 44100 samples/sec trumpet sound
f = 750;               % frequency of interfering tone to remove
L = length(X);
f_s = 44100;           % sampling rate
Tf = cos(2*pi*f*[0:L-1]/f_s); % f Hz tone, twice the magnitude of trumpet sound
Y = X + Tf;                     % trumpet plus tone

FX = fft(X); FY = fft(Y); FTf = fft(Tf);
figure('position', fpv),    % plot spectra
  subplot(1,3,1), plot(abs(FX)/L,'r'),title('Trumpet |X[k]|'),axis tight,
  subplot(1,3,2), plot(abs(FY)/L,'m'), title('Trumpet + tone |Y[k]|'),axis tight,
  subplot(1,3,3), plot(abs(FTf)/L,'b'), title('Tone |T[k]|'),axis tight
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% add code here to ...
%  calculate the number of Hz in each spectral line is sample_rate/samples
%  calculate the index k_t in the FFT of the tone frequency  
%  create an array [-40:40] to serve as spectral spread, to compensate for the non-integer Hz per line
%  calculate the range NN of indices of the FFT to zero (spread plus k_t )
%  remove both copies of the index range from the FFT FY (including the L-NN+2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Z=real(ifft(FY));   % convert filtered output back to time domain

figure('position', fpv),    % plot a few cycles of signals
  subplot(1,3,1), plot(X(100:600),'r'), title('Trumpet x[n]'),axis tight,
  subplot(1,3,2), plot(Y(100:600),'b'), title('Trumpet + tone'),axis tight,
  subplot(1,3,3), plot(Z(100:600),'m'), title('Filtered output'),axis tight
 
% play the sounds: trumpet, trumpet+tone, filtered
soundsc(X,f_s),pause(2),soundsc(Y,f_s),pause(2),soundsc(Z,f_s)
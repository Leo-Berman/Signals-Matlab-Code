% file: e9_2_spectrogramchirp2.m  
% Spectrogram of chirp signal x(t)=cos(w_1*t + dw*t^2/Tau), with dw=(w_2- w_1), duration Tau=1 sec
% frequency w_1 = 2000 (approx 300 Hz), w_2 = 12000 (approx 1900 Hz) which makes alpha=10000
clear; close all; set(0,'defaultAxesFontSize',14);  
LX = 8191; N = 32; L=floor((LX+1)/N);   % LX = length of chirp signal (minus 1)
t = linspace(0,1,LX+1);                 % generate LX+1 samples, in 1 second period
X=cos(2000.*t + 10000*t.^2);            % chirp signal, frequency increasing linearly with time
FXX=abs(fft(reshape(X(1:L*N),L,N)));    % partition to N intervals of L samples each, then FFT 
FXX=FXX(129:256,:); % eliminate extra mirror-image copy of frequency spectrum, and unused freqs
figure,imagesc(FXX),colormap(jet),axis off  % show spectogram

soundsc(X,8192)     % play the audio samples X to default audio output device
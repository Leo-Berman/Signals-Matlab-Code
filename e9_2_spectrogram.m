% file: e9_2_spectrogram.m   % Spectrogram of tonal version of 'The Victors'
clear; close all; set(0,'defaultAxesFontSize',14); set(0,'defaultLineLineWidth',1); 

load Ex94.mat;     % .mat file contains the sound samples in vector X, binary format
LX=length(X);      % LX = 78000 for Ex94.mat file, contains 9.5 sec of sound
S=8192;            % S = samples per second
FX=2/LX*abs(fft(X)); % scale spectrum by 
F=[0:LX-1]*S/LX;   % F is array of frequencies for spectrum plot horizontal axis
figure,plot(F(1:8000),FX(1:8000),'r'), grid on

N=26;L=floor(LX/N);       % subdividing signal samples into N=26 intervals of length L = 3000
XX=reshape(X(1:L*N),L,N); % reshape() changes 1-dimensional X vector to [L x N] 2-d matrix
FXX=abs(fft(XX));  % abs(fft(XX)).*fft(XX)) would be true spectrogram, but graph colors poorer
% fft(XX) treats the columns of XX as vectors (length L) and Fourier transforms each column.
FXX=FXX(5*L/6:L,:);% zooms in vertical axis to a 1300 Hz range
figure,imagesc(FXX),grid on % imagesc() displays image with scaled colors
  colormap(jet)    % horizontal axis scale shows interval count, not seconds
soundsc(X,S)       % play the audio samples X to default audio output device
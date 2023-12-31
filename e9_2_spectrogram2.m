% file: e9_2_spectrogram2.m   
% Spectrogram of tonal version of 'The Victors', varying segmentations
clear; close all; set(0,'defaultAxesFontSize',14); set(0,'defaultLineLineWidth',1); 

load Ex94.mat;     % .mat file contains the sound samples in vector X, binary format
LX=length(X);      % LX = 78000 for Ex94.mat file, contains 9.5 sec of sound
S=8192;            % S = samples per second

N=13;L=floor(LX/N);       % subdividing samples into N=13 intervals of length L = 6000
XX=reshape(X(1:L*N),L,N); % reshape() changes 1-dimensional X vector to [L x N] 2-d matrix
FXX=abs(fft(XX));  % abs(fft(XX)).*fft(XX)) would be true spectrogram, but graph colors poorer
FXX=FXX(5*L/6:L,:);% zooms in vertical axis to a 1300 Hz range
figure,subplot(211),imagesc(FXX),title('13 segments') %displays image with scaled colors

N=104;L=floor(LX/N);      % subdividing samples into N=104 intervals of length L = 750
XX=reshape(X(1:L*N),L,N);  
FXX=abs(fft(XX));  % does separate FFT of each matrix column (each time interval)
FXX=FXX(5*L/6:L,:);
subplot(212),imagesc(FXX),colormap(jet),title('104 segments') 

soundsc(X,S)     % play the audio samples X to default audio output device
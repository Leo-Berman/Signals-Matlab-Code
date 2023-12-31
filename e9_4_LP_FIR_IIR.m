% file: e9_4_LP_FIR_IIR.m   % Comparison of various lowpass filter designs
% REQUIRES MATLAB (or Octave) SIGNAL PROCESSING TOOLBOX FOR LINES ENDING IN **SP**
clear; close all; set(0,'defaultAxesFontSize',13);
W=2*pi*[0:104]/210;        % 0 to pi frequency range, 105 samples
H1=0.5*sinc(0.5*[-10:10]); % impulse response of brick wall lowpass, 21 points
%pkg load signal           % un-comment this pkg load line if using Octave
H1=H1.*hamming(21)';       % hamming() in SIGNAL TOOLBOX **SP**
G1=abs(fft(H1,210));

figure; subplot(2,1,1),stem(H1), axis tight,title('Hamming window')
  subplot(2,1,2),plot(W,G1(1:105)),axis tight,title('Hamming window')

F=[1 1 1 1 1 .5 zeros(1,10) .5 1 1 1 1]; % Frequency sampling
H2=fftshift(real(ifft(F)));
G2=abs(fft(H2,210));
figure; subplot(2,1,1),stem(H2),axis tight,title('Frequency sampling')
 subplot(2,1,2),plot(W,G2(1:105)),axis tight,title('Frequency sampling')

H3=firpm(20,[0 0.4 0.6 1.0],[1 1 0 0]); % firpm() in SIGNAL  TOOLBOX **SP**
G3=abs(fft(H3,210));
figure; subplot(2,1,1),stem(H3), axis tight,title('MINIMAX')
  subplot(2,1,2),plot(W,G3(1:105)), axis tight,title('MINIMAX')

[B A]=butter(10,0.5); % butter() in SIGNAL TOOLBOX %
G4=abs(fft(B,210))./abs(fft(A,210));
figure; subplot(2,1,1),zplane(B,A), title('Butterworth Bilinear IIR pz map')
  subplot(2,1,2),plot(W,G4(1:105)),axis tight,title('Butterworth Bilinear IIR')

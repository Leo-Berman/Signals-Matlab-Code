% file: e9_2_spectrogram_song_Hamming.m   % Read song .csv file, display wave and spectrogram 
% apply Hamming window to  each segment's samples before FFT
clear; close all; set(0,'defaultfigureposition',[100,100,700,600]);
  set(0,'defaultAxesFontSize',12);
X = csvread('victorstone.csv');  % expects a comma-separated-value text file of values
LX = length(X)      % size of sound vector (is 78000 samples)
S = 8192;           % sample rate, and number of points (of time, and FFT)
N = 26              % number of time segments
L = floor(LX/N)     % fft window length for spectrogram

XH = reshape(X(1:L*N),L,N); % partition into a matrix of L columns (segments)
n=[0:L-1]; Ham = [0.54+0.46*cos(pi*n/L)]';  % make a Hamming window
for c = 1:N          % apply Hamming window to each segment (column)
    XH(:,c) = XH(:,c).*Ham; % multiply each column of samples by Hamming window
end
spect = abs(fft(XH)); % spectrogram
spectL = flipud(spect(1:300,:));  % just pick low freqs to display, and move low freqs to bottom of graph 

t = linspace(0,LX/S,LX/100);  % times for a waveform plot: endtime is N/S (sample count / sample rate) 
figure, 
 subplot(2,1,1), plot(t,X(1:100:end)),title('x(t)'),xlabel('t (sec)'),xticks(0:9),
 subplot(2,1,2), imagesc(log(spectL)),colormap(jet),  % plot lower 300 freqs
    yticks([0:100:400]), title('Spectrogram with Hamming window');
%soundsc(X,S);
% file: e9_2_spectrogram_song_.m   % Read song .csv file, display wave and spectrogram 
clear; close all; set(0,'defaultfigureposition',[100,100,700,600]);
  set(0,'defaultAxesFontSize',12);
X = csvread('victorstone.csv');  % expects a comma-separated-value text file of values
LX = length(X)     % size of sound vector (is 78000 samples)
S = 8192;          % sample rate, and number of points (of time, and FFT)
N = 26             % number of segments for spectrogram time segmentation
L = floor(LX/N)    % segment length for spectrogram
t = linspace(0,LX/S,LX/100);  % time values: endtime is LX/S (sample count / sample rate) 

spect = abs(fft(reshape(X(1:L*N),L,N))); % spectrogram
spectL = flipud(spect(1:300,:));  % pick low freqs to display, move low freqs to bottom of graph 

figure, 
 subplot(2,1,1), plot(t,X(1:100:end)),title('x(t)'),xlabel('t (sec)'),xticks(0:9),
 subplot(2,1,2), imagesc(log(spectL)),colormap(jet),  % plot lower 300 freqs
    yticks([0:100:400]), title('Spectrogram');
soundsc(X,S);
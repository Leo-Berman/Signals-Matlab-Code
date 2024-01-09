% file: e9_2_spectrogram_interactive.m   % Read song .csv file, display wave and spectrogram 
clear; close all; set(0,'defaultfigureposition',[100,100,700,600]);
  set(0,'defaultAxesFontSize',12);
X = csvread('victorstone.csv');  % expects a comma-separated-value text file of values
N = length(X)             % size of sound vector (is 78000 samples)
S = 8192;                 % sample rate, and number of points (of time, and FFT)
segments = 26             % number of segments for spectrogram time segmentation
L = round(N/segments)     % Window (segment) length for spectrogram
t = linspace(0,N/S,N/100);  % time values: endtime is N/S (sample count / sample rate) 

spect = abs(fft(reshape(X,[],segments))); % spectrogram
spectL = flipud(spect(1:300,:));  % pick low freqs to display, move low freqs to bottom of graph 

f = figure('Position',[800,100,600,800]), 
 subplot(2,1,1), plot(t,X(1:100:end)),title('x(t)'),xlabel('t (sec)'),xticks(0:9),
 subplot(2,1,2), imagesc(log(spectL)),colormap(jet),  % plot lower 300 freqs
    yticks([0:100:400]), title('Spectrogram');

% Add an interactive slider-control for #segments    
b = uicontrol('Parent',f,'Style','slider','Position',[200,24,230,15],...
              'value',segments, 'min',13, 'max',52);
bl1 = uicontrol('Parent',f,'Style','text','Position',[160,20,23,23],'String',num2str(segments));
bl2 = uicontrol('Parent',f,'Style','text','Position',[70,20,100,23],...
                'String','#Segments=');
b.Callback = @(es,ed) spectro(X,round(es.Value)); % recalculate spectrogram when slider moves

%soundsc(X,S);

function spectro(X,segs)
  X(end-rem(length(X),segs)+1 : end) =[] ;   % shorten X as needed so last segment has fewer notes
  spect = abs(fft(reshape(X,[],segs))); % spectrogram
  spectL = flipud(spect(1:300,:));      % pick low freqs to display, move low freqs to bottom of graph 
  subplot(2,1,2), imagesc(log(spectL)),colormap(jet),  % plot lower 300 freqs
    yticks([0:100:400]), title('Spectrogram');
  uicontrol('Style','text','Position',[160,20,23,23],'String',num2str(segs));  % update # segments
end
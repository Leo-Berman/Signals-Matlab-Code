%file: e1_1_sound_signal.m
clear; close all;  % free memory from previous playings, if any
filen = 'Entertainer';
% filen = input('Enter name of wave file:', 's'); % uncomment this line if you want to specify a different file
[ySound, sampleFreq] = audioread(strcat(filen,'.wav'));   %audioread converts .wav file to data vector ySound
% ySound = ySound(1:ceil(length(ySound)/3));      % uncomment this line to shorten the length of clips played 
%sound(ySound,sampleFreq);                         % MATLAB sound() function, playing original .wav

D = 20;  % default downsample value
%D = input('Now playing .wav file. Enter downsample factor (>1) to play at higher frequency:');

set(0,'defaultAxesFontSize',14);
plotstart = ceil(0.5*length(ySound));    % plot last 1/5 of sound samples (downsampled)
plot(ySound(plotstart:1:plotstart+sampleFreq/2)); xlabel(['Samples at f_s freq = ',num2str(sampleFreq), ' samp/sec']);
% file: e9_11_audio_wavefile.m 
% adapted from MATLAB zyBook sect 6.2  
% Play .wav file, then downsample, play to demo higher octave,
%  then simulate upsampled original file by changing playback samples/sec
% Enter values in command window when running this script.  Ctl+c stops execution.
% Plot some of the samples mid-wave.

clear; close all; set(0,'defaultAxesFontSize',14); % free memory from previous playings, if any
filen = 'Entertainer';
%filen = input('Enter name of wave file:', 's');       % uncomment this line to allow a different file
[ySound, f_s] = audioread(strcat(filen,'.wav'));       %audioread converts .wav file to vector ySound
%ySound = ySound(1:ceil(length(ySound)/3));            % uncomment to shorten the length of clips played 
sound(ySound,f_s);                                     % play original .wav
D = 3;                                                 % default downsample value
D = input('Now playing .wav file. Enter downsample factor (>1) to play at higher frequency:');

plotstart = ceil(0.8*length(ySound));                  % plot last 1/5 of sound samples (downsampled)
plot(ySound(plotstart:D:end)); xlabel(['Samples at f_s freq = ',num2str(f_s), ' samp/sec']); 

ydSound = ySound(1:D:end);                        %downsample by factor D to higher pitch, duration 1/D
sound(ydSound,f_s); 

U = 2;                                      % default upsample value
U = input('Enter upsample factor (>1) to play at lower frequency:');
sound(ySound,f_s/U);                        %simulate upsampling by telling sound() a scaled sample rate

k = input('Press any key to play multirate version combining the above downsample/upsample:','s');
sound(ydSound,f_s/U);  % if  D=3 and U=2, plays at 3/2 note pitch (shifts A to E, or C to G)
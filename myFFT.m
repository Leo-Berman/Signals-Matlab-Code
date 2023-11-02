function varargout = myFFT(x,fs,varargin)

% Source:Dr. Iyad Obeid 
%
% USE: This function changes a function from the time domain to the 
%frequency domain.
%
% Inputs x: Is the original signals magnitude.
%        fs: Is the frequency points/time
%        varargin: IF used is the number of points in graph returned
%               Else uses at least 2^20 points or number points function
%               has which ever is more.
% Outputs X: Is the Magnitude and phase of the signal in the frequency
%         f: Is the frequency associated with each point in X
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nfft = length(x); % default assign for number of points wanted in output 
if nargin >= 3
    nfft = varargin{1}; % Since the third input is optional, this uses it as the number of points if it exists
else
    nfft = max([nfft,2^20]); % default minimum assign
    % Explanation: Assigns nfft to the maximum value of the matrix made 
    % from nfft(default assign) and 2^20 (makes sure adequate number of points)
end 

X = fft(x,nfft)/fs; % takes FFT of x 
X = fftshift(X);    % calls and FFT shift function

% Create the frequency value by manipulating fs
f = fs*(0:nfft-1)/nfft - (fs/nfft)*floor(nfft/2);

if nargout >= 1, varargout{1} = X; end %If at least one output exists, make the first output the FT of x, X
if nargout >= 2, varargout{2} = f; end %If at least two outputs exist, make the second the frequency, f
if nargout == 0, plot(f(f>=0),abs(X(f>=0))); xlabel('Frequency (Hz)'); end %If no outputs exist, plot the frequency vs. X 

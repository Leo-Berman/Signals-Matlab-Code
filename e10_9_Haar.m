% e10_9_Haar.m: Demonstrate Haar
clear; close all;
g=[1 1];
h=[1 -1];
x = [1 2 2 2 3 0 0 0]                             % zero-pad length 5 signal to length 8
%x=[4, 4, 4, 4, 4, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 4] % book example, 16 length
xL = cconv(g,x, length(x))                        % lowpass (average) signal
xH = cconv(h,x, length(x))                        % highpass (detail) signal
xHD = xH(1:2:end)                                 % downsample by 2
xLD = xL(1:2:end)                                 % downsample by 2
xLDL = cconv(g,xLD, length(xLD))                  % second-stage lowpass
xLDLD = xLDL(1:2:end)                             % downsample by 2

xLDU = [xLD; zeros(1,length(xLD))];xLDU=xLDU(:)'  % upsample the average by 2, start of reconstruction
xLDUg = cconv(g,xLDU, length(xLDU));              % convolve with g[-n]
xLDUg =[xLDUg(2:end) xLDUg(1)]                    % g[-n]: alias last element instead of first

xHDU = [xHD; zeros(1,length(xHD))];xHDU=xHDU(:)'  % upsample detail by 2
xHDUh = cconv(flip(h),xHDU, length(xHDU));        % convolve with h[-n]
xHDUh =[xHDUh(2:end) xHDUh(1)]           
x_recon = (xLDUg + xHDUh)/2                       % reconstructed signal
differ = sum(x - x_recon)                         % check that they match

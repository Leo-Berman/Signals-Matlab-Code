% e10_10_Haar8.m: Demonstrate Haar matrix-vector product
clear; close all; s = sqrt(2);
%x = [1 2 2 2 3 0 0 0]'             
x = [s 0 0 0 2*s 0 0 0]'           

Harray = [
   -2 2  0 0  0 0 0 0;
    0 0 -2 2  0 0 0 0;
    0 0  0 0 -2 2 0 0;
    0 0  0 0 0 0 -2 2;
   -s -s s s 0 0  0 0;
    0  0 0 0 -s -s s s;
   -1 -1 -1 -1 1 1 1 1;
    1  1  1  1 1 1 1 1]
    
H = 1/(2*s)* Harray        % Haar coefficient matrix
xHat = H*x                 % Haar transform

HarrayT = Harray'          % transposed (inverse) transform matrix
HT = 1/(2*s)* HarrayT;
x_recon = HT*xHat          % reconstructed signal
differ = sum(x - x_recon)  % check that they match

H*HT                   %demonstrate the transpose is the inverse
xHat2 = s*xHat         % scale the transform vector, for fun
xHat3 = xHat2; xHat3(end-2:end)=0 %zero out some values to simplify 
%xHat3 = [s 0 0 0 -1 0 0 s ]'
x2_recon = HT*xHat3    % inverse transform to x2[n]


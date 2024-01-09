% e10_8_cconv.m:  demo cyclic (circular) convolution
clear; close all;
%h = [1 2];
%x = [3 4 5 6 7 8];
h = [5 6 7];
x = [2 3 4 1 5];

s = length(x);
c = conv(h,x)
cc = cconv(h,x,s) % circluar convolution, modulo 6
hm = [2 1]; % hm = h(-n)
cm = conv(hm,x)
ccm = cconv(hm,x,s) % circluar convolution, modulo 6

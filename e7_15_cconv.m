%file: e7_15_cconv.m  % cyclic convolution via two methods
x1 = [2,1,4,3], x2 = [5,3,2,1]
y_lin = conv(x1,x2)     % compute linear convolution
N_0 = max(length(x1),length(x2));
y_cyc = cconv(x1,x2,N_0) % compute cyclic conv directly

X1 = fft(x1), X2 = fft(x2)
y_fft = ifft(X1.*X2)     % compute cyclic conv via DFTs
%file: e7_15_lin_conv.m       % linear convolution via two methods
x1 = [4,5]; x2 = [1,2,3];   
y_lin = conv(x1,x2)           % compute linear convolution

x1p = [x1,0,0], x2p = [x2,0]  % pad the signals to equal lengths 4
X1 = fft(x1p), X2 = fft(x2p)
y_fft = ifft(X1.*X2)          % compute padded cyclic conv via DFTs
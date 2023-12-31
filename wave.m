%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [XLL, XLH, XHL, XHH] = wave(G,H,X) % wavelet transform, 1 stage. Returns downsampled matrices
  L = length(G);  
  P = [repmat(X(1,:),L-1,1); X; repmat(X(end,:),L-1,1)];  P = [repmat(P(:,1),1,L-1) P repmat(P(:,end),1,L-1)];   
  % pad X with duplicated borders to minimize convolution artifacts
  XLL = conv2(G,G,P,'same'); XLL = XLL(L:2:end-L, L:2:end-L); % convolve, strip padding, and downsample by 2
  XHH = conv2(H,H,P,'same'); XHH = XHH(L:2:end-L, L:2:end-L);
  XHL = conv2(H,G,P,'same'); XHL = XHL(L:2:end-L, L:2:end-L);
  XLH = conv2(G,H,P,'same'); XLH = XLH(L:2:end-L, L:2:end-L);
end % function wave

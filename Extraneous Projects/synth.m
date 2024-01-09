%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
function Z = synth(G,H, XLL, XLH, XHL, XHH) 
% image synthesis, one stage. Returns upsampled by 2 matrix
  GM = flip(G);  HM = flip(H);  % g[-m] and h[-m]
  up = [1 0; 0 0];              % 2x2 upsample kron matrix
  L = length(G); L2=2*(L-1); % amount to strip after pad is 2*(L-1)
  % pad images with duplicated borders to minimize convolution artifacts:
  XLL = [repmat(XLL(1,:),L-1,1); XLL; repmat(XLL(end,:),L-1,1)];  
   XLL = [repmat(XLL(:,1),1,L-1) XLL repmat(XLL(:,end),1,L-1)];
  XLH = [repmat(XLH(1,:),L-1,1); XLH; repmat(XLH(end,:),L-1,1)];  
   XLH = [repmat(XLH(:,1),1,L-1) XLH repmat(XLH(:,end),1,L-1)]; 
  XHL = [repmat(XHL(1,:),L-1,1); XHL; repmat(XHL(end,:),L-1,1)];  
   XHL = [repmat(XHL(:,1),1,L-1) XHL repmat(XHL(:,end),1,L-1)]; 
  XHH = [repmat(XHH(1,:),L-1,1); XHH; repmat(XHH(end,:),L-1,1)];  
   XHH = [repmat(XHH(:,1),1,L-1) XHH repmat(XHH(:,end),1,L-1)];
  %upsample, then convolve, then strip padding
  ALL = kron(XLL, up); ALL = conv2(GM,GM,ALL,'same'); ALL= ALL(L2+1:end-L2, L2+1:end-L2);
  ALH = kron(XLH, up); ALH = conv2(GM,HM,ALH,'same'); ALH= ALH(L2+1:end-L2, L2+1:end-L2);
  AHL = kron(XHL, up); AHL = conv2(HM,GM,AHL,'same'); AHL= AHL(L2+1:end-L2, L2+1:end-L2);
  AHH = kron(XHH, up); AHH = conv2(HM,HM,AHH,'same'); AHH= AHH(L2+1:end-L2, L2+1:end-L2);
 
  Z = ALL + ALH + AHL + AHH; %Average signal is the sum of the above four outputs
  % correct for shift from convolutions by replicating 1st row, col. Works best for G1, but improves G2, G3:
  Z = [Z(1,:); Z(1:end-1, :)]; Z = [Z(:,1) Z(:,1:end-1)];
  end % function synth

  

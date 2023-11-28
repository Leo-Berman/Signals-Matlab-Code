% file: e10_18_inpaint2.m       Image Inpainting Using Daubechies. 
% Zeros random pixels in image, then inpaints to restore zeroed pixels.
% Iterative Shrinkage and Thresholding Algorithm (ISTA)
% XHAT=image estimations.  Y=compromised image. Z=wavelet of XHAT. W=inverse wavelet of Z
clear; close all; set(0,'defaultAxesFontSize',12);
X = double(imread('clown.png'));      
%X = linspace(0.1,1,128); X = X'* (X); X(50:54,:) = 0.9; X(:,40:44) = 0.7;  % simple test image
max_X = ceil(max(max(X)));  X = X/max_X; % normalize image to max pix value = 1
s = size(X); s2 = s/2; s4=s2/2; s8= s4/2;  % sizes of image and wavelets

lambda=0.01; % ISTA threshold. Larger lambda, fuzzier results; smaller yields less restoration
iterations = 200;  % number of times to do ISTA loop

G=[0.47046721,1.14111692,0.650365,-0.19093442,-0.12083221,0.0498175]; % Daubechies G3, unnormalized
%G=[0.6830127,1.1830127,0.3169873, -0.1830127]; % Daubechies G2, unnormalized
%G = 1/sqrt(2)*[1,1];  % Daubechies G1 (Haar). Results are not as good as G2 or G3
L=length(G);
R = rand(s(1),s(2));                      % random numbers matrix, valued 0 to 1
Known = find(R > 0.5);       % Known = col vector of locations of known (nonzero) values of image X
Y=zeros(s(1),s(2)); Y(Known)=X(Known);    % Y = Known values of X (black grid overlaid)
AX_K=zeros(s(1),s(2));                    % AX_K for Landweber iteration

%Initialize Landweber with all zeros, preallocate wavelet image arrays
ZLL3=zeros(s8(1),s8(2));ZLH3=zeros(s8(1),s8(2));ZHL3=zeros(s8(1),s8(2));ZHH3=zeros(s8(1),s8(2));
ZLL2=zeros(s4(1),s4(2));ZLH2=zeros(s4(1),s4(2));ZHL2=zeros(s4(1),s4(2));ZHH2=zeros(s4(1),s4(2));
ZLL1=zeros(s2(1),s2(2));ZLH1=zeros(s2(1),s2(2));ZHL1=zeros(s2(1),s2(2));ZHH1=zeros(s2(1),s2(2));

for I=1:iterations;   % ISTA loop. At 100 iterations, artifacts remain
%z^{k+1}=z^{k}+WA'(y-AW'z^{k}), where W=Wavelet, A=matrix equivalent of Known.  W'z^{k}=XHAT
 XLL2 = synthD(G,ZLL3, ZLH3, ZHL3, ZHH3);    %Inverse Wavelet transform W' z^{k}
 XLL1 = synthD(G,XLL2, ZLH2, ZHL2, ZHH2);
 XHAT = synthD(G,XLL1, ZLH1, ZHL1, ZHH1);    % for iteration #1, this XHAT is all zeros

 AX_K(Known)=XHAT(Known);  % Replace all known pixels in the iteration K guess with latest result
 % Equivalent to applying matrix A to XHAT: AW'z^{k}. If you copy all of XHAT to AX_K, ISTA does nothing !!! 
 Y_Kp1=Y-AX_K;                              % Landweber iteration
 [WLL1 WLH1 WHL1 WHH1] = waveD(G,Y_Kp1);    % 1st Stage Wavelet Transform
 [WLL2 WLH2 WHL2 WHH2] = waveD(G,WLL1);     % 2nd Stage 
 [WLL3 WLH3 WHL3 WHH3] = waveD(G,WLL2);     % 3rd Stage 

 %Now add z^{k} (previous iteration result) to all detail images (z^{k+1}=z^{k}+WA'(y-AW'z^{k})):
 ZLH1=ZLH1+WLH1; ZHL1=ZHL1+WHL1; ZHH1=ZHH1+WHH1;  ZLH2=ZLH2+WLH2; ZHL2=ZHL2+WHL2; ZHH2=ZHH2+WHH2;
 ZLH3=ZLH3+WLH3; ZHL3=ZHL3+WHL3; ZHH3=ZHH3+WHH3;  ZLL3=ZLL3+WLL3;  %Only use finest-scale average.

 %THRESHOLD/SHRINK (only the detail transforms, not the LL average image)  
 [ZHL1 ZLH1 ZHH1] = ThreShrink(ZHL1, ZLH1, ZHH1, lambda);
 [ZHL2 ZLH2 ZHH2] = ThreShrink(ZHL2, ZLH2, ZHH2, lambda);
 [ZHL3 ZLH3 ZHH3] = ThreShrink(ZHL3, ZLH3, ZHH3, lambda);

end; % end of ISTA loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Final inverse wavelet to get XHAT2 from Z:
X2LL2 = synthD(G,ZLL3, ZLH3, ZHL3, ZHH3);
X2LL1 = synthD(G,X2LL2, ZLH2, ZHL2, ZHH2);
XHAT2 = synthD(G,X2LL1, ZLH1, ZHL1, ZHH1); %End inverse wavelet transform:Z->W=XHAT.

figure('position',[100 100 1200 300]),
 subplot(1,3,1),imagesc(X),colormap(gray),title('Original image')
 subplot(1,3,2),imagesc(Y),title('Image Y with missing pixels')
 subplot(1,3,3),imagesc(XHAT2),
    title(strcat('ISTA, D',num2str(L/2),', iterations=',num2str(iterations),', \lambda=',num2str(lambda)))
diff = X-XHAT2; diffy = X-Y;% compare reconstruction and Y to original uncompromised image
mean_abs_diff = mean(abs(diff(:))), max_diff = max(diff(:)), MAD_percent = 100*mean_abs_diff/mean(abs(X(:)))
mean_abs_diffy= mean(abs(diffy(:))),max_diffy = max(diffy(:)),MAD_percenty = 100*mean_abs_diffy/mean(abs(X(:)))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% MOVE THE FUNCTIONS TO NEAR TOP OF SCRIPT, after the clear; IF USING OCTAVE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [XLL XLH XHL XHH] = waveD(G,Y) %wavelet transform, Daubechies. Convolve as impulses. 
 G=G/norm(G);L=length(G);H=fliplr(G).*(-1).^[0:L-1]; 
 sX = size(Y);  sX(2)=sX(2)/2;  % size for new arrays (XLL is N by (N/2))
 XLL = zeros(sX); XHH = XLL; XLH = zeros(sX(1)/2); XHL = XLH; %presize arrays
 X=[Y(:,end-L+2:end) Y];  % Cyclic Pre-padding (adds L-1 columns on the left)
 for N=1:L   %using a for loop allows this function to work for different lengths L (D1,D2,D3)
   XLL=XLL + G(N)*X(:,(L-N+1):2:end-N);
   XHH=XHH + H(N)*X(:,(L-N+1):2:end-N);
 end;
 XLL=XLL'; XHH=XHH'; % Transpose to convolve the rows(columns)
 XTLL=[XLL(:,end-L+2:end) XLL];XTHH=[XHH(:,end-L+2:end) XHH]; % Cyclic Pre-padding
 XLL=zeros(sX(2)); XHH=zeros(sX(2)); % reset XLL, XHH to square matrices
 for N=1:L
   XLL=XLL + G(N)*XTLL(:,(L-N+1):2:end-N);
   XHH=XHH + H(N)*XTHH(:,(L-N+1):2:end-N);
   XLH=XLH + G(N)*XTHH(:,(L-N+1):2:end-N);
   XHL=XHL + H(N)*XTLL(:,(L-N+1):2:end-N);
 end;
 XLL=XLL';XHH=XHH';XHL=XHL';XLH=XLH'; %re-transpose back to original orientation
end %function waveD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function WLL = synthD(G, ZLL, ZLH, ZHL, ZHH) %inverse wavelet transform, Daubechies
 G=G/norm(G);L=length(G);H=fliplr(G).*(-1).^[0:L-1]; L2 = L/2; K=2*size(ZLL,1);
 ZZLL=[ZLL ZLL(:,1:L2)];ZZLH=[ZLH ZLH(:,1:L2)];  %padding for cyclic convolution
 ZZHL=[ZHL ZHL(:,1:L2)];ZZHH=[ZHH ZHH(:,1:L2)];
 A1=zeros(K/2);A2=A1;B1=A1;B2=A1;C1=A1;C2=A1;D1=A1;D2=A1; %pre-alloc partial matrices
 for N=1:L2 % convolve with G, H across columns.  A1=odd columns, A2=even columns
   A1 = A1 + G(2*N-1)*ZZLL(:,N:end-L2+N-1); A2 = A2 + G(2*N)*ZZLL(:,N+1:end-L2+N);
   B1 = B1 + G(2*N-1)*ZZHL(:,N:end-L2+N-1); B2 = B2 + G(2*N)*ZZHL(:,N+1:end-L2+N);
   C1 = C1 + H(2*N-1)*ZZLH(:,N:end-L2+N-1); C2 = C2 + H(2*N)*ZZLH(:,N+1:end-L2+N);
   D1 = D1 + H(2*N-1)*ZZHH(:,N:end-L2+N-1); D2 = D2 + H(2*N)*ZZHH(:,N+1:end-L2+N);
 end
 A(:,1:2:K)=A1;A(:,2:2:K)=A2; B(:,1:2:K)=B1;B(:,2:2:K)=B2; %combine odd with even columns
 C(:,1:2:K)=C1;C(:,2:2:K)=C2; D(:,1:2:K)=D1;D(:,2:2:K)=D2; 
 A=A';AA=[A A(:,1:L2)];B=B';BB=[B B(:,1:L2)];% Transpose and pad, to convolve in the other direction
 C=C';CC=[C C(:,1:L2)];D=D';DD=[D D(:,1:L2)];
 A1=zeros(K, K/2);A2=A1;B1=A1;B2=A1;C1=A1;C2=A1;D1=A1;D2=A1; %pre-alloc partial matrices
 for N=1:L2 % convolve with G, H across columns (which were rows)
   A1 = A1 + G(2*N-1)*AA(:,N:end-L2+N-1); A2 = A2 + G(2*N)*AA(:,N+1:end-L2+N);
   B1 = B1 + H(2*N-1)*BB(:,N:end-L2+N-1); B2 = B2 + H(2*N)*BB(:,N+1:end-L2+N);
   C1 = C1 + G(2*N-1)*CC(:,N:end-L2+N-1); C2 = C2 + G(2*N)*CC(:,N+1:end-L2+N);
   D1 = D1 + H(2*N-1)*DD(:,N:end-L2+N-1); D2 = D2 + H(2*N)*DD(:,N+1:end-L2+N);
 end
 A(:,1:2:K)=A1;A(:,2:2:K)=A2; B(:,1:2:K)=B1;B(:,2:2:K)=B2; %combine odd with even columns
 C(:,1:2:K)=C1;C(:,2:2:K)=C2; D(:,1:2:K)=D1;D(:,2:2:K)=D2; 
 WLL=A+B+C+D;  WLL=WLL'; % combine partial results, transpose back
end %function synthD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
function [ZHL ZLH ZHH] = ThreShrink(ZHL, ZLH, ZHH, T)    % zero values in 3 matrices whose |magnitude|<T
 ZHL(abs(ZHL)<T)=0;  ZLH(abs(ZLH)<T)=0;  ZHH(abs(ZHH)<T)=0;  
 ZHL(abs(ZHL)>T)=ZHL(abs(ZHL)>T)-T*sign(ZHL(abs(ZHL)>T)); % shrink remaining values in 3 matrices by T
 ZLH(abs(ZLH)>T)=ZLH(abs(ZLH)>T)-T*sign(ZLH(abs(ZLH)>T)); % without the shrinkage, no inpainting effect!
 ZHH(abs(ZHH)>T)=ZHH(abs(ZHH)>T)-T*sign(ZHH(abs(ZHH)>T)); % no shrinkage, but big T, does inpaint, poorly
end % function ThreShrink
% file: e4_2_ilaplace.m 
% ac source with dc bias, inverse Laplace equations 
% Two methods: 
%  1. Use symbolic toolbox to solve mesh equ in s-domain, then ilaplace to get time-domain
%  2. Hand-solve mesh equ, then use residue() to get residue and pole values from coefficients
clear; close all; set(0, 'defaultAxesFontSize',13);
syms s;                                 % REQUIRES MATLAB's SYMBOLIC TOOLBOX.
A=[7+10/s -5-10/s; -5-10/s 8+2*s+10/s]; % mesh coefficient equations
Y=[(6*s*s+80*s+96)/(s*(s*s+16));9/s+6]; % mesh supply values 
X=A\Y                                   % yields the mesh currents I(s)
                    
%i1 = ilaplace(X(1))                    % optionally, find i1(t)
i2 = ilaplace(X(2))                     % ilaplace() yields time-domain equation, quite long
vout = 3*i2
figure, fplot(vout,[0,10]),title('v_{out}(t)'), grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Below is an alternative solution, without using the Symbolic Toolbox
% Requires hand-solving the mesh equations for I2(s), to get numerator/denom coefficients
n = [42,153,1222,3248,2400];      % numerator of hand-derived expression for I2(s), from above 
d = [14,51,274,816,800,0];
[R P] = residue(n,d)              % residue() does partial fraction expansion
Ts=0.1; T=10; t=[0:Ts:T];         % setup time segment for plotting (10 sec)
i2=real(R.'*exp(P*t));            % convert R,P to time-value array, then plot
figure, plot(t,3*i2),title('v_{out}(t)'), grid on  
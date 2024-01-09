% file: e11_4_RLC_ana.m
% Series RLC circuit: solve for current and voltages at particular frequency
R=30; L=2.7; C=1e-5;      % component values
Vs=2*exp(j*deg2rad(30))   % Source Vs = 2cos(200t+30). Convert to rectangular.
w=200;                    % frequency

XL = j*w*L, XC = 1/(j*w*C) % reactances
Z = R + XL + XC            % series circuit, add impedances to get total
I = Vs/Z
V_C = I*XC, V_L = I*XL, V_R = I*R   % get component voltages
Ip = [abs(I),rad2deg(angle(I))]     % express solution as polar phasors
V_Cp = [abs(V_C),rad2deg(angle(V_C))], V_Lp = [abs(V_L),rad2deg(angle(V_L))]
V_Rp = [abs(V_R),rad2deg(angle(V_R))]
% file:  LV2_2.m     Simulate response of car suspension to various
% pavements  M. Atkins  03/23/2020 (adapted from Labview LV2_2.vi Mathscript)
clear; close all; set(0,'defaultAxesFontSize',13); fpv=[100 100 1000 250];
M = 1000/4;   % total car mass, divided by 4 to get per wheel mass
B = 1e4;      % shock absorber damping constant
K = 1e5;      % spring constant
A = 5;        % amplitude of curb, pothole, or wavy pavement, in cm

a1=B/M; a2=K/M; b1=B/M; b2=K/M; % convert constants to LCCDE coefficients
wo=sqrt(a2)   % undamped natural frequency
alpha=a1/2;
xi=alpha/wo   % damping coefficient
if xi == 1    % avoid critically damped exact case, which blows up the formula
    xi = 0.99;
end
t = linspace(0,0.5,1000);  % times vector

% Part 1: Curb = step response of system
p1=wo*(-xi+sqrt(xi*xi-1)); p2=wo*(-xi-sqrt(xi*xi-1));
A1=(b1*p1+b2)/(p1-p2);     A2=-(b1*p2+b2)/(p1-p2);
Curb = [zeros(1,100) A*ones(1,900)];               % for plot of curb profile
Ys = A*A1/p1*(exp(p1*t)-1)+ A*A2/p2*(exp(p2*t)-1); % step response
Yc = [zeros(1,100) Ys(1:end-100)]; % delay step response to match curb profile

% Part 2: Pothole = rectangle pulse response of system
T = 0.1;                        % Pothole travel time, in seconds
D=round(900/0.5*T);  U=900-D;   % D = downtime, U = uptime
Pot = [zeros(1,100) -A*ones(1,D) zeros(1,U)]; % pothole profile
Yp = [zeros(1,100), -Ys(1:D),  -Ys(D+1:end-100)+Ys(1:U)]; 
% (negative)rectangle response = sum of 2 step responses

% Part 3: Wavy pavement
T0 = 0.314       % period of wavy pavement, in seconds
w = 2*pi/T0;
Z = A*cos(w*t);  % pavement height function
Hw = polyval([b1 b2], w*j)/polyval([1 a1 a2], w*j);  %frequency response of car
Yw = abs(Hw)*A*cos(w*t + angle(Hw));

figure('position',fpv), 
  subplot(1,3,1), plot(t,Yc,'b',t,Curb,'r'), grid on, title('Curb response'),
  subplot(1,3,2), plot(t,Yp,'b',t,Pot,'r'), grid on, title('Pothole response'),
  subplot(1,3,3), plot(t,Yw,'b',t,Z,'r'), grid on, title('Wavy pavement response')
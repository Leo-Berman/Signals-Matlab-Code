clear all
close all
clc
load head.mat

syms t s

f = .1524*((1-(7*(t)-1)^2)*heaviside(t))-(.1524*((1-(7*(t)-1)^2)*heaviside(t-.2857)));
f2 = (.1524*((1-(7*(t)-1)^2)*heaviside(t-.2857)));
f3 = f-f2
%fplot(f3,[0 1])
ylim([-1 1])
f4=1/(s^2+1);
bumpmax = findmax(Hs_head,heaviside(t)-heaviside(t-1))

% Leo Berman
% 10/10/2023
% usage: max variable = findmaxaccel(input your transfer function, input your t
% domain input
function[maxim]=findmax(transfunc,input)
    syms t
    % 10 second linspace
    

    % hold on
    % Convolves the input with the output
    out = ilaplace(transfunc*laplace(input))*heaviside(t);

    % Differentiates in order to get the first derivative of velocity
    % (acceleration)
    accel = diff(out);

    % Plots the input velocities as well as acceleration
    fplot(out,[0,5])
    hold on;
    fplot(input,[0 5]);
    hold on;
    fplot(accel,[0 5]);
    hold on;
    legend('output velocity', 'input','acceleration');
    hold off;

    t1 = linspace(.001,3,100);
    difs = abs(double(subs(accel,t,t1)));
    maxim=max(difs);
    
end
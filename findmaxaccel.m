% Leo Berman
% 10/10/2023
% usage: max variable = findmaxaccel(input your transfer function, input your t
% domain input,input your title as 'title')
function[maxim]=findmaxaccel(transfunc,in,string)
    syms t
    % 10 second linspace
    
    input=diff(in);
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
    title(string)
    hold off;

    t1 = linspace(.001,3,100);
    difs = abs(double(subs(accel,t,t1)));
    maxim=max(difs);
    snapnow
end
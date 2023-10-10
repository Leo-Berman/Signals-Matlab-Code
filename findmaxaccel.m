% Leo Berman
% 10/10/2023
% usage: max variable = findmaxaccel(input your transfer function, input your t
% domain input
function[maxim]=findmaxaccel(transfunc,input)
    syms t s
    % 10 second linspace
    t1 = linspace(.001,10,1000);
    
    % getting the transfer function
    [n, d]=numden(transfunc);
    coeffs_n=fliplr(double(coeffs(n,'All')));
    coeffs_d=fliplr(double(coeffs(d,'All')));
    mytf=tf(coeffs_n,coeffs_d);
    in = double(subs(input,t,t1));
    %save in.mat in -mat
    yt1 = lsim(mytf,in,t1);
    plot(t1,yt1);
    hold on

    % hold on
    % Convolves the input with the output
    out = ilaplace(transfunc*laplace(input))*heaviside(t);

    % Differentiates in order to get the first derivative of velocity
    % (acceleration)
    accel = diff(out);

    % Plots the input velocities as well as acceleration
    fplot(in,[0 10]);
    hold on;
    fplot(accel,[0 10]);
    hold on;
    legend('output velocity', 'input','acceleration');
    hold off;

 
    difs = subs(accel,t,t1);
    maxim=double(real(max(difs)));
end
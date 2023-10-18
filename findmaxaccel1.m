% Leo Berman
% 10/10/2023
% usage: max variable = findmaxaccel(input your transfer function, input your t
% domain input,input your title as 'title')
function[]=findmaxaccel1(transfunc1,transfunc2,transfunc3,in)
    syms t

    % 10 second linspac
    input=diff(in);
    out1 = ilaplace(transfunc1*laplace(input))*heaviside(t);
    accel1 = diff(out1);
    fplot(accel1,[0 5]);
    hold on
    out2 = ilaplace(transfunc2*laplace(input))*heaviside(t);
    accel2 = diff(out2);
    fplot(accel2,[0 5]);
    hold on
    out3 = ilaplace(transfunc3*laplace(input))*heaviside(t);
    accel3 = diff(out3);
    fplot(accel3,[0 5]);
    hold on
    title("20 mph pothold comparing k values")
    legend("2 springs","4 springs","6 springs")
end
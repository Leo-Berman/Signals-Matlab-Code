% Leo Berman
% 10/10/2023
% usage: max variable = findmaxaccel(input your transfer function, input your t
% domain input,input your title as 'title')
function[]=findmaxaccel2(transfunc1,in1,in2,in3)
    syms t

    % 10 second linspac
    input1=diff(in1);
    out1 = ilaplace(transfunc1*laplace(input1))*heaviside(t);
    accel1 = diff(out1);
    fplot(accel1,[0 2.5]);
    hold on
    input2=diff(in2);
    out2 = ilaplace(transfunc1*laplace(input2))*heaviside(t);
    accel1 = diff(out2);
    fplot(accel1,[0 2.5]);
    hold on
    input3=diff(in3);
    out3 = ilaplace(transfunc1*laplace(input3))*heaviside(t);
    accel1 = diff(out3);
    fplot(accel1,[0 2.5]);
    hold on
    title("Pothole Comparing Speeds")
    legend("20mph","35 mph","50 mph")
end
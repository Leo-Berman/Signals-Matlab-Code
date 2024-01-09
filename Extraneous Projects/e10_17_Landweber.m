% file: e10_17_Landweber.m  %Landweber iteration numbers example
x8 = [1 1 1 2 3 4 4 4];
A = 1/2*[1 1 0 0 0 0 0 0; 0 0 1 1 0 0 0 0;   % 4x8,makes y = Ax = averaged x
      0 0 0 0 1 1 0 0; 0 0 0 0 0 0 1 1]
AT = A'
Lambdas = eig(A*AT)    % eigenvalues

y = A*x8'              % y ="measurements" of x
%Landweber: 16 iterations, stored in a column matrix for easy viewing
x = zeros(8,16);
for k=2:16
    xkminus1 = x(:,k-1);
    x(:,k) = xkminus1 + AT*(y - A*xkminus1);
end
x % display the iterated values
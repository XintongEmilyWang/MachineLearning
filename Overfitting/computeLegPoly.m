function [ z ] = computeLegPoly( x, Q )
%COMPUTELEGPOLY Return the Qth order Legendre polynomial of x
%   Inputs:
%       x: vector (or scalar) of reals in [-1, 1]
%       Q: order of the Legendre polynomial to compute
%   Output:
%       z: matrix where each column is the Legendre polynomials of order 0 
%          to Q, evaluated at the corresponding x value in the input
[length, col] = size(x);
z = ones(length, Q+1);
z(:, 2) = x;
for i = 3: Q+1
    k = i-1;
    z(:, i) = ((2*k-1)/k)*z(:, i-1).*x -((k-1)/k)*z(:, i-2);
end
end


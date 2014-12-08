function [ w, e_in ] = logistic_reg( X, Y, max_its )
%LOGISTIC_REG Learn logistic regression model using gradient descent
%   Inputs:
%       X : data matrix
%       Y : data labels (plus or minus 1)
%   Outputs:
%       w : weight vector
%       e_in : in-sample error (as defined in LFD)

%initialize weight vector and gradient vector 
[m, n] = size(X);
w = zeros(1, n + 1);
t = 1;
g_t = ones(1, n + 1);
lr = 10.^-5;
N = m;

%preprocessing Y 
for j = 1 : N
    if Y(j) == 0
        Y(j) = -1;
    end
end

%logistic regression
while t < max_its && max(g_t) > 10^-3
    g_t = zeros(1, n + 1);
    for i = 1 : N
        g_t = g_t + (-1/N) * (Y(i)*[1 X(i,:)])/(1 + exp(Y(i)* mtimes([1 X(i,:)],transpose(w))));  
    end
    w = w - lr * g_t;
    t = t + 1;
end

%claculate e_in
e_in = 0;
for i = 1 : N
    e_in = e_in + (1/N) * log(1 + exp(-Y(i)* mtimes([1 X(i,:)], transpose(w))));  
end 

end


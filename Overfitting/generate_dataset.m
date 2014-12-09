function [ train_set, test_set ] = generate_dataset( Q_f, N_train, N_test, sigma )
%GENERATE_DATASET Generate training and test sets for the Legendre
%polynomials example
%   Inputs:
%       Q_f: order of the hypothesis
%       N_train: number of training examples
%       N_test: number of test examples
%       sigma: standard deviation of the stochastic noise
%   Outputs:
%       train_set and test_set are both 2-column matrices in which each row
%       represents an (x,y) pair
train_set = zeros(N_train, 2);
test_set = zeros(N_test, 2);

for i = 1 : N_train
    train_set(i, 1) = rand() * 2 - 1; 
end

for j = 1 : N_test
    test_set(j, 1) = rand() * 2 - 1; 
end

z_train = computeLegPoly(train_set(:, 1), Q_f);
a_set = normrnd(0, 1, 1, Q_f+1);

z_test = computeLegPoly(test_set(:, 1), Q_f);

norm = 0;
for k = 1 : Q_f+1
    l = k-1;
    norm = norm + 1/(2*l + 1);
end

train_set(:,2) = z_train*transpose(a_set)./norm + sigma* randn(N_train, 1);
test_set(:,2) = z_test*transpose(a_set)./norm + sigma* randn(N_test, 1);

end


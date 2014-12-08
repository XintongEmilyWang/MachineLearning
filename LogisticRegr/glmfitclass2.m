function[train_error, test_error] = glmfitclass2(train, test)
%Learn logistic regression model using inbuilt glmfit
%   Inputs:
%       train : train data matrix format like 'zip.train'
%       test : test data matrix 'zip.test'
%   Outputs:
%       train_error
%       test_error

Matrix = load(train);
[m, n] = size(Matrix);
Y = Matrix(:, 1);
X = Matrix(:, 2:n);

%preprocessing Y to binary 
for j = 1 : m
    if Y(j) ~= 1
        Y(j) = 0;
    end
end
w = glmfit(X, Y, 'binomial'); 
train_error = find_test_error(transpose(w), X, Y);

mtrx = load(test);
[M, N] = size(mtrx);
y = mtrx(:, 1);
x = mtrx(:, 2:N);
%preprocessing Y 
for j = 1 : M
    if y(j) ~= 1
        y(j) = 0;
    end
end
test_error = find_test_error(transpose(w), x, y);
end

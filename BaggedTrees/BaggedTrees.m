function [ oobErr ] = BaggedTrees( X, Y, numBags )
%BAGGEDTREES Returns out-of-bag classification error of an ensemble of
%numBags CART decision trees on the input dataset, and also plots the error
%as a function of the number of bags from 1 to numBags
%   Inputs:
%       X : Matrix of training data
%       Y : Vector of classes of the training examples
%       numBags : Number of trees to learn in the ensemble
%

[m, n] = size(X); %m is number of data points
index_set = datasample(1:m, m, 'Replace', false);%all data set index
index_diff_array = cell(1, numBags);%test data index for each bag
test_set_array = cell(1, numBags);
test_size = zeros(1, numBags);
tree_array = cell(1, numBags);%fitctree for each bag
result = zeros(m, numBags);%different tree's prediction on m data
err_array = zeros(1, numBags);

%get the decision tree and test set for each bag
test_set = [];
for j = 1 : numBags
    index = datasample(1:m, m, 'Replace', true);
    index_diff_array{1, j} = setdiff(index_set, index);
    test_set = union(test_set, setdiff(index_set, index));
    X_new = zeros(m, n);
    Y_new = zeros(m, 1);
    for i = 1: m
        X_new(i, :) = X(index(i), :);
        Y_new(i, :) = Y(index(i), :);
    end
    tree_array{1, j} = fitctree(X_new, Y_new);
    test_set_array{1, j} = test_set;
    test_size(1, j) = length(test_set);
end

%calculate prediction for each data point
for j = 1 : m
    label = zeros(1, numBags);
    for i = 1 : numBags
        temp = index_diff_array{1, i};
        if ~isempty(find(temp(1, :)== j, 1))
            label(1, i) = predict(tree_array{1, i}, X(j, :));
        end
        result(j, i) = mode(nonzeros(label));
    end
end

%out-of-bag error
for k = 1 : numBags
    tmp = test_set_array{1, k};
    N = length(tmp);
    for z = 1 : N
        if(result(tmp(z, 1), k)~=Y(tmp(z, 1), 1))
            err_array(1, k) = err_array(1, k) + 1/test_size(1, k);
        end
    end
end

figure
plot(1:1:numBags, err_array);
title('Out-of-bag Error with respect to # of Bags');
xlabel('# of Bags');
ylabel('OOB Error');

oobErr = err_array(1, numBags);
end
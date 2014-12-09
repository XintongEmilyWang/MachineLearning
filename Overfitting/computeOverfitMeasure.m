function [ overfit_m ] = computeOverfitMeasure( true_Q_f, N_train, N_test, var, num_expts )
%COMPUTEOVERFITMEASURE Compute how much worse H_10 is compared with H_2 in
%terms of test error. Negative number means it's better.
%   Inputs
%       true_Q_f: order of the true hypothesis
%       N_train: number of training examples
%       N_test: number of test examples
%       var: variance of the stochastic noise
%       num_expts: number of times to run the experiment
%   Output
%       overfit_m: vector of length num_expts, reporting each of the
%                  differences in error between H_10 and H_2
overfit_m = zeros(num_expts, 1);
for i = 1: num_expts
    [train_set, test_set] = generate_dataset( true_Q_f, N_train, N_test, sqrt(var) );
    L_2 = computeLegPoly(train_set(:, 1), 2);
    L_10 = computeLegPoly(train_set(:, 1), 10);
    
    %best weight vector
    [b_2, dev_2] = glmfit(L_2, train_set(:, 2), 'normal', 'constant', 'off');
    [b_10, dev_10] = glmfit(L_10, train_set(:, 2), 'normal', 'constant', 'off');
    
    %test_set
    L_test_2 = computeLegPoly(test_set(:, 1), 2);
    L_test_10 = computeLegPoly(test_set(:, 1), 10); 
    y_2 = mtimes(L_test_2, b_2);
    y_10 = mtimes(L_test_10, b_10);
    
    test_error_2 = 0;
    test_error_10 = 0;
    for j = 1: N_test
        test_error_2 = test_error_2 + (1/N_test)*(y_2(j) - test_set(j, 2)).^2;
        test_error_10 = test_error_10 + (1/N_test)*(y_10(j) - test_set(j, 2)).^2;
    end
    overfit_m(i, 1) = test_error_10 - test_error_2;
end
end


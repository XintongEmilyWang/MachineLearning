[X, Y] = Preprocessing('adult.data.txt');
%build ensemble of bagged decision trees
ncat = [1:7, 11];
vars = {'Age', 'WorkClass', 'education', 'MaritualStatus', ...
    'occupation', 'race', 'sex', 'cgain', 'closs', 'hourpweek', 'country'};
Bagger = TreeBagger(200, X, Y, 'PredictorNames', vars, ...
     'CategoricalPredictors', ncat, 'SampleWithReplacement', 'On', ...
     'OOBPred', 'On');

%plot the out-of-bag error over the number of grown classification trees
%on the training data set: adult.data
oobErrorBaggedEnsemble = oobError(Bagger);
plot(oobErrorBaggedEnsemble)
xlabel 'Number of grown trees';
ylabel 'Out-of-bag classification error on training data';

[X_test, Y_test] = Preprocessing('adult.test.txt');
Y_predict = cell2mat(predict(Bagger, X_test));
test_classification_err = 0;
for i = 1 : length(Y_test)
    if (str2double(Y_predict(i, 1)) ~= Y_test(i, 1))
        test_classification_err = test_classification_err + ...
            1/length(Y_test);
    end
end
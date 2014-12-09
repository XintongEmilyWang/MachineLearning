%Script that runs the set of necessary experiments. This is an example that
%you can use; you should change it as appropriate to answer the question to
%your satisfaction.

Q_f = 5:5:20; % Degree of true function
N = 40:40:120; % Number of training examples
var = 0:0.5:2; % Variance of stochastic noise

expt_data_mat = zeros(length(Q_f), length(N), length(var));
expt_data_mat_mean = zeros(length(Q_f), length(N), length(var));

for ii = 1:length(Q_f)
    for jj = 1:length(N)
        for kk = 1:length(var)
            overfit = computeOverfitMeasure(Q_f(ii),N(jj),1000,var(kk),500);
            expt_data_mat(ii,jj,kk) = median(overfit);
            expt_data_mat_mean(ii,jj,kk) = mean(overfit);
        end
    end
    fprintf('.');
end

plot_graphs;
            
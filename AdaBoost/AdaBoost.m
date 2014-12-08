function [ train_err, test_err ] = AdaBoost( X_tr, y_tr, X_te, y_te, n_trees )
%AdaBoost: Implement AdaBoost using decision stumps learned
%   using information IG as the weak learners.
%   X_tr: Training set
%   y_tr: Training set labels
%   X_te: Testing set
%   y_te: Testing set labels
%   n_trees: The number of trees to use
[Ntrain,~]=size(X_tr);
[Nt,~]=size(X_te);

%initialize equal weight for each data point
weight=repmat(1/Ntrain,1,Ntrain);
%weight vector for each decision stump
alpha=zeros(n_trees,1);
epsilon=zeros(n_trees,1);
feature_ind=zeros(n_trees,1);
feature_value=zeros(n_trees,1);
left_sign = zeros(n_trees,1);
right_sign = zeros(n_trees,1);
output = zeros(Ntrain,n_trees);

%generate n_trees decision stumps
for t = 1 : n_trees   
    [feature_ind(t), feature_value(t), left_sign(t), right_sign(t), predict] ...
        = Infogain(X_tr, y_tr, weight);

    epsilon(t)=sum(weight(find(predict~=y_tr)));
    alpha(t)=(1/2)*log((1-epsilon(t))/epsilon(t));
    %%update weight vector
    for j = 1 : Ntrain
        if predict(j) == y_tr(j)
            weight(j) = weight(j)*exp(-alpha(t));
        else
            weight(j) = weight(j)*exp(alpha(t));
        end
    end

    weight=weight./sum(weight);
    output(:,t)=predict;
end

test_predict=zeros(Nt,n_trees);
for i = 1 : n_trees
    temp = zeros(Nt,1);
    left_node = X_te(:,feature_ind(i))<feature_value(i);
    right_node = X_te(:,feature_ind(i))>=feature_value(i);
    temp(left_node) = left_sign(i);
    temp(right_node) = right_sign(i);
    test_predict(:,i) = temp;
end

ensemble_train = sign(sum((bsxfun(@times,output,alpha')),2));
train_err = sum(ensemble_train~=y_tr)/Ntrain;
ensemble_test = sign(sum((bsxfun(@times,test_predict,alpha')),2));
test_err = sum(ensemble_test~=y_te)/Nt;
end

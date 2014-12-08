function [feature_index, feature_value, left_sign, right_sign, hypo] = Infogain( X_tr, y_tr, D)
%   X_tr: Training set
%   y_tr: Training set labels
%   D: weight vector for each data point in the training set
[Ntrain,Dtrain]=size(X_tr);
IG_value=zeros(1,Dtrain);
%keep track of the attribute value
split_value=zeros(1,Dtrain);

%loop through each feature of the dataset
for i = 1 : Dtrain
    p = sum(D(y_tr == 1));
    n = sum(D(y_tr == -1));
    %vector for the same attribute of all data points
    attribute = X_tr(:,i);
    %get unique values within the attribute vecotr
    unique_attr = unique(attribute);
    %keep track of the value of information IG
    IG = zeros(length(unique_attr),1);
    %find IG value for each attribute
    for j = 2 : length (unique_attr)
        %find the positive data in group1 and group2
        Group1 = attribute < unique_attr(j);
        p1 = sum(D(y_tr.*Group1 == 1));
        n1 = sum(D(y_tr.*Group1 == -1));
        Group2 = attribute >= unique_attr(j);   
        p2 = sum(D(y_tr.*Group2 == 1));    
        n2 = sum(D(y_tr.*Group2 == -1));
        
        remainder=(p1+n1)*Entro(p1/(p1+n1))+(p2+n2)*Entro(p2/(p2+n2));
        IG(j-1)=Entro(p/(p+n))-remainder;
    end
    [gainv,gaini]=max(IG);
    %keep track the value of largest IG
    IG_value(1,i)=gainv;
    %keep track of the feature value with largest IG
    split_value(i,1)=unique_attr(gaini);
end

%find which feature to create the decision stump
[~,feature_index] = max(IG_value);
feature_value = split_value(feature_index, 1);
split_feature = X_tr(:,feature_index);
hypo = zeros(Ntrain,1);
%decide the sign of the split value
left_index = split_feature < split_value(feature_index);
leftn = sum(D(y_tr.*left_index == -1));
leftp = sum(D(y_tr.*left_index == 1));
if leftp >= leftn
    hypo(left_index)=1;
    left_sign=1;
else
    hypo(left_index)=-1;
    left_sign=-1;
end

right_index = split_feature >= split_value(feature_index);
rightn = sum(D(find(y_tr(right_index) == -1)));
rightp = sum(D(find(y_tr(right_index) == 1)));
if rightp >= rightn
    hypo(right_index) = 1;
    right_sign = 1;
else
    hypo(right_index) = -1;
    right_sign = -1;
end
end
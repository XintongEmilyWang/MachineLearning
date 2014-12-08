function [X, Y] = Preprocessing(filename)
warning('off','all');
warning;
datafile = readtable(filename, 'Delimiter', ',');
[N, M] = size(datafile);

%data preprocessing
% '<=50K' as 1 and '>50K' as 0
Y = zeros(N, 1);
for i = 1 : N
    if (strcmp(datafile{i, 15}, '<=50K') || strcmp(datafile{i, 15}, '<=50K.'))
        Y(i, 1) = 1;
    end
end
X_pre = horzcat(datafile(:, 1:2), datafile(:, 4), datafile(:, 6:7), ...
    datafile(:, 9:14));
%convert continuous age to indices
age = X_pre{:, 1};
edges = 10:10:100;
labels = strcat(num2str((10:10:90)','%d'),{'s'});
AgeGroup = ordinal(age,labels,[],edges);
age_indices = grp2idx(AgeGroup);
% %convert capital gain
% gain = X_pre{:, 8};
% gainGroup = ordinal(gain,{'none','low', 'medium', 'high'}, ...
%     [],[0 100 1000 5000 10000]);
% gain_indices = grp2idx(gainGroup);
% %convert capital loss
% %mode 0, median 0, range 0-99999, mean 1000
% %mode and median 0, range 0- 4356, mean 87
% loss = X_pre{:, 9};
% lossGroup = ordinal(loss,{'low', 'medium', 'high'}, [],[0 500 2000 5000]);
% loss_indices = grp2idx(lossGroup);
% %convert working hour per week
% hour = X_pre{:, 10};
% edg = 0:10:100;
% lab = strcat(num2str((0:10:90)','%d'),{'s'});
% HourGroup = ordinal(hour,lab,[],edg);
% hour_indices = grp2idx(HourGroup);

X = horzcat(age_indices, grp2idx(X_pre{:, 2}), grp2idx(X_pre{:, 3}), ...
    grp2idx(X_pre{:, 4}), grp2idx(X_pre{:, 5}), grp2idx(X_pre{:, 6}), ...
    grp2idx(X_pre{:, 7}), X_pre{:, 8}, X_pre{:, 9}, X_pre{:, 10}, ...
    grp2idx(X_pre{:, 11}));
end
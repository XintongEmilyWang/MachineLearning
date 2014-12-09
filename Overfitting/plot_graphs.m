Q_f = 5:5:20; % Degree of true function
N = 40:40:120; % Number of training examples
var = 0:0.5:2; % Variance of stochastic noise

%Q_f
figure;
h1=subplot(2,1,1);
plot(Q_f,expt_data_mat(:,1,1),'k-',Q_f,expt_data_mat(:,1,3),'r--',Q_f,expt_data_mat(:,1,5),'b:',...
    Q_f,expt_data_mat(:,3,1),'k-+',Q_f,expt_data_mat(:,3,3),'r-*',Q_f,expt_data_mat(:,3,5),'b-o');

legend('N=40, var=0','N=40, var=1','N=40, var=2','N=120, var=0','N=120, var=1','N=120, var=2');
xlabel('Q_f');
ylabel('overfit measure');
title('Overfit measure regarding Qf (median)');

h2=subplot(2,1,2);
plot(Q_f,expt_data_mat_mean(:,1,1),'k-',Q_f,expt_data_mat_mean(:,1,3),'r--',Q_f,expt_data_mat_mean(:,1,5),'b:',...
    Q_f,expt_data_mat_mean(:,3,1),'k-+',Q_f,expt_data_mat_mean(:,3,3),'r-*',Q_f,expt_data_mat_mean(:,3,5),'b-o');

legend('N=40, var=0','N=40, var=1','N=40, var=2','N=120, var=0','N=120, var=1','N=120, var=2');
xlabel('Q_f');
ylabel('overfit measure');
title('Overfit measure regarding Qf (mean)');

axis([h1 h2],'auto')
saveas(gcf,'Overfit measure regarding to the complexity of the true hypothesis.fig')

%N
figure;
h1=subplot(2,1,1);
plot(N,expt_data_mat(1,:,1),'k-',N,expt_data_mat(1,:,3),'r--',N,expt_data_mat(1,:,5),'b:',...
    N,expt_data_mat(4,:,1),'k-+',N,expt_data_mat(4,:,3),'r-*',N,expt_data_mat(4,:,5),'b-o');

legend('Q_f=5, var=0','Q_f=5, var=1','Q_f=5, var=2','Q_f=20, var=0','Q_f=20, var=1','Q_f=20, var=2')
xlabel('N');
ylabel('overfit measure');
title('Overfit measure regarding to N (median)');

h2=subplot(2,1,2);
plot(N,expt_data_mat_mean(1,:,1),'k-',N,expt_data_mat_mean(1,:,3),'r--',N,expt_data_mat_mean(1,:,5),'b:',...
    N,expt_data_mat_mean(4,:,1),'k-+',N,expt_data_mat_mean(4,:,3),'r-*',N,expt_data_mat_mean(4,:,5),'b-o');

legend('Q_f=5, var=0','Q_f=5, var=1','Q_f=5, var=2','Q_f=20, var=0','Q_f=20, var=1','Q_f=20, var=2')
xlabel('N');
ylabel('overfit measure');
title('Overfit measure regarding N (mean)');

axis([h1 h2],'auto')
saveas(gcf,'Overfit measure regarding to the number of training examples.fig')

%variance
themedian=reshape(expt_data_mat,[12 5]);
themean=reshape(expt_data_mat_mean,[12 5]);
figure;
h1=subplot(2,1,1);
plot(var,themedian(1,:),'k-',var,themedian(3,:),'r--',var,themedian(5,:),'b:',...
    var,themedian(7,:),'k-+',var,themedian(9,:),'r-*',var,themedian(11,:),'b-o');

legend('Q_f=5, N=40','Q_f=5, N=80','Q_f=10, N=40','Q_f=10, N=80','Q_f=20, N=40','Q_f=20, N=80')
xlabel('variance');
ylabel('overfit measure');
title('Overfit measure regarding to variance (median)');

h2=subplot(2,1,2);
plot(var,themean(1,:),'k-',var,themean(3,:),'r--',var,themean(5,:),'b:',...
    var,themean(7,:),'k-+',var,themean(9,:),'r-*',var,themean(11,:),'b-o');

legend('Q_f=5, N=40','Q_f=5, N=80','Q_f=10, N=40','Q_f=10, N=80','Q_f=20, N=40','Q_f=20, N=80')
xlabel('variance');
ylabel('overfit measure');
title('Overfit measure regarding variance (mean)');
axis([h1 h2],'auto')
saveas(gcf,'Overfit measure regarding to variance.fig')
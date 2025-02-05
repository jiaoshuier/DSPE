tic
addpath(genpath(pwd));

%% Real data
dataset = {'breast-w-original'};   
i = 1;
dir = fullfile('D:\dir of your data');
instances = csvread(strcat(dir,dataset{i},'.csv'),1,0);
[M(i,:),S(i,:)] = CmpFixMetrics(instances);

toc/60





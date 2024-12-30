
function [Mavg, Mstd]= CmpFixMetrics(instances)

fold=10;
runs=10; % ten runs of a stratified ten-fold cross-validation
auc = [];
gmean = [];
recall = [];

rounds = 10;  % base classifier number

for j = 1:runs
    labels = instances(:, end);
    indices = crossvalind('Kfold',labels,fold);
    for i = 1:fold
        idx_test = (indices == i);
        idx_train = ~idx_test;
        test_ins = instances(idx_test, :);
        test_data = test_ins(:,1:end-1);
        test_labels = test_ins(:,end);
        train_ins = instances(idx_train, :);

        ensemble = DSPE(train_ins,rounds);
        [pred_test] =  EnsemblePred(ensemble,test_data);

        %%
        metric = index(test_labels, pred_test); 
        auc = [auc metric(1)];
        recall = [recall metric(4)];  
        gmean = [gmean metric(2)];
        
    end
end
M = [auc;gmean;recall];
Mavg = round(mean(M,2),4)*100;
Mstd = round(std(M,0,2),4)*100;


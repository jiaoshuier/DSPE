function metric = index(label_y,y_p)
% 1 正类
% 0 负类

% label_y:  true    
% y_p:      predict  
tp=0;
tn=0;
fp=0;
fn=0;

for i = 1:length(label_y)
    if label_y(i) == 1 && y_p(i) == 1
        tp = tp + 1;
    elseif label_y(i) == 0 && y_p(i) == 0
        tn = tn + 1;
    elseif label_y(i) == 0 && y_p(i) == 1
        fp = fp + 1;
    else
        fn = fn + 1;
    end
end

recall = tp/(tp+fn);
specificity = tn/(tn+fp);
Gmean = sqrt(recall*specificity);
precision = tp/(tp+fp);
f1_score = 2*(precision*recall)/(precision+recall);
auc = (specificity + recall)/2;
metric = [auc,Gmean,f1_score,recall,specificity,precision];
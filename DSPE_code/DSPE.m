
function ens = DSPE(train_ins,rounds,categorical)
% trade-off between Static and dynamic difficulty
% DSPE:
% self-paced factor: alpha = sqrt(6)/((rounds+1-i)*pi);
% lambda = 0, static and dynamic equal importance

train_labels = train_ins(:,end);
pos_ins = train_ins(train_labels==1, :);
neg_ins = train_ins(train_labels==0, :);
h_pos = size(pos_ins,1);
h_neg = size(neg_ins,1);
randidx_4_neg = randperm(size(neg_ins, 1), size(pos_ins,1));
neg_ins_b= neg_ins(randidx_4_neg,:);
bal_ins = [pos_ins;neg_ins_b];

[psd,nsd] = GetSD(pos_ins, neg_ins);
delta = h_neg - h_pos;

ensemble(1).trees = cell(rounds,1);
ensemble(1).alpha = zeros(rounds,1);
ensemble(1).thresh = 0;

cur_pos = pos_ins;
lambda = 0;

for i = 1:rounds % 未达到平衡
    alpha = sqrt(6)/((rounds+1-i)*pi);
    overnum = round(alpha^2*delta);
    if overnum<1
        overnum = 1;
    end
    bal_data = bal_ins(:, 1:end-1);
    bal_labels = bal_ins(:, end);

    model = fitctree(bal_data,bal_labels);
    ensemble(1).trees{i} = model;
    ensemble(1).alpha(i) = 1;
    [~, pos_prob] = predict(model, pos_ins(:, 1:end-1));
    [~, neg_prob] = predict(model, neg_ins(:, 1:end-1));

    [pdd,ndd] = GetDD(pos_prob,neg_prob);
    loss_pos = (1+lambda)*psd+pdd;
    loss_pos = loss_pos/sum(loss_pos);
    cdf_pos = cumsum(loss_pos);

    loss_neg = (1+lambda)*nsd+ndd;
    loss_neg = 1-loss_neg/sum(loss_neg);
    loss_neg = loss_neg/sum(loss_neg);
    cdf_neg = cumsum(loss_neg);

    %%   SPL oversampling
    for j = 1:overnum
        r = rand();
        while isempty(find(r<=cdf_pos,1,'first'))
            r = rand();
        end
        select_pos_idx(j) = find(r<=cdf_pos,1,'first');
    end
    select_pos = pos_ins(select_pos_idx, :);
    smote_ins = SMOTE_1(pos_ins,select_pos); %选中的小类样本产生1个新样本
    cur_pos = [cur_pos;smote_ins];
    undernum = size(cur_pos,1);
    %% SPL undersampling
    for jj = 1:undernum
        rr = rand();
        while isempty(find(rr<=cdf_neg,1,'first'))
            rr = rand();
        end
        select_neg_idx(jj) = find(rr<=cdf_neg,1,'first');
    end
    select_neg = neg_ins(select_neg_idx, :);
    bal_ins = [cur_pos;select_neg];

end

bal_data = bal_ins(:, 1:end-1);
bal_labels = bal_ins(:, end);

%%  majority voting ensemble
model = fitctree(bal_data,bal_labels);
ensemble(1).trees{1} = model;
ensemble(1).alpha(1) = 1;
ensemble(1).thresh = sum(ensemble(1).alpha)/2;
ens = ensemble;

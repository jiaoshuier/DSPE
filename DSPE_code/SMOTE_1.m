function new = SMOTE_1(pos_ins,select_pos)
smote_k = 5;
pos_data = pos_ins(:,1:end-1);
select_data = select_pos(:,1:end-1);
[~,idx] = pdist2(pos_data,select_data,'euclidean','Smallest',smote_k);
h_select = size(idx,2);
num_att = size(pos_data,2);
r = floor(rand(1,h_select)*smote_k)+1;
for i = 1:h_select
    weight = rand(h_select,num_att);
    new(i,:) = select_data(i,:)+weight(i,:).*(pos_data(idx(r(i),i),:)-select_data(i,:));
end
new = [new ones(h_select,1)];
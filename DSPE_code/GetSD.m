function [psd,nsd]  = GetSD(pos_ins, neg_ins)

%%
k = 5;     %  neighbor number 5
pos_data = pos_ins(:,1:end-1);
neg_data = neg_ins(:,1:end-1);

[pDist] = pdist2(pos_data,pos_data,'euclidean','Smallest',k+1); 
[pnDist] = pdist2(neg_data,pos_data,'euclidean','Smallest',k);
pmd = mean(pDist,1);
pnmd = mean(pnDist,1);
psd = 1./(pmd+0.001)+1./(pnmd+0.001);  
psd = psd/sum(psd);


[nDist] = pdist2(neg_data,neg_data,'euclidean','Smallest',k+1); 
[npDist] = pdist2(pos_data,neg_data,'euclidean','Smallest',k);
nmd = mean(nDist,1);
npmd = mean(npDist,1);
nsd = 1./(nmd+0.001)+1./(npmd+0.001);
nsd = nsd/sum(nsd);




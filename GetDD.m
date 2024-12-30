function [pdd,ndd] = GetDD(pos_prob,neg_prob)
pos_prob(pos_prob(:,2)==0,2) = 1E-4;
pdd = -log(pos_prob(:,2)');
if sum(pdd)==0
    pdd = ones(1,size(pos_prob,1))/size(pos_prob,1);
else
pdd = pdd/sum(pdd);
end

neg_prob(neg_prob(:,1)==0,1) = 1E-4;
ndd = -log(neg_prob(:,1)');
if sum(ndd)==0
    ndd = ones(1,size(neg_prob,1))/size(neg_prob,1);
else
ndd = ndd/sum(ndd);
end

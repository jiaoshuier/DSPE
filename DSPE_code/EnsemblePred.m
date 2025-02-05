

function pred = EnsemblePred(ensemble,test_data)

p_te = zeros(size(test_data,1),1);
node = length(ensemble.trees);

for j = 1:node
    p_te = p_te + ensemble.alpha(j) * (predict(ensemble.trees{j},test_data));
end
pred = p_te>=node/2;


function [S, freq] = pSpec(X, stv,ftv, fcut)
res = 1/1000;
X2 = X(:,1:round(ftv/stv):end);

od = chooseOrder(X2, 'BIC');

[~, noisecov, Aall] = pos_nGrangerT2(X2,od);

len = 1/ftv/res;

S = Makeup4SpectrumFact(permute(A2S(Aall, noisecov,len),[3 1 2]))*ftv;

ratio = fcut/(1/2/ftv);

freq = (0:round(len*ratio)-1)*res;
S(round(len*ratio/2)+1:end-round(len*ratio/2),:,:) = [];
end
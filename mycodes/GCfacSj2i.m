%compute GC from S len*p*p 
%compute GC from j to i
function GCj2i = GCfacSj2i(S,j,i,iter)
if ~exist('iter','var')
    iter = 1;
end
p = size(S,2);

idx = 1:p;
idx([i j]) = [];
SN = permuteS(S,[i idx j]);
SN1 = SN(:,1:p-1,1:p-1);

cov1 = covfacS(SN1,iter);
cov = covfacS(SN,iter);
GCj2i = log(cov1(1,1)/cov(1,1));




%compute GC from S len*p*p
function GC = GCfacS(S,iter)
if ~exist('iter','var')
    iter = 1;
end
p = size(S,2);
GC = zeros(p,p);
for i = 1:p
    for j = 1:p
        if i ~= j
        GC(i,j) = GCfacSj2i(S,j,i,iter);     
        end
    end
end
%compute GC from S len*p*p
function GC = GCfacS(S,iter,mode)
if ~exist('iter','var')
    iter = 1;
end
if ~exist('mode','var')
    mode = 1;
end
p = size(S,2);
GC = zeros(p,p);
for j = 1:p
%     for j = 1:p
%         if i ~= j
%         GC(i,j) = GCfacSj2i(S,j,i,iter,mode);     
%         end
%     end
    GC(:,j) = GCfacSj2x(S,j, iter,mode); 
end
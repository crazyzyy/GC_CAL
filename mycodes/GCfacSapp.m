%compute GC from S len*p*p 
%compute GC from j to i
function GC = GCfacSapp(S,iter, mode,od)
if ~exist('iter','var')
    iter = 1;
end
if ~exist('mode','var')
    mode = 1;
end

if ~exist('od','var')
    od = 50;
end


p = size(S,2);

GC = zeros(p,p);
for j = 1:p

idx = 1:p;
idx(j) = [];
SN = permuteS(S,[idx j]);
SN1 = SN(:,1:p-1,1:p-1);

Hv = zeros(size(S));

switch mode
    case 1
        [~,Hv1] = covfacS(SN1,iter);
        Hv(:,1:p-1,1:p-1) = Hv1;
        [~,Hvp] = covfacS(SN(:,p,p),iter);
        Hv(:,p,p) = Hvp;
        SW = nUprod(Hv,SN);
    case 2
        [~,~,Hv1] = WIfacS(SN1,iter);
        Hv(:,1:p-1,1:p-1) = Hv1;
        [~,~,Hvp] = WIfacS(SN(:,p,p),iter);
        Hv(:,p,p) = Hvp;
        SW = nUprod(Hv,SN);
end

for i = 1:p-1
    cv = real(ifft(SW(:,i,p)));
    GC(idx(i),j) = sum(cv(1:od).^2);
end

end
%preprocessing
%given time series x,regression order p,
%return X:(l-p)*p,Y:(l-p)*1
function [X,Y]=x2reg(x,p)
l=length(x);
X=zeros(l-p,p);
Y=x(p+1:end)';
for i=1:p
    X(:,i)=x(i:l-p-1+i)';
end
end
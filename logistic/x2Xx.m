function [XX1,X1,XX2,X2]=x2Xx(x,p)
x1=x(1,:);x2=x(2,:);
[XX1,X1]=x2reg(x1,p);
[XX2,X2]=x2reg(x2,p);
L=length(X1);
XX1=fliplr(XX1);
XX2=fliplr(XX2);
end
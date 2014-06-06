%logistic GC,two variables
function [GC,dev,b,c]=lgc(x,p)
x1=x(1,:);x2=x(2,:);
[XX1,X1]=x2reg(x1,p);
[XX2,X2]=x2reg(x2,p);
% XX1=fliplr(XX1);
% XX2=fliplr(XX2);
[b1,devb1]=glmfit(XX1,X1,'binomial');
[b2,devb2]=glmfit(XX2,X2,'binomial');
[c1,devc1]=glmfit([XX1 XX2],X1,'binomial');
[c2,devc2]=glmfit([XX1 XX2],X2,'binomial');
yf10=glmval(b1,XX1,'logit');
yf20=glmval(b2,XX2,'logit');
yf11=glmval(c1,[XX1 XX2],'logit');
yf21=glmval(c2,[XX1 XX2],'logit');
gc1=log(var(X1-yf10)/var(X1-yf11));
gc2=log(var(X2-yf20)/var(X2-yf21));
GC=[gc1,gc2];
GC=GC*1000;
b=[b1 b2];
c=[c1 c2];
dev=[devb1 devc1;devb2 devc2];
end
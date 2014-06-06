%logistic GC,two variables
function [GC,b,c]=fgc(x,p)
x1=x(1,:);x2=x(2,:);
[XX1,X1]=x2reg(x1,p);
[XX2,X2]=x2reg(x2,p);
b1=glmfit(XX1,X1,'normal');
b2=glmfit(XX2,X2,'normal');
c1=glmfit([XX1 XX2],X1,'normal');
c2=glmfit([XX1 XX2],X2,'normal');
yf10=glmval(b1,XX1,'identity');
yf20=glmval(b2,XX2,'identity');
yf11=glmval(c1,[XX1 XX2],'identity');
yf21=glmval(c2,[XX1 XX2],'identity');
gc1=log(var(X1-yf10)/var(X1-yf11));
gc2=log(var(X2-yf20)/var(X2-yf21));
GC=[gc1,gc2];
b=[b1;b2];
c=[c1;c2];
end
%temp compare
warning off;
tic;[a,pace,err,det1]=LogisticR(X,Y,5,100);toc;
 tic;[b1,devb1]=glmfit(X,Y,'binomial');toc
 mS=@(x,y,n) 1/n*(x*log(1+exp(-y))'+(1-x)*log(1+exp(y))');
  L=length(Y);
X_1=[ones(L,1) X];
y1=a*X_1';
y2=b1'*X_1';
S1=mS(Y',y1,L);
S2=mS(Y',y2,L);
S1-S2
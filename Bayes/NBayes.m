%NaiveBayes

m = 50;
Y = floor(X*m);
p = 1;
[XX1,X1,XX2,X2]=x2Xx(Y,p);

res1 = NBayesAV(XX1,X1);
res12 = NBayesAV([XX1 XX2],X1); 

res2 = NBayesAV(XX2,X2);
res21 = NBayesAV([XX1 XX2],X2);

GC = [0, log(res1/res12); log(res2/res21), 0]


% m = 100;
% Y = floor(x*m);
% p = 1;
% [XX1,X1]=x2reg(Y,p);XX1=fliplr(XX1);
% res1 = NBayesAV(XX1,X1);




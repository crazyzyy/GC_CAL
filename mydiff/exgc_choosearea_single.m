%single exgc choosearea
p = 1;
[XX1,X1,XX2,X2]=x2Xx(X,p);

% x0 = [0.95,0.3];
% x0 = [0.3,0.95];
% x0 = [0.05,0.95];
R = 0.1*p;

YY = [XX1 XX2];
Yd = bsxfun(@minus,YY,x0);
d = sqrt(sum(Yd.*Yd,2));
idx = find(d<R);
length(idx)

YY1 = XX1(idx,:);
YY2 = XX2(idx,:);
Y1 = X1(idx,:);
Y2 = X2(idx,:);
ExGC(YY1,Y1,YY2,Y2)
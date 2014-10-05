%select vectors around a fixed point

[XX1,X1,XX2,X2]=x2Xx(X,1);
% x0 = [0 0.9 0.9 0.8];
x0 = [0,0.95];
YY = [XX1 XX2];
Yd = bsxfun(@minus,YY,x0);
d = sqrt(sum(Yd.*Yd,2));
idx = find(d<0.2);
YY1 = XX1(idx,:);
YY2 = XX2(idx,:);
Y1 = X1(idx,:);
Y2 = X2(idx,:);
[GC] = ExGC(YY1,Y1,YY2,Y2)
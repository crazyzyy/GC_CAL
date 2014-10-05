%select vectors around a fixed point
p = 3;
[XX1,X1,XX2,X2]=x2Xx(X,p);
N = 1000;
xx = rand(N,p*2);
GC = zeros(2,2,N);
R = 0.1*p;
LL = zeros(1,N);
YY = [XX1 XX2];
for i = 1:N
    x0 = xx(i,:);
% x0 = [0 0.9 0.9 0.8];
% x0 = [0,0.95];

Yd = bsxfun(@minus,YY,x0);
d = sqrt(sum(Yd.*Yd,2));
idx = find(d<R);
LL(i) = length(idx);
length(idx)
if length(idx)>=10000
YY1 = XX1(idx,:);
YY2 = XX2(idx,:);
Y1 = X1(idx,:);
Y2 = X2(idx,:);
[GC(:,:,i)] = ExGC(YY1,Y1,YY2,Y2);
end
end

% figure;hist(squeeze(GC(2,1,:)),50)
% figure;hist(squeeze(GC(1,2,:)),50)
figure;
plot(squeeze(GC(2,1,:)),squeeze(GC(1,2,:)),'o')
ax = axis;
axis([0 max(ax) 0 max(ax)])


mean(squeeze(GC(2,1,:)))
mean(squeeze(GC(1,2,:)))

m1 = max(squeeze(GC(2,1,:)))
m2 = max(squeeze(GC(1,2,:)))
find(squeeze(GC(2,1,:))==m1)

idr = find(GC(2,1,:)>0.95*m1);
figure;plot(xx(idr,p:-1:1)')
figure;plot(xx(idr,2*p:-1:p+1)')

% idw = find(GC(1,2,:)>0.95*m2);
% figure;plot(xx(idw,p:-1:1)')
% figure;plot(xx(idw,2*p:-1:p+1)')

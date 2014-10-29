function [] = BZ(X,NET_tmp,C)
ISM = MYinferND_cond(X);

id1 = NET_tmp ~=0;
id2 = NET_tmp == 0;
IE = ISM(id1)./NET_tmp(id1);
% figure;hist(IE(IE>0),50)

% std(IE)/mean(IE)

GC = nGrangerT(X,20);
GCh = sqrt(GC);
IEg = GCh(id1)./NET_tmp(id1);
% std(IEg)/mean(IEg)

figure(1)
subplot(2,2,1)
hist(IE,50);
subplot(2,2,2)
hist(ISM(id2),50);
subplot(2,2,3)
hist(IEg,50);
subplot(2,2,4)
hist(GCh(id2),50);

save([C,'_cond.mat'],'ISM','NET_tmp','GC');
print('-depsc2',[C,'_condpic.eps'])
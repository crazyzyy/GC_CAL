%temp spectrum all

[p,len] = size(X);
od = chooseOrderAuto(X);
[GC, Deps, Aall] = pos_nGrangerT2(X, od);
X = gendata_linear(Aall,Deps,len);

fcut = 0.5; ftv = 1;
[uS,ufreq,uSall] = npSpec2(X, stv,ftv, fcut, 'u'); %(S: n*p*p)
[rS,rfreq,rSall] = npSpec2(X, stv,ftv, fcut, 'r');


[la,lambda,Amp] = fit_ncx2_ld(squeeze(uSall(:,1,1,:))');
plot(ufreq,abs(la),ufreq,mean(squeeze(uSall(:,1,1,:)),2))
hist(squeeze(uSall(60,1,1,:)),100)

% 
%  od = chooseOrderAuto(X);
% [GC, Deps, Aall] = pos_nGrangerT2(X, od);

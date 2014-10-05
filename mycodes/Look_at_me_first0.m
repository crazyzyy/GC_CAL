% usage example
% Warning: No Chinese characters in the file path
addpath GCcal

netstr = 'net_2_2';  % network structure, see directory prj_neuron_gc/network/
scee = 0.02;         % cortical strength, Ex. to Ex.
pr = 1;              % poisson input rate
ps = 0.0225;          % poisson input strength
simu_time = 1e6;     % simulation time
stv = 0.5;           % sample time interval

[X, ISI, ras] = gendata_neu(netstr, scee, pr, ps, simu_time, stv);
[p,len] = size(X);   % get the number of neurons and length of data
clear X
STtv=1;
fac=STtv/stv;
ST = SpikeTrains(ras,p,len/fac,STtv);
od=chooseOrder(ST,'BIC',50);
% tic;[GC,dev,b,c]=lgc(ST,od);toc
% GC
% tic
% pos_nGrangerT2(ST,od)*1000
% toc
% [res,wa]=WhiteningFilter(ST,od);
% 
% plot(1:od+1,-b(:,1),1:od+1,[0 wa(1,:)]*15)



[X,Y]=x2Xx(ST,od);
warning('off');
% tic;[a,pace,err,det1]=LogisticR(X,Y,5,100);toc;
% tic;[b1,devb1]=glmfit(X,Y,'binomial');toc
% 
% L=length(Y);p=size(X,2)+1;
% X_1=[ones(L,1) X];
% PI=@(x) 1./(1+exp(-x));
% res=a*X_1';
% resf=PI(res);
% 
% [GC,dev,b,c]=lgc(ST,od);

[LGC,GC,b,c,SSf,res]=lgc2(ST,od);
[GCpos,varpos]=pos_nGrangerT2(ST,od);
% % plot the figures
% bg = round(1e4/stv);
% rg = bg:round(bg+100/stv);
% 
% figure(1);
% plot(rg, X(:,rg));
% 
% figure(2);
% plot(rg, ST(:,rg));

% T1=(ras(:,1)==1).*ras(:,2);
% T1(ras(:,1)==2)=[];
% dT1=T1(2:end)-T1(1:end-1);
% [n,xout]=hist(dT1,100);
% plot(xout,log(n))
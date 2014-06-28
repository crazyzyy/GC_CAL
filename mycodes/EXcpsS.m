%EXcpsS
%parametric&nonparametric(uniform)&nonparametric(nonuniform,random)

%data generation

netstr = 'net_2_2';  % network structure, see directory prj_neuron_gc/network/
scee = 0.01;         % cortical strength, Ex. to Ex.
pr = 1   ;              % poisson input rate
ps = 0.012;          % poisson input strength
simut = '1e7'; simu_time = str2double(simut);     % simulation time
stv = 1/8;           % sample time interval
data_dir_prefix = 'D:\GCdata\';

% netstr = 'net_3_03';
% pr = 0.24;ps = 0.02;
%%%%%%%%%%%%%%%%%%%%%%%%Great Changes have been made applying suitable RC
%%%%%%%%%%%%%%%%%%%%%%%%filter to capture the value at endpoints
[X, ISI, ras] = gendata_neu(netstr, scee, pr, ps, simu_time, stv,'new --RC-filter 0 1',data_dir_prefix);

[p,len] = size(X);
% fcut = 1;  %(kHz)(fcut <= 1/(2*ftv))
% ftv = 0.25;
fcut = 0.5; ftv = 0.5; fcut2 = 0.1;

% [uS,ufreq,uSall] = npSpec2(X, stv,ftv, fcut, 'u'); %(S: n*p*p)
% [rS,rfreq,rSall] = npSpec2(X, stv,ftv, fcut, 'r');
[rS,rfreq] = npSpec(X, stv,ftv, fcut, 'r');


[uS,ufreq] = npSpec(X, stv,ftv, fcut, 'u'); %(S: n*p*p)

rS2 = epfitSn(rS,rfreq);
% [uSW, ufreqW] = npSpecW(X, stv,ftv, fcut,fcut2, 'u');
% [uS,ufreq] = npSpec(X, stv,ftv, fcut, 'u',25); %(S: n*p*p)
% [rS,rfreq] = npSpec(X, stv,ftv, fcut, 'r',25);

% [uuS,uufreq] = npSpec(X, stv,stv, fcut, 'u');
[S,freq] = pSpec(X, stv,ftv, fcut);

od = chooseOrderAuto(X(:,1:round(ftv/stv):end))

%GC computation
[GC, Deps, Aall] = pos_nGrangerT2(X(:,1:round(ftv/stv):end),od);
disp(GC)
uGC = getGCSapp_scaled(uS,ufreq,od)
% uGCW = getGCSapp(uSW,od)

rGC = getGCSapp_scaled(rS,rfreq, od)
rGC2 = getGCSapp_scaled(rS2,rfreq, od)
% uuGC = getGCSapp(uuS,od)
aGC = getGCSapp_scaled(S,freq, od) %(order should be enough)

% [uS2,ufreq2]=FreqCut_zyy(uS,ufreq,0.5);getGCSapp(uS2,od)


[uSW, uXW, uYW]= StdWhiteS(uS);[rSW, rXW, rYW]= StdWhiteS(rS);
[SW, XW, YW ]= StdWhiteS(S); [rSW2,rXW2,rYW2] = StdWhiteS(rS2);
lx = 1:50;
ucxy = real(ifft(uSW(:,1,2)));ucxy1 = ucxy(lx+1);ucxy2 = ucxy(end-(lx-1));
rcxy = real(ifft(rSW(:,1,2)));rcxy1 = rcxy(lx+1);rcxy2 = rcxy(end-(lx-1));
r2cxy = real(ifft(rSW2(:,1,2)));r2cxy1 = r2cxy(lx+1);r2cxy2 = r2cxy(end-(lx-1));
cxy = real(ifft(SW(:,1,2)));cxy1 = cxy(lx+1);cxy2 = cxy(end-(lx-1));
%compare whitened covariance
figure
plot(lx,ucxy1,'-r',lx,ucxy2,'--r',lx,rcxy1,'-b',lx,rcxy2,'--b', ...
    lx,r2cxy1,'-k',lx,r2cxy2,'--k',lx,cxy1,'-m',lx,cxy2,'--m','linewidth',2)


% compare factorization of auto spectrum All
figure
 subplot(2,2,1)
 plot(ufreq,abs(uXW),rfreq,abs(rXW),freq,abs(XW),rfreq,abs(rXW2))
 subplot(2,2,2)
 plot(ufreq,abs(uYW),rfreq,abs(rYW),freq,abs(YW),rfreq,abs(rYW2))
 subplot(2,2,3)
 plot(ufreq,angle(uXW),rfreq,angle(rXW),freq,angle(XW),rfreq,angle(rXW2))
 subplot(2,2,4)
 plot(ufreq,angle(uYW),rfreq,angle(rYW),freq,angle(YW),rfreq,angle(rYW2))



%compare S
 figure
 subplot(2,2,1)
 plot(ufreq,uS(:,1,1),rfreq,rS(:,1,1),freq,S(:,1,1))
 subplot(2,2,2)
 plot(ufreq,abs(uS(:,1,2)),rfreq,abs(rS(:,1,2)),freq,abs(S(:,1,2)))
 subplot(2,2,3)
 plot(ufreq,uS(:,2,2),rfreq,rS(:,2,2),freq,S(:,2,2))
 subplot(2,2,4)
 plot(ufreq,angle(uS(:,1,2)),rfreq,angle(rS(:,1,2)),freq,angle(S(:,1,2)))
%compare Spec ri
 figure
 subplot(2,2,1)
 plot(ufreq,uS(:,1,1),rfreq,rS(:,1,1),freq,S(:,1,1))
 subplot(2,2,2)
 plot(ufreq,real(uS(:,1,2)),rfreq,real(rS(:,1,2)),freq,real(S(:,1,2)))
 subplot(2,2,3)
 plot(ufreq,uS(:,2,2),rfreq,rS(:,2,2),freq,S(:,2,2))
 subplot(2,2,4)
 plot(ufreq,imag(uS(:,1,2)),rfreq,imag(rS(:,1,2)),freq,imag(S(:,1,2)))

%compare S all
 figure
 subplot(2,2,1)
 plot(ufreq,uS(:,1,1),rfreq,rS(:,1,1),freq,S(:,1,1),rfreq,rS2(:,1,1))
 subplot(2,2,2)
 plot(ufreq,abs(uS(:,1,2)),rfreq,abs(rS(:,1,2)),freq,abs(S(:,1,2)),rfreq,abs(rS2(:,1,2)))
 subplot(2,2,3)
 plot(ufreq,uS(:,2,2),rfreq,rS(:,2,2),freq,S(:,2,2),rfreq,rS2(:,2,2))
 subplot(2,2,4)
 plot(ufreq,angle(uS(:,1,2)),rfreq,angle(rS(:,1,2)),freq,angle(S(:,1,2)),rfreq,angle(rS2(:,1,2)))
 
 %compare S all ri
 figure
 subplot(2,2,1)
 plot(ufreq,uS(:,1,1),rfreq,rS(:,1,1),freq,S(:,1,1),rfreq,rS2(:,1,1))
 subplot(2,2,2)
 plot(ufreq,real(uS(:,1,2)),rfreq,real(rS(:,1,2)),freq,real(S(:,1,2)),rfreq,real(rS2(:,1,2)))
 subplot(2,2,3)
 plot(ufreq,uS(:,2,2),rfreq,rS(:,2,2),freq,S(:,2,2),rfreq,rS2(:,2,2))
 subplot(2,2,4)
 plot(ufreq,imag(uS(:,1,2)),rfreq,imag(rS(:,1,2)),freq,imag(S(:,1,2)),rfreq,imag(rS2(:,1,2)))


%compare SpecW  
  figure
 subplot(2,2,1)
 plot(ufreq,uSW(:,1,1),rfreq,rSW(:,1,1),freq,SW(:,1,1))
 subplot(2,2,2)
 plot(ufreq,abs(uSW(:,1,2)),rfreq,abs(rSW(:,1,2)),freq,abs(SW(:,1,2)))
 subplot(2,2,3)
 plot(ufreq,uSW(:,2,2),rfreq,rSW(:,2,2),freq,SW(:,2,2))
 subplot(2,2,4)
 plot(ufreq,angle(uSW(:,1,2)),rfreq,angle(rSW(:,1,2)),freq,angle(SW(:,1,2)))
 
%compare SpecW ri
   figure
 subplot(2,2,1)
 plot(ufreq,uSW(:,1,1),rfreq,rSW(:,1,1),freq,SW(:,1,1))
 subplot(2,2,2)
 plot(ufreq,real(uSW(:,1,2)),rfreq,real(rSW(:,1,2)),freq,real(SW(:,1,2)))
 subplot(2,2,3)
 plot(ufreq,uSW(:,2,2),rfreq,rSW(:,2,2),freq,SW(:,2,2))
 subplot(2,2,4)
 plot(ufreq,imag(uSW(:,1,2)),rfreq,imag(rSW(:,1,2)),freq,imag(SW(:,1,2)))

%compare SpecW all
 figure
 subplot(2,2,1)
 plot(ufreq,uSW(:,1,1),rfreq,rSW(:,1,1),freq,SW(:,1,1),rfreq,rSW2(:,1,1))
 subplot(2,2,2)
 plot(ufreq,abs(uSW(:,1,2)),rfreq,abs(rSW(:,1,2)),freq,abs(SW(:,1,2)),rfreq,abs(rSW2(:,1,2)))
 subplot(2,2,3)
 plot(ufreq,uSW(:,2,2),rfreq,rSW(:,2,2),freq,SW(:,2,2),rfreq,rSW2(:,2,2))
 subplot(2,2,4)
 plot(ufreq,angle(uSW(:,1,2)),rfreq,angle(rSW(:,1,2)),freq,angle(SW(:,1,2)),rfreq,angle(rSW2(:,1,2)))
 
 %compare SpecW all ri
 figure
 subplot(2,2,1)
 plot(ufreq,uSW(:,1,1),rfreq,rSW(:,1,1),freq,SW(:,1,1),rfreq,rSW2(:,1,1))
 subplot(2,2,2)
 plot(ufreq,real(uSW(:,1,2)),rfreq,real(rSW(:,1,2)),freq,real(SW(:,1,2)),rfreq,real(rSW2(:,1,2)))
 subplot(2,2,3)
 plot(ufreq,uSW(:,2,2),rfreq,rSW(:,2,2),freq,SW(:,2,2),rfreq,rSW2(:,2,2))
 subplot(2,2,4)
 plot(ufreq,imag(uSW(:,1,2)),rfreq,imag(rSW(:,1,2)),freq,imag(SW(:,1,2)),rfreq,imag(rSW2(:,1,2)))


% % [rS1,rfreq1] = npSpec(X, stv,ftv, fcut, 'r',100,1/1000);
% % [rS2,rfreq2] = npSpec(X, stv,ftv, fcut, 'r',1000,1/1000);
% % [rS3,rfreq3] = npSpec(X, stv,ftv, fcut, 'r',10000,1/1000);
% 
% clear('X')
% save(['pics\data_',netstr,'_',num2str(pr),'_',num2str(ps),'_',simut,'_',num2str(fcut),'.mat'])




% figure
% set(gca,'fontsize',20)
% plot(ftv,rGC(:,1,2),'-r',ftv,rGC(:,2,1),'-g', ...
%     ftv,uGC(:,1,2),'--r',ftv,uGC(:,2,1),'--g','linewidth',2)
% 
% xlabel('sampling interval length \tau (ms)')
% ylabel('GC')
% print('-dpsc2',['pics\name.eps'])



 
%   figure;plot(ufreq,real(uS(:,1,2)),rfreq,real(rS(:,1,2)),freq,real(S(:,1,2)))
%   figure;plot(ufreq,imag(uS(:,1,2)),rfreq,imag(rS(:,1,2)),freq,imag(S(:,1,2)))
  
XX = SpikeTrains(ras, 2, len, stv);
XX2 = WhiteningFilter(XX,100);
[tg_ave, s_rel_time] = spikeTriggerAve(1, 2, ras, XX2, [-200 200], stv);
[tg_ave2, s_rel_time2] = spikeTriggerAve(2, 1, ras, XX2, [-200 200], stv);

figure
subplot(2,1,1)
set(gca,'fontsize',20)
plot(s_rel_time,tg_ave,'linewidth',2)
% axis([-25 25 0.4 0.425])
subplot(2,1,2)
set(gca,'fontsize',20)
plot(s_rel_time2,tg_ave2,'linewidth',2)


for i = 0:19
    tg(i+1) = mean(tg_ave((i)*20+2:(i+1)*20+1));
    tg2(i+1) = mean(tg_ave2((i)*20+2:(i+1)*20+1));
    rel_t(i+1) = mean(s_rel_time((i)*20+2:(i+1)*20+1));
    rel_t2(i+1) = mean(s_rel_time2((i)*20+2:(i+1)*20+1));
    
end
figure
subplot(2,1,1)
set(gca,'fontsize',20)
plot(rel_t,tg,'*','linewidth',2)
ax = axis;
axis([0 ax(2:4)])
% axis([-25 25 0.4 0.425])
subplot(2,1,2)
set(gca,'fontsize',20)
plot(rel_t2,tg2,'*','linewidth',2)
ax = axis;
axis([0 ax(2:4)])
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
 
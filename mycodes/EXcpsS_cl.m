%EXcpsS_cl
%parametric&nonparametric(uniform)&nonparametric(nonuniform,random)

%data generation

netstr = 'net_2_2';  % network structure, see directory prj_neuron_gc/network/
scee = 0.01;         % cortical strength, Ex. to Ex.
pr = 1   ;              % poisson input rate
ps = 0.012;          % poisson input strength
simu_time = 5e6;  simut = '5e6';   % simulation time
stv = 1/8;           % sample time interval
data_dir_prefix = 'D:\GCdata\';

% pr = 0.24;ps = 0.02;
%%%%%%%%%%%%%%%%%%%%%%%%Great Changes have been made applying suitable RC
%%%%%%%%%%%%%%%%%%%%%%%%filter to capture the value at endpoints
[X, ISI, ras] = gendata_neu(netstr, scee, pr, ps, simu_time, stv,'new --RC-filter 0 1',data_dir_prefix);

[p,len] = size(X);
% fcut = 1;  %(kHz)(fcut <= 1/(2*ftv))
% ftv = 0.5;
fcut = 0.5; ftv = 0.5; fcut2 = 0.1;

[rS,rfreq] = npSpec(X, stv,ftv, fcut, 'r');
[uS,ufreq] = npSpec(X, stv,ftv, fcut, 'u'); %(S: n*p*p)

rS2 = epfitS2(rS,rfreq);

[S,freq] = pSpec(X, stv,ftv, fcut);

od = chooseOrderAuto(X(:,1:round(ftv/stv):end))

[uSW, uXW, uYW]= StdWhiteS(uS);[rSW, rXW, rYW]= StdWhiteS(rS);
[SW, XW, YW ]= StdWhiteS(S); [rSW2,rXW2,rYW2] = StdWhiteS(rS2);
%GC computation
[GC, Deps, Aall] = pos_nGrangerT2(X(:,1:round(ftv/stv):end),od);
disp(GC)
uGC = getGCSapp_scaled(uS,ufreq,od)
rGC = getGCSapp_scaled(rS,rfreq, od)
rGC2 = getGCSapp_scaled(rS2,rfreq, od)
aGC = getGCSapp_scaled(S,freq, od) %(order should be enough)

figure(1)
set(gca,'fontsize',18)
plot(ufreq,abs(uSW(:,1,2)),rfreq,abs(rSW(:,1,2)),freq,abs(SW(:,1,2)),...
    rfreq,abs(rSW2(:,1,2)),'linewidth',1.5);
tp = axis;
axis([0 max(freq)/2 tp(3:4)])
xlabel('f (kHz)')
ylabel('|S^W_x_y|')

% figure(2)
% set(gca,'fontsize',18)
% plot(rfreq,real(rS(:,1,1)),'g*',freq,real(S(:,1,1)),'-r',...
%     rfreq,real(rS2(:,1,1)),'--k','linewidth',2);
% tp = axis;
% axis([0 max(freq)/2 0 tp(4)])
% xlabel('f (kHz)')
% ylabel('Sxx')
% 
% figure(3)
% set(gca,'fontsize',18)
% plot(rfreq,real(rS(:,1,2)),'g*',freq,real(S(:,1,2)),'-r',...
%     rfreq,real(rS2(:,1,2)),'--k','linewidth',2);
% tp = axis;
% axis([0 max(freq)/2 tp(3:4)])
% xlabel('f (kHz)')
% ylabel('Re(Sxy)')
% 
% figure(4)
% set(gca,'fontsize',18)
% plot(rfreq,imag(rS(:,1,2)),'g*',freq,imag(S(:,1,2)),'-r',...
%     rfreq,imag(rS2(:,1,2)),'--k','linewidth',2);
% tp = axis;
% axis([0 max(freq)/2 tp(3:4)])
% xlabel('f (kHz)')
% ylabel('Im(Sxy)')
















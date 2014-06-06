%sampling nonparametric GC
% matlabpool open 4
tic
netstr = 'net_2_2';  % network structure, see directory prj_neuron_gc/network/
scee = 0.02;         % cortical strength, Ex. to Ex.
pr = 1;              % poisson input rate
ps = 0.012;          % poisson input strength
simu_time = 1e7; simut = '1e7';    % simulation time
stv = 0.125;           % sample time interval
data_dir_prefix = 'D:\GCdata\';


[X, ISI, ras] = gendata_neu(netstr, scee, pr, ps, simu_time, stv,'new',data_dir_prefix);

ftv = 0.5:0.5:10;
len = length(ftv);
rGC = zeros(2,2,len);
uGC = rGC;

fcut = 0.1;
parfor i = 1:len


[rS,rfreq] = npSpec(X, stv,ftv(i), fcut, 'r'); %(S: n*p*p)

fcut2 = fcut;
if fcut2>1/2/ftv(i)
    fcut2 = 1/2/ftv(i)
end
od = chooseOrderAuto(X(1:ftv(i)/stv:end));
[uS,ufreq] = npSpec(X, stv,ftv(i), fcut2, 'u');
rGC(:,:,i) = getGCSapp(rS,od);
uGC(:,:,i) = getGCSapp(uS,od);
end

rGC = permute(rGC,[3 1 2]);
uGC = permute(uGC,[3 1 2]);

figure
set(gca,'fontsize',20)
plot(ftv,rGC(:,1,2),'-r',ftv,rGC(:,2,1),'-g', ...
    ftv,uGC(:,1,2),'--r',ftv,uGC(:,2,1),'--g','linewidth',2)

xlabel('sampling interval length \tau (ms)')
ylabel('GC')
print('-dpsc2',['pics\',netstr,'_',num2str(pr),'_',num2str(ps),'_',simut,'_',num2str(fcut),'_',num2str(max(ftv)),'.eps'])
legend('rGC_x2y','rGC_y2x','uGC_x2y','uGC_y2x')
print('-dpsc2',['pics\',netstr,'_',num2str(pr),'_',num2str(ps),'_',simut,'_',num2str(fcut),'_',num2str(max(ftv)),'_lgd.eps'])
clear('X','X2','ras')
save(['pics\',netstr,'_',num2str(pr),'_',num2str(ps),'_',simut,'_',num2str(fcut),'_',num2str(max(ftv)),'.mat'])
toc
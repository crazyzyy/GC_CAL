% pN = 20;
% p = 0.3;
% Penal = rand(pN);
% NET_tmp = Penal <= p;
% NET_tmp = NET_tmp.*(ones(pN)-eye(pN));
% % NET_tmp = NET_tmp .*(rand(pN).*1.5+0.5);
% save('prj_neuron_gc\network\NET_tmp2.txt','NET_tmp','-ascii');


% netstr = 'net_3_03';  % network structure, see directory prj_neuron_gc/network/
% netstr = 'net_10_1';
netstr = 'NET_tmp2';
% netstr = 'net_2_2';

scee = 0.005;         % cortical strength, Ex. to Ex.
pr = 1   ;              % poisson input rate
ps = 0.009;          % poisson input strength
simut = '3e6'; simu_time = str2double(simut);     % simulation time
stv = 0.5;           % sample time interval
data_dir_prefix = 'D:\GCdata\';

scee = [0.005 0.005 0.005 0.005];

% netstr = 'net_3_03';
% pr = 0.24;ps = 0.035;
%%%%%%%%%%%%%%%%%%%%%%%%Great Changes have been made applying suitable RC
%%%%%%%%%%%%%%%%%%%%%%%%filter to capture the value at endpoints
[X, ISI, ras] = gendata_neu(netstr, scee, pr, ps, simu_time, stv,'new -n 12 8  --RC-filter 0 1',data_dir_prefix);


% fid = fopen('J:\03_DATA\data\HH_volt_net_100_0X07E0EF5A_p=80,20_sc=0.004,0.004,0.007,0.007_pr=1_ps=0.007_stv=0.5_t=1.00e+06.dat', 'r');
%  X = fread(fid, [100, Inf], 'double');
% fclose(fid);
% load('J:\03_DATA\data\net_100_0X07E0EF5A.txt')
% NET_tmp = net_100_0X07E0EF5A;

ISM = MYinferND_cond(X);

id1 = NET_tmp ~=0;
id2 = NET_tmp == 0;
IE = ISM(id1)./NET_tmp(id1);
% figure;hist(IE(IE>0),50)
figure;hist(IE,50)
figure;hist(ISM(id2),50);
figure;hist(ISM(:),100)
std(IE)/mean(IE)

GC = nGrangerT(X,20);
GCh = sqrt(GC);
IEg = GCh(id1)./NET_tmp(id1);
figure;hist(IEg,50)
figure;hist(GCh(id2),50)
figure;hist(GCh(:),100)
std(IEg)/mean(IEg)

save(['result20_4I_',simut,'.mat'],'ISM','NET_tmp','GC');





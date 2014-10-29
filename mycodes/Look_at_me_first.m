% pN = 10;
% p = 0.3;
% Penal = rand(pN);
% NET_tmp = Penal <= p;
% NET_tmp = NET_tmp.*(ones(pN)-eye(pN));
% NET_tmp = NET_tmp .*(rand(pN).*1.5+0.5);
% save('prj_neuron_gc\network\NET_tmp2.txt','NET_tmp','-ascii');


netstr = 'net_2_2';  % network structure, see directory prj_neuron_gc/network/
% netstr = 'net_10_1';
% netstr = 'NET_tmp';

scee = 0.01;         % cortical strength, Ex. to Ex.
pr = 1   ;              % poisson input rate
ps = 0.012;          % poisson input strength
simut = '1e6'; simu_time = str2double(simut);     % simulation time
stv = 0.5;           % sample time interval
data_dir_prefix = 'D:\GCdata\';

% netstr = 'net_3_03';
% pr = 0.24;ps = 0.05;
%%%%%%%%%%%%%%%%%%%%%%%%Great Changes have been made applying suitable RC
%%%%%%%%%%%%%%%%%%%%%%%%filter to capture the value at endpoints
[X, ISI, ras] = gendata_neu(netstr, scee, pr, ps, simu_time, stv,'new --RC-filter 0 1',data_dir_prefix);


% fid = fopen('LIF_volt_net_100_0X1BD7844F_p=100,0_sample01.dat', 'r');
%  X = fread(fid, [100, Inf], 'double');
% fclose(fid);

MYinferND_cond(X)

% ISM = MYinferND(X);
% 
% id1 = NET_tmp ~=0;
% id2 = NET_tmp == 0;
% IE = ISM(id1)./NET_tmp(id1);
% % figure;hist(IE(IE>0),50)
% figure;hist(IE,50)
% figure;hist(ISM(id2),50)





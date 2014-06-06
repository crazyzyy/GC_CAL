% netstr = 'net_2_2';  % network structure, see directory prj_neuron_gc/network/
netstr = 'net_3_03';
neu_num = str2double(netstr(5));
scee = 0.02;         % cortical strength, Ex. to Ex.
pr = 1   ;              % poisson input rate
ps = 0.012;          % poisson input strength
simut = '1e8'; simu_time = str2double(simut);     % simulation time
stv = 1/8;           % sample time interval
%data_dir_prefix = 'D:\GCdata\';
data_dir_prefix = '/scratch/yz1961/GCdata/'


% pr = 0.24;ps = 0.02;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Great Changes have been made applying suitable RC filter to capture the value at endpoints
[~, ISI, ras] = gendata_neu(netstr, scee, pr, ps, simu_time, stv,'--RC-filter 0 1',data_dir_prefix);


Tstv = 1;
corlen = 15; %ms
reglen = ceil(corlen/Tstv);
Tlen = simu_time;

ST = SpikeTrainsT(ras, neu_num, Tlen, Tstv);

GC = nGrangerT(ST,reglen)
save('GC_1e8.mat','GC')
%STW = WhiteningFilter(ST,reglen);
%[~,STJR] = GC_regression(ST,reglen);
%trgplot(1,3,ras,STW,Tstv)
%trgplot(2,3,ras,STJR,Tstv)



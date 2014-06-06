netstr = 'net_2_2';  % network structure, see directory prj_neuron_gc/network/
% netstr = 'net_3_03';
neu_num = str2double(netstr(5));
scee = 0.01;         % cortical strength, Ex. to Ex.
pr = 1   ;              % poisson input rate
ps = 0.012;          % poisson input strength
simut = '1e6'; simu_time = str2double(simut);     % simulation time
stv = 1/8;           % sample time interval
data_dir_prefix = 'D:\GCdata\';

% stv = 1;
% pr = 0.24;ps = 0.02;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Great Changes have been made applying suitable RC filter to capture the value at endpoints
[X, ISI, ras] = gendata_neu(netstr, scee, pr, ps, simu_time, stv,'--RC-filter 0 1',data_dir_prefix);
% clear('X')
XW = -WhiteningFilter(X,20);
trgplot(1,2,ras,XW,Tstv);
nGrangerT(X,20)
s
Tstv = 1;
corlen = 20; %ms
reglen = ceil(corlen/Tstv);
Tlen = simu_time;

ST = SpikeTrainsT(ras, neu_num, Tlen, Tstv);

STW = WhiteningFilter(ST,reglen);
[~,STJR] = GC_regression(ST,reglen);
trgplot(1,3,ras,STW,Tstv);
trgplot(2,3,ras,STJR,Tstv);

% [~,XJR]= GC_regression(X(1:2,:),ceil(corlen/stv));
% XW = WhiteningFilter(X,ceil(corlen/stv));
% trgplot(2,1,ras,XW,1);
% trgplot(1,2,ras,XW,1);
ST3 = ST;
ST3(2,:) =[0 ST(2,1:end-1)];
ST3(3,:) =[0 0 ST(3,1:end-2)];


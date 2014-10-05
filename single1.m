addpath ..
% mt=[ 0 0 0
%      1 0 0
%      0 1 0];
mt=[0 0;1 0];
save('-ascii', 'cormat_tmp.txt', 'mt'); 
ps=0.012;
% system(['..\\raster_tuning_ms.exe -ng -v -scii 0.02 -t 1e7 --bin-save -n 0 ',num2str(size(mt,1)),' -psi 0.012 -pr ',num2str(pr),' -mat cormat_tmp.txt']);
% system(['..\\raster_tuning.exe -ng -v -scee 0.02 -t 1e7 --bin-save -n ',num2str(size(mt,1)),' -pr 1 -ps ',num2str(ps),' -mat cormat_tmp.txt']);
system(['..\\raster_tuning_ms.exe --pr-mul 0.1@2 -ng -v -scee 0.01 -t 5e6 --bin-save -n ',num2str(size(mt,1)),' -pr 1 -ps ',num2str(ps),' -mat cormat_tmp.txt']);
clear X
num_neu_ex = length(mt);
p=num_neu_ex;
fid = fopen('data/staffsave.txt', 'r');
X = fread(fid, [num_neu_ex, inf], 'double');
fclose(fid);
% [CA,de,Aall]=pos_nGrangerT2(X,20)
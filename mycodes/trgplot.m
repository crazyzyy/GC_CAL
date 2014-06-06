function [st_ave,t_rel] = trgplot(neu1, neu2, ras, Series, Tstv)
TrgItv = [-35 35]; %ms
[st_ave, t_rel] = spikeTriggerAve(neu1, neu2, ras, Series, ceil(TrgItv./Tstv), Tstv);

figure
set(gca,'fontsize',20)
plot(t_rel,st_ave,'linewidth',1.5)
xlabel('time to spike (ms)')
ylabel('spike trigger average')
title([num2str(neu1),' trigger ',num2str(neu2)])
%this is a model of figure
figure
set(gca,'fontsize',20)
plot(x,y,'linewidth',1.5)
ax = axis;
ax(1:2) = ;
axis(ax)
xlabel('')
ylabel('')
title([''])
print('-dpsc2',['pics\tmp\name.eps'])

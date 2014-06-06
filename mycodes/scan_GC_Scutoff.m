
cutf = 0.05:0.05:1;
GC = zeros(2,2,length(cutf));
uGC = GC;
rGC = GC;
for i=1:length(cutf)
    od = ceil(30*cutf(i));
%         od = 20;
[S2,freq2]=FreqCut_zyy(S,freq,cutf(i));
[uS2,ufreq2]=FreqCut_zyy(uS,ufreq,cutf(i));
[rS2,rfreq2]=FreqCut_zyy(rS,rfreq,cutf(i));

GC(:,:,i) = getGCSapp_scaled(S2,freq2,od);
uGC(:,:,i) = getGCSapp_scaled(uS2,ufreq2,od);
rGC(:,:,i) = getGCSapp_scaled(rS2,rfreq2,od);
end
rGC = permute(rGC,[3 1 2]);
uGC = permute(uGC,[3 1 2]);
GC = permute(GC,[3 1 2]);
figure
set(gca,'fontsize',20)
plot(cutf,GC(:,1,2),'-r',cutf,GC(:,2,1),'--r', ...
    cutf,uGC(:,1,2),'-b',cutf,uGC(:,2,1),'--b', ...
     cutf,rGC(:,1,2),'-c',cutf,rGC(:,2,1),'--c','linewidth',2)

xlabel('cut off frequency f (kHz)')
ylabel('GC')
 print('-dpsc2',['pics\scaled_GCvscutoff_rS10.eps'])
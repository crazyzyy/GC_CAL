%spike trigger for binary spike train time series
function [TG1_2,TG2_1] = STtrigger(X,itv,st,ed)
[p,l] = size(X);
ST1 = X(1,:); ST2 = X(2,:);
M1 = mean(ST1); M2 = mean(ST2);
id1 = find(ST1==1); id2 = find(ST2==1); 
Nst = floor(st/itv); Ned = ceil(ed/itv);
id1 = id1.*((id1+Nst)>0).*((id1+Ned)<l);
id1(id1==0) = [];
id2 = id2.*((id2+Nst)>0).*((id2+Ned)<l);
id2(id2==0) = [];
xl = (Nst:Ned)*itv;
TG1_2 = zeros(1,length(xl)); TG2_1 = TG1_2;
TG1_1 = TG2_1;TG2_2 = TG1_1;
for i= 0:(Ned-Nst)
    TG1_2(i+1) = mean(ST2(id1+Nst+i))-M2;
    TG2_1(i+1) = mean(ST1(id2+Nst+i))-M1;
    if xl(i+1) ~= 0
    TG1_1(i+1) = mean(ST1(id1+Nst+i))-M1;
    TG2_2(i+1) = mean(ST2(id2+Nst+i))-M2;
    end
end
figure
plot(xl,TG1_2,xl,TG2_1,xl,TG1_1,'--b',xl,TG2_2,'--g');
legend('TG1-ST2','TG2-ST1','TG1-ST1','TG2-ST2')
xlabel('\DeltaT ms')
end
%fit S: len*p*p
function [rS2] = epfitSn(rS,rfreq)
rS = Makeup4SpectrumFact(rS);
p = size(rS,2);
rS2 = zeros(size(rS));

for i = 1:p
    for j = 1:p
        if i == j
            rS2(:,i,j) = FitSa(rS(:,i,j),rfreq);
        else
            rS2(:,i,j) = FitSc(rS(:,i,j),rfreq);
        end
    end
end


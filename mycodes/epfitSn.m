%fit S: len*p*p
function [rS2] = epfitSn(rS,rfreq,cutod)
rS = Makeup4SpectrumFact(rS);
p = size(rS,2);
rS2 = zeros(size(rS));

if ~exist('cutod','var')
for i = 1:p
    for j = 1:p
        if i == j
            rS2(:,i,j) = FitSa(rS(:,i,j),rfreq);
        else
            rS2(:,i,j) = FitSc(rS(:,i,j),rfreq);
        end
    end
end

else
    for i = 1:p
        for j = 1:p
            if i == j
                rS2(:,i,j) = FitSa(rS(:,i,j),rfreq,cutod);
            else
                rS2(:,i,j) = FitSc(rS(:,i,j),rfreq,cutod);
            end
        end
    end
end


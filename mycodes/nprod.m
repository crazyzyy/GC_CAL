%compute the multci matrix product of 2~3 len*p*p 
function M = nprod(A,B,C)
M = zeros(size(A));
len = size(A,1);
if ~exist('C','var')
    for i = 1:len
        M(i,:,:) = squeeze(A(i,:,:))*squeeze(B(i,:,:));
    end
else
    for i = 1:len
        M(i,:,:) = squeeze(A(i,:,:))*squeeze(B(i,:,:))*squeeze(C(i,:,:));
    end
end
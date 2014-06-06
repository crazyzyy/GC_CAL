%compute det(X) by its first dimension. X:len*p*p
function M = ndet(X)
len = size(X,1);
M = zeros(len,1);
for i = 1:len
    M(i,1) = det(squeeze(X(i,:,:)));
end
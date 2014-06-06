%len*p*p len-dimention multi matrix inverse
function Sinv = mdminv(S)
len = size(S,1);
S2 = permute(S,[2 3 1]);

Sinv = zeros(size(S2));
for i = 1:len
    Sinv(:,:,i) = inv(S2(:,:,i));
end
Sinv = ipermute(Sinv,[2 3 1]);
    

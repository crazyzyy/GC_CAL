%permuteS permute the neuron index and generate corresponding spectrum
%len*po*po to len*p*p   po = size(S,1)
function pS = permuteS(S,id)
len = size(S,1);
p = length(id);
pS = zeros(len,p,p);
for i = 1:p
    for j = 1:p
        pS(:,i,j) = S(:,id(i),id(j));
    end
end
        
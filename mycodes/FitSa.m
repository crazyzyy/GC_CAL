% fit auto spectrum
function S2 =  FitSa(S,freq)
S2 = S;
len = length(freq);
Sh = S(1:floor(end/2)+1,:,:);

st = hhiS(Sh(:,1,1));
index = st:floor(len/2)+1;

ft11 = createFit02(freq(index),squeeze(Sh(index,1,1)).');
S2(index,1,1) = ft11(freq(index));

S2(len-index+2,1,1) = S2(index,1,1);
% fit cross spectrum
function S2 =  FitSc(S,freq,cutod)
if ~exist('cutod','var')
    S2 = S;
else
    S2 = smoothSc(S,cutod);
end
len = length(freq);
Sh = S(1:floor(end/2)+1,:,:);

st = hhiS(abs(Sh(:,1,1)));
index = st:floor(len/2)+1;


ft_r = createFit3s(freq(index),squeeze(real(Sh(index,1,1))).');
ft_i = createFit3s(freq(index),squeeze(imag(Sh(index,1,1))).');

S2(index,1,1) = ft_r(freq(index))+1i*ft_i(freq(index));
S2(len-index+2,1,1) = conj(S2(index,1,1));
if ceil(len/2) == len/2
S2(len/2+1,1,1) = real(S2(len/2+1,1,1));
end
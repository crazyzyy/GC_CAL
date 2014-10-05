% fit cross spectrum
function S2 =  FitSc_abs(S,freq,cutod)
if ~exist('cutod','var')
    S2 = S;
else
    S2 = smoothSc(S,cutod);
end
len = length(freq);
Sh = S(1:floor(end/2)+1,:,:);

st = hhiS(abs(Sh(:,1,1)));
index = st:floor(len/2)+1;


ft_r = createFit3s(freq(index),squeeze(abs(Sh(index,1,1))).');
ft_a = squeeze(angle(Sh(index,1,1))).';

S2(index,1,1) = ft_r(freq(index)).*exp(1i*ft_a');
S2(len-index+2,1,1) = conj(S2(index,1,1));
if ceil(len/2) == len/2
S2(len/2+1,1,1) = real(S2(len/2+1,1,1));
end
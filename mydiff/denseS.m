%increase the resolution of spectral density matrix S (len*p*p) while keeps
%the information
%only when len is even
function [Sd, freqd] = denseS(S,freq,len)
l = size(S,1);
cov = ifft(S);
cov1 = zeros([len size(S,2) size(S,3)]);
cov1(1:l/2,:,:) = cov(1:l/2,:,:);
cov1(end-l/2+2:end,:,:) = cov(end-l/2+2:end,:,:);

cov1(l/2+1,:,:) = cov(l/2+1,:,:)/2;
cov1(end-l/2+1) = cov(l/2+1,:,:)/2;

Sd = fft(cov1);

df = freq(2)-freq(1);
df2 = df*l/len;
freqd = freq(1)+(0:len-1)*df2;
Sd = Makeup4SpectrumFact(Sd);
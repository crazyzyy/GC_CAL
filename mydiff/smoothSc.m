%increase the resolution of spectral density matrix S (len*p*p) while keeps
%the information
%only when len is even
function [Sd] = smoothSc(S,od)

cov = ifft(S);
cov1 = cov;
cov1(od+1:end-od,:,:) = 0;
Sd = fft(cov1);

if length(size(Sd)) ==3
 Sd = Makeup4SpectrumFact(Sd);
end
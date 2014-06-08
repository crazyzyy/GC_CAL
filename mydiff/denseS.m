%increase the resolution of spectral density matrix S (len*p*p) while keeps
%the information
function Sd = denseS(S,len)
cov = ifft(S);
Sd = fft(cov,len);
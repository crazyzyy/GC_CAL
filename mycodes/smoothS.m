%truncation in covariance to smooth the spectrum
%S should be len*p*p
function [S2] = smoothS(S,ratio) 
if ~exist('ratio','var')
    ratio = 0.99;
end
cov = real(fft(S));
s = sum(cov(:).^2);
s0 = ratio*s;
i = 0;
ss = 0;
while ss<s0
    i = i+1;
    c1 = cov(1:i,:,:);
    c2 = cov(end-i+1:end,:,:);
    ss = sum(c1(:).^2)+sum(c2(:).^2);
end
i
cov(i+1:end-i,:,:) = 0;
S2 = ifft(cov);

end

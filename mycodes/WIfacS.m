%Wilson's iteration method for the factorization of spectral density matrix
%S : len*p*p
function [Sigma,H] = WIfacS(S,iter)

len = size(S,1);
p = size(S,2);
E = zeros(size(S));
for i = 1:p
    E(:,i,i) = ones(len,1,1);
end
H = E;

for i = 1:iter
 D = ninvUprod(H,S);
%  max(reshape(std(nUprod(H,E)-S,1),1,[]))
 D = D+E;
 
 %get positive frequency part of D
 iD = ifft(D);
 iD(floor(len/2)+2:end,:,:) = 0;
%  iD(ceil(len/10):end,:,:) = 0;
iD(ceil(len/2)+1,:,:) = iD(ceil(len/2)+1,:,:)./2;
 iD(1,:,:) = iD(1,:,:)./2;
 pD = fft(iD);
 
 %compensate pD by SS following the restriction of factorization
 mpD = squeeze(mean(pD,1));
 L = tril(mpD,-1); DD = diag(diag(mpD)); 
 SS1 =  -imag(DD)*1i-L+L';
 SS = zeros(size(S));
 for j = 1:len
     SS(j,:,:) = SS1;
 end
 
 H = nprod(H,pD+SS);
%  squeeze(real(mean(pD+SS,1)))
end
Sigma = real(squeeze(mean(H,1)))*real(squeeze(mean(H,1)))';  
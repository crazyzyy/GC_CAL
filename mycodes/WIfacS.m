%Wilson's iteration method for the factorization of spectral density matrix
%S : len*p*p
function [Sigma,H,rHv] = WIfacS(S,iter,cutod)
if ~exist('cutod','var')
    cutod = [];
end

len = size(S,1);
p = size(S,2);
E = zeros(size(S));
for i = 1:p
    E(:,i,i) = ones(len,1,1);
end

%Given initial value
%1
H = E;
%2
[~,~,~,WS,~,H0] = nStdWhiteS(S);
fWS = real(squeeze(mean(WS,1)));
fWS = chol(fWS);
for i = 1:len
    H(i,:,:) = squeeze(H0(i,:,:))*fWS;
end

%iteration
for i = 1:iter
 D = ninvUprod(H,S);
 

 D = D+E;
 
 %get positive frequency part of D
 iD = ifft(D);
 
     if isempty(cutod)
     iD(floor(len/2)+2:end,:,:) = 0;
     iD(ceil(len/2)+1,:,:) = iD(ceil(len/2)+1,:,:)./2;
     else
     iD(cutod+1:end,:,:) = 0;
     end
 
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
 
 H0 = H;
 H = nprod(H,pD+SS);
%  squeeze(real(mean(pD+SS,1)))

%  iH = ifft(H);
%  iH(floor(len/2)+2:end,:,:) = 0;
%  H = fft(iH);
 
end

% max(reshape(std(nUprod(H,E)-S,1),1,[]))
 
HSigma = real(squeeze(mean(H,1)));
Sigma = HSigma*HSigma';
nlz = diag(abs(diag(Sigma)).^-0.5);
rHv = zeros(size(S));
for i = 1:len
    rHv(i,:,:) = nlz*HSigma*squeeze(H(i,:,:))^-1;
end



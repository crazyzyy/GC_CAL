% Whiten the auto spectrum of each variable

function [WS,Hv,H] = nStdWhiteS(S)
if size(S,2)~=size(S,3)
  error('S shoule be fftlen*p*p matrix');
end

p   = size(S,2);
len = size(S,1);
X = zeros(len, p);
for k=1:p
%   X(:,k) = S2X1D(real(S(:,k,k)));
%MAJOR REVISION!!!
    X(:,k) = conj(S2X1D(real(S(:,k,k))));
end

WS = zeros(size(S));
for k1=1:p
  % later, we may ignore WS(:, k, k) part
  for k2=1:p
    WS(:, k1, k2) = (1./X(:,k1)) .* S(:, k1, k2) .* conj(1./X(:,k2));
  end
end

Hv1 = zeros(size(S));
H1 = Hv1;
for i = 1:p
    Hv1(:,i,i) = 1./X(:,i);
    H1(:,i,i) = X(:,i);
end

Hv = Hv1;
H = H1;

% ensure absolute real number
for k=1:p
  WS(:, k, k) = real(WS(:, k, k));
end

if p>=2
H2 = WS2H(WS);
Hv2 = mdminv(H2);
 
WS = nUprod(Hv2,WS);

Hv = nprod(Hv2,Hv);
H = nprod(H,H2);
end




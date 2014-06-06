% Calculate spectrum from multi-trial non-uniformly sampled data mX
% Input:
%   mX is  p * len * n_trials  array, the sampled data
%   mT is  len * n_trials  array, the sampling time, in range [0,1]
% Output:
%   aveS is fftlen*p*p matrix
%   correcponding frequencies: fqs = 0, 1,..., M/2-1, -M/2, -M/2+1,...,-1
% Currently no window function applied
% CAUTION: does not subtract mean value from original data
% TT total time of one trial (ms)

function [aveS, fqs, S] = mX2S_nuft2(mX, mT, fftlen,TT)
mX = permute(mX,[2 1 3]);        % convert to len * p * n_trials
[len, p, n_trials] = size(mX);
if exist('fftlen','var') == 0
    fftlen = len;
end
fqs = ifftshift((0:fftlen-1)-floor(fftlen/2));

aveS = zeros(fftlen,p,p);
S    = zeros(fftlen,p,p,n_trials);
Jk   = zeros(fftlen, p);
% average over trials
for i_trial=1:n_trials
  % windowed Fourier transform
  for channel=1:p
    Jk(:,channel) = nufftw(mX(:,channel,i_trial),...
                           2*pi*mT(:,i_trial), fftlen/2);
  end
  % get cross spectrum of one trial
  % due to symmetric of real data fft, this could be faster
  for chan1=1:p
    for chan2=1:p
      S(:, chan1, chan2, i_trial) = Jk(:,chan1).*conj(Jk(:,chan2))*TT/ len^2;
    end
  end
  aveS = aveS + squeeze(S(:,:,:,i_trial));
end
% scale data according to input data length, instead of fftlen
aveS = aveS/n_trials;
% S=S*TT / n_trials / len^2;
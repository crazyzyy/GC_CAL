%Input:
%X p*l time series(uniform)
%stv interval
%fcut cut-off frequency for output(kHz)
%Output
%S spectral density matrix (S = TI^2 = itv*Spec) 
%freq frequency label for S
function [S,freq] = npSpec(X, stv, ftv, fcut, mode,len,Tol)
if ~exist('mode','var')
    mode='u';
  end
[p,l]= size(X);

if ~exist('len','var')
len = 1000; %ms
end
% if ~exist('res','var')
% res = 1/1000; %/ms
% end
if ~exist('res','var')
res = 1/len; %/ms
end
if res > 1/len
    res = 1/len;
end
if ~exist('Tol','var')
Tol = round(l*stv/len); 
end

mlen=round(len/stv);
slen=round((len/ftv));
[mX, mT] = SampleNonUnif(X, mlen, slen,mode,Tol);%%%

% res = 1/len;
fftlen = ceil(fcut/res);

% mT = mT/mlen;
mT = mT/round(1/stv/res);

TT = len;
if mode == 'u'
    aveS = mX2S_nuft(mX, mT, fftlen*2,TT);
elseif mode == 'r'
    aveS = mX2S_nuft_unbiased(mX, mT, fftlen*2,TT);
end

S = Makeup4SpectrumFact(aveS);
freq = (0:fftlen*2-1)*res;
end

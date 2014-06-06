%Input:
%X p*l time series(uniform)
%stv interval
%fcut cut-off frequency for output(kHz)
%Output
%S spectral density matrix (S = TI^2 = itv*Spec) 
%freq frequency label for S
function [S,freq,Sall] = npSpec2(X, stv, ftv, fcut, mode,len,res)
if ~exist('mode','var')
    mode='u';
  end
[p,l]= size(X);

if ~exist('len','var')
len = 100; %ms
end
if ~exist('res','var')
res = 1/1000; %/ms
end
if res > 1/len
    res = 1/len;
end

mlen=round(len/stv);
slen=round((len/ftv));
[mX, mT] = SampleNonUnif(X, mlen, slen,mode,round(l/4/slen));%%%
% res = 1/len;
fftlen = ceil(fcut/res);

% mT = mT/mlen;
mT = mT/round(1/stv/res);

TT = len;
if mode == 'u'
%     [aveS, ~, Sall]= mX2S_nuft2(mX, mT, fftlen*2,TT);
    [aveS, ~, Sall]= mX2S_nuft2Jk(mX, mT, fftlen*2,TT);
elseif mode == 'r'
    [aveS, ~, Sall] = mX2S_nuft_unbiased2(mX, mT, fftlen*2,TT);
end
S = Makeup4SpectrumFact(aveS);
freq = (1:fftlen*2)*res;
end

%compute joint residual cov from S len*p*p 
function [cov1,Hv1,H1] = covfacS(SN1,iter,cutod)
if ~exist('iter','var')
    iter = 1;
end
if ~exist('cutod','var')
    cutod = [];
end

[WS1,Hv1,H1] = nStdWhiteSn(SN1,iter,cutod);
h1 = squeeze(real(mean(H1,1)));ws1 = squeeze(real(mean(WS1,1)));
cov1 = h1*ws1*h1';
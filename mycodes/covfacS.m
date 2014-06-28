%compute joint residual cov from S len*p*p 
function [cov1] = covfacS(SN1,iter)
if ~exist('iter','var')
    iter = 1;
end
[WS1,~,H1] = nStdWhiteSn(SN1,iter);
h1 = squeeze(real(mean(H1,1)));ws1 = squeeze(real(mean(WS1,1)));
cov1 = h1*ws1*h1';
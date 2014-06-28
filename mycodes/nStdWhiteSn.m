%multi trials of nStdWhiteS.m
function [WS,Hv,H] = nStdWhiteSn(S,n,cutod)

if ~exist('cutod','var')
    cutod = [];
end
[WS,Hv,H] = nStdWhiteS(S,cutod);
    
for i = 2:n
    [WS,Hv1,H1] = nStdWhiteS(WS,cutod);
    Hv = nprod(Hv1,Hv);
    H = nprod(H,H1);
end
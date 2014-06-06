%multi trials of nStdWhiteS.m
function [WS,Hv,H] = nStdWhiteSn(S,n)

[WS,Hv,H] = nStdWhiteS(S);
    
for i = 2:n
    [WS,Hv1,H1] = nStdWhiteS(WS);
    Hv = nprod(Hv1,Hv);
    H = nprod(H,H1);
end
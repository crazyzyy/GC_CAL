%Linear regression 
%with constant variable
function [b,V] = LinearR(YY,Y)

YY = [ones(size(YY,1),1) YY];

b = (YY\Y);
% b = (YY'*YY)\(YY'*Y);
res = Y-YY*b;
V = var(res);
end
%look for biger half height index for spectrum
function [ind] = hhiS(S)
ind = find(abs(S)> 0.7*max(abs(S)));
ind = max(ind);


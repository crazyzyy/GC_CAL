%comparision
A = [-0.5 0.1;0 -0.5];
% A = [0 0.1; 0 0];
% De = eye(2);
De = [1 0.4; 0.4 1];
len = 1e7;
X = gendata_linear(A,De,len);
od = 10;

S = A2S(A, De, 1000);
S = permute(S,[3 1 2]);
% od = chooseOrderAuto(X);

[GC, De2, A2] = pos_nGrangerT2(X,od);
log(prod(diag(De2))/det(De2))
S2 = A2S(A2, De2, 1000);
S2 = permute(S2,[3 1 2]);



disp(GC)
GCa = getGCSapp(S,od)
[GCa2,covxy2] = getGCSapp(S2,od);
disp(GCa2)

[srX,sas] = WhiteningFilter(X, od);
% corr(srX');
[GCW, DeW, AW] = pos_nGrangerT2(srX,od);
SW = A2S(AW, DeW, 1000);
SW = permute(SW,[3 1 2]);

[GCaW, covxyW] = getGCSapp(SW,od);
disp(GCaW)
disp(GCW)
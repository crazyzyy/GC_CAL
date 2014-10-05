%extended gc
function [GC] = ExGC(XX1,X1,XX2,X2)

[b1,res_b1]= LinearR(XX1,X1);
[b2,res_b2]= LinearR(XX2,X2);
[c1,res_c1]= LinearR([XX1 XX2],X1);
[c2,res_c2]= LinearR([XX1 XX2],X2);
gc1=log(res_b1/res_c1);
gc2=log(res_b2/res_c2);
GC = [0 gc1;gc2 0];
end
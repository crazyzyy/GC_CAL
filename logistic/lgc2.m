%logistic GC,two variables
function [LGC,GC,b,c,SSf,res]=lgc2(x,p)
rlim1=5;rlim2=100;
% x1=x(1,:);x2=x(2,:);
% [XX1,X1]=x2reg(x1,p);
% [XX2,X2]=x2reg(x2,p);
[XX1,X1,XX2,X2]=x2Xx(x,p);
[b1,SSf_b1,res_b1]=LogisticR(XX1,X1,rlim1,rlim2);
[b2,SSf_b2,res_b2]=LogisticR(XX2,X2,rlim1,rlim2);
[c1,SSf_c1,res_c1]=LogisticR([XX1 XX2],X1,rlim1,rlim2);
[c2,SSf_c2,res_c2]=LogisticR([XX1 XX2],X2,rlim1,rlim2);
lgc1=log(SSf_b1/SSf_c1);
lgc2=log(SSf_b2/SSf_c2);
gc1=log(res_b1/res_c1);
gc2=log(res_b2/res_c2);
LGC=[lgc1,lgc2]*1000;
GC=[gc1,gc2]*1000;
b=[b1; b2];
c=[c1; c2];
SSf=[SSf_b1,SSf_c1,SSf_b2,SSf_c2];
res=[res_b1,res_c1,res_b2,res_c2];
end
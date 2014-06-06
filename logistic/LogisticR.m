%logistic regression
%Gradient Descent
function [a,SSf,res,yf]=LogisticR(X,Y,iterlim,iterlim2)
if ~exist('iterlim','var')
    iterlim=5;
end
if ~exist('iterlim2','var')
    iterlim=100;
end
L=length(Y);
p=size(X,2)+1;
PI=@(x) 1./(1+exp(-x));
mS=@(x,y,n) 1/n*(x*log(1+exp(-y))'+(1-x)*log(1+exp(y))');
mdS=@(X,x,y,n) 1/n*(PI(y)-x)*X;
mddS=@(X,y,n,p) 1/n*(ones(p,1)*((1-PI(y)).*PI(y)).*X'*X);

a=zeros(1,p);
X_1=[ones(L,1) X];
% iterlim=1000;iterlim2=0;
pace=50;
y=a*X_1';
% re=mS(Y',y,L);
sv=mdS(X_1,Y',y,L);
for i=1:iterlim
    pace1=pace;
a1=a-pace1*sv;
y1=a1*X_1';
% re1=mS(Y',y1,L);
sv1=mdS(X_1,Y',y1,L);
% a2=a;y2=y;sv2=sv;
pace2=0;
if sv1*sv'<0
for ii=1:8
    paceh=0.5*(pace1+pace2);
    ah=a-paceh*sv;
    yh=ah*X_1';
    svh=mdS(X_1,Y',yh,L);
    if svh*sv'<0
        pace1=paceh;
%         a1=ah;y1=yh;sv1=svh;
    else
        pace2=paceh;
%         a2=ah;y2=yh;sv2=svh;
    end
end
% a2=a-2*pace*sv;
% y2=a2*X_1';
% re2=mS(Y',y2,L);
%     if re1<re2
    a=ah;
%     y=yh;
%     re=reh;
    sv=svh;
%     else
%         2
%     a=a2;
%     y=y2;
%     re=re2;
%     sv=mdS(X_1,Y',y,L);
%     pace=pace*2;
%     end
        
else
    pace=pace*2;
end
end

err=zeros(1,iterlim2);
det1=err;
 SS=err;
tic
j=0;
while j<=iterlim2
    j=j+1;
    y=a*X_1';
    SS(j)=mS(Y',y,L);
    sv=mdS(X_1,Y',y,L);
    A=mddS(X_1,y,L,p);
    rev=sv/A;
    a=a-1*rev;
    det1(j)=det(A);
%     err(j)=abs(rev(1));
% err(j)=norm(a(2));
if (j>=2)&&(abs(SS(j)-SS(j-1))<5e-16)
        SSf=SS(j);
        yf=PI(y);
        res=var(Y'-yf);
    j=iterlim2+1;
end
end
toc
% a'
%  plot(log10(abs(SS(1:end-1)-SS(2:end))));


end

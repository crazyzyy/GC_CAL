%nD inference
%I&F structure based inference mathod (V-ST)

function [ISM] = MYinferNDnet(X,NET)
%preliminary
[p,L] = size(X);
a = 0.01;
dx = 0.000001;
xx = -1:dx:2;
xx(xx>1.0) = 0 ; 
x0 = -1:dx:1;
gs = 1/sqrt(2*pi)/a*exp(-x0.^2/(2*a^2));
cv = ifft(fft([xx zeros(size(gs))]).*fft([gs zeros(size(xx))]));
idx = 1/dx:4/dx+1;
cs0 =  cv(idx)*dx;
%  figure;plot(cs0)

gs1 = -1/sqrt(2*pi)/(a^3)*exp(-x0.^2/(2*a^2)).*x0;
cv1 = ifft(fft([xx zeros(size(gs1))]).*fft([gs1 zeros(size(xx))]));
cs1 = cv1(idx)*dx;
% figure;plot(cs1)

H0 = @(Inp) Inp.*(Inp<=1);
H = @(Inp) cs0(floor((Inp+1)./dx+1));
H1 = @(Inp1) cs1(floor((Inp1+1)./dx+1));
%
ST0 = X(:,2:end) - X(:,1:end-1);
ST = ST0<-0.8;
% ST = [ST zeros(p,1)];
ST = [zeros(p,1) ST];

ISM = zeros(p,p);

for ii = 1:p
    ii
    x = X(ii,:);
    for jj = 1:p
        
%         if ii~=jj
         if NET(ii,jj) ~= 0
             
        st = ST(jj,:);
dxt_1 = x(2:end-1)-x(1:end-2);
ind = x(2:end-1)==0;
dxt_1(ind) = 0; 
st_1 = st(2:end-1);
xt = x(3:end);
xt_1 = x(2:end-1);

% st_1(ind) = 0;
% st_1((ind(2:end))-1) = (rand(size(ind(2:end)))<(sum(st)/length(st)));

I = @(para) sum((xt - H(xt_1+para(1)*dxt_1+para(2)*st_1+para(3))).^2)/length(xt);
dI = @(para) -[dxt_1;10*st_1;ones(size(dxt_1))]*(2*(xt - H(xt_1+para(1)*dxt_1+para(2)*st_1+para(3))).*H1(xt_1+para(1)*dxt_1+para(2)*st_1+para(3)))'/length(xt);

para = [0.5;0;0];

iterlim = 50;
for i = 1:iterlim
    I0 = I(para);
    pace = 1e-7;
    dd = dI(para);
    if i<=33
    if i == floor(i/3)*3
        dd = [dd(1);0;0];
    else if i == floor(i/3)*3+1
        dd = [0;dd(2);0];
        else
            dd = [0;0;dd(3)];
        end
    end
    end

    I1 = I(para-pace*dd);
    
    while I1<=I0*(1+1e-7)
        I0 = I1;
        pace = pace*2;
%         if (para(2)-pace*dd(2))<0||(para(3)-pace*dd(3))<0
%             I1 = I0+1;
%         else
        I1 = I(para-pace*dd);
%         end
    end

   para = para-pace*dd/2;
end

ISM(ii,jj) = para(2);
para(2)
        end       
    end
end



end









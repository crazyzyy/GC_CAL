%myinfer2
%I&F structure based inference mathod (V-ST)
%preliminary
a = 0.01;
dx = 0.000001;
xx = -1:dx:2;
xx(xx>1.0) = 0 ; 
x0 = -1:dx:1;
gs = 1/sqrt(2*pi)/a*exp(-x0.^2/(2*a^2));
cv = ifft(fft([xx zeros(size(gs))]).*fft([gs zeros(size(xx))]));
idx = 2/dx:4/dx+1;
cs0 =  cv(idx)*dx;
%  figure;plot(cs0)

gs1 = -1/sqrt(2*pi)/(a^3)*exp(-x0.^2/(2*a^2)).*x0;
cv1 = ifft(fft([xx zeros(size(gs1))]).*fft([gs1 zeros(size(xx))]));
cs1 = cv1(idx)*dx;
% figure;plot(cs1)

H0 = @(Inp) Inp.*(Inp<=1);
H = @(Inp) cs0(floor(Inp./dx+1));
H1 = @(Inp1) cs1(floor(Inp1./dx+1));
%
ST0 = X(:,2:end) - X(:,1:end-1);
ST = ST0<-0.8;
ST = [ST zeros(2,1)];
x = X(2,:);
st = ST(1,:);
dxt_1 = x(2:end-1)-x(1:end-2);
ind = find(x(2:end-1)==0);
dxt_1(ind) = 0; 
st_1 = st(2:end-1);
xt = x(3:end);
xt_1 = x(2:end-1);

I = @(para) sum((xt - H(xt_1+para(1)*dxt_1+para(2)*st_1)).^2)/length(xt);
Io = @(para) sum((xt - H0(xt_1+para(1)*dxt_1+para(2)*st_1)).^2)/length(xt);
dI = @(para) -[dxt_1;st_1]*(2*(xt - H(xt_1+para(1)*dxt_1+para(2)*st_1)).*H1(xt_1+para(1)*dxt_1+para(2)*st_1))'/length(xt);

para = [0.5;0];

iterlim = 50;
for i = 1:iterlim
    I0 = I(para);
    pace = 1e-7;
    dd = dI(para);
    if i/2 == floor(i/2)
        dd = [dd(1);0];
    else
        dd = [0;dd(2)];
    end

    I1 = I(para-pace*dd);
    
    while I1<=I0*(1+1e-7)
        I0 = I1;
        pace = pace*2;
        if (para(2)-pace*dd(2))<0
            I1 = I0+1;
        else
        I1 = I(para-pace*dd);
        end
    end

    para = para-pace*dd/2
end

para


% xa1 = 0.8:1e-2:0.9;ya1 = 0:5e-4:0.02;
% [XX,YY] = meshgrid(xa1,ya1);
% ZZ = zeros(size(XX));
% for i = 1:length(xa1)
%     i
% for j = 1:length(ya1)
%     ZZ(j,i) = I([xa1(i);ya1(j)]);
% end
% end
% figure;mesh(XX,YY,ZZ) 
% figure;contour(XX,YY,ZZ,100) 


















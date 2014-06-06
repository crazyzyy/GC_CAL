% illustration of unbiased approach computing mean(x)^2
mu = 0;sigma = 1;
N = 6;
M = 100000;
p1 = zeros(1,M);
p2 = p1;
p3 = p2;
p0 = p1;
for i = 1:M

 x1 = mu+sigma*randn(1,N);
 xx = x1'*x1;
 p0(i) = mean(x1);
 p1(i) = mean(x1)^2;
 p2(i) = mean(x1(1:end/2))*mean(x1(end/2+1:end));
 p3(i) = N/(N-1)*(mean(xx(:))-1/N*mean(x1.*x1));
end
var(p1)
var(p2)
var(p3)
figure
histfit(p1)
figure
histfit(p1)
figure
histfit(p3)
figure
histfit(p0)
%  histfit(x1.*x2,500)
%  hold on
%  xx = x1'*x2;histfit(xx(:),500)
%  xx = x1'*x2;
% figure
% histfit(xx(:),500)
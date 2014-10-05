function [var2,nb] = NBayesAV(XX1,X1)

m = max(X1)-min(X1)+1;
nb = NaiveBayes.fit(XX1,X1,'Distribution','mvmn');
[post] = posterior(nb,XX1);

% size(post)
% size(unique(X1))
E = post*unique(X1);
% E2 = post*exp(1i*2*pi/m*(0:m-1)');
% aE2 = angle(E2);

% diff = X1 - label;


% diff = angle(exp(1i*(angle(exp(1i*2*pi/m*X1))-aE2)));
diff = X1 - E;





% diffa = angle(exp(1i*2*pi/m*diff));
% figure;hist(diffa,linspace(-pi,pi,51))
% var1 = var(diffa);

var2 = var(diff);

% figure;hist(diff,linspace(-pi,pi,51))
figure;hist(diff,[-m-0.5:0.2:m+0.5])
title(['var = ',num2str(var2)])
% figure;plot(label(100:120))


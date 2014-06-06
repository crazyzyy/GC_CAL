function [la,lambda,Amp] = fit_ncx2_ld(x)
ave = mean(x);
sd = std(x);
t = (ave./sd).^2-1;
lambda = sqrt(4*t+4*t.^2)+2*t;
Amp = ave./(2+lambda);
la = lambda.*Amp;
end
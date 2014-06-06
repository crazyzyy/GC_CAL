%newton temp
n=100;
PI=@(x) 1./(1+exp(-x));
x=1;
err=zeros(1,n);
for i=1:n
    rev=(PI(x)-0.5)/(1-PI(x))/(PI(x));

    x=x-rev;
        err(i)=norm(rev);
end
plot(1:100,log10(err))
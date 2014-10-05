%logistic map
x0 = rand;
r = 4;
L = 1e6;
x = zeros(1,L);
x(1) = x0;
for i = 2:L
    x(i) = r*x(i-1)*(1-x(i-1));
end

figure;hist(x,100)
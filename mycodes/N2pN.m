%change multivariate time series xt,yt,... to xt, xt-1,xt-p, yt, yt-1, yt-p...

function X2 = N2pN(X,p)
[N,L] = size(X);
X2 = zeros(N*p,L-p+1);
for i = 0:N-1
    for j = 0:p-1
        X2(i*p+j+1,:) = X(i+1,p-j:end-j);
    end
end

    
    
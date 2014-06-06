% %compute the multci matrix product of  len*p*p array A*B*A'
function M = nUprod(A,B)
M = zeros(size(A));
len = size(A,1);
   for i = 1:len
        M(i,:,:) = squeeze(A(i,:,:))*squeeze(B(i,:,:))*squeeze(A(i,:,:))';
    end
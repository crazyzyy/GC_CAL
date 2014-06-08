% %compute the multci matrix product of  len*p*p array A^-1*B*A'^-1
function M = ninvUprod(A,B)
M = zeros(size(A));
len = size(A,1);
   for i = 1:len
       tM = squeeze(A(i,:,:))\chol(squeeze(B(i,:,:)),'lower');
       M(i,:,:) = tM*tM';
%         M(i,:,:) = squeeze(A(i,:,:))*squeeze(B(i,:,:))*squeeze(A(i,:,:))';
    end
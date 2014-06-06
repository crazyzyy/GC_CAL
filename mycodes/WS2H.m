% transform WS to H when Sxy is small 
%WS ~len*p*p
function [H] = WS2H(WS)
 len = size(WS,1);
 p  = size(WS,2);
 H = zeros(size(WS));
 for i = 1:p
     for j = 1:p
         if i == j;
             H(:,i,j) = ones(len,1,1);
         else
             H(:,i,j) = chilbert_rev(WS(:,i,j));
%              H(:,i,j) = chilbert_cut(WS(:,i,j));
         end
     end
 end

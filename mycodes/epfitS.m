%empirically fit S by rational polynomials.
function [rS2] = epfitS(rS,rfreq)
ff = max(rfreq);
res = rfreq(2) - rfreq(1);
rS2 = rS;
len = length(rfreq);
rSh = rS(1:end/2+1,:,:);

st11 = hhiS(rSh(:,1,1));
st22 = hhiS(rSh(:,2,2));
index11 = st11:len/2+1;
index22 = st22:len/2+1;

st12 = hhiS(abs(rSh(:,1,2)));
index12 = st12:len/2+1;
ft11 = createFit02(rfreq(index11),squeeze(rSh(index11,1,1)).');
rS2(index11,1,1) = ft11(rfreq(index11));
% rS2(len-index11+2,1,1) = ft11(ff - rfreq(len-index11+2));
rS2(len-index11+2,1,1) = rS2(index11,1,1);

ft22 = createFit02(rfreq(index22),squeeze(rSh(index22,2,2)).');
rS2(index22,2,2) = ft22(rfreq(index22));
% rS2(len-index22+2,1,1) = ft22(ff - rfreq(len-index22+2));
rS2(len-index22+2,2,2) = rS2(index22,2,2);

ft12r = createFit3s(rfreq(index12),squeeze(real(rSh(index12,1,2))).');
ft12i = createFit3s(rfreq(index12),squeeze(imag(rSh(index12,1,2))).');
rS2(index12,1,2) = ft12r(rfreq(index12))+1i*ft12i(rfreq(index12));
% rS2(len-index12+2,1,2) = ft12r(ff - rfreq(len-index12+2))-1i*ft12i(ff - rfreq(len-index12+2));
rS2(len-index12+2,1,2) = conj(rS2(index12,1,2));
rS2(len/2+1,1,2) = real(rS2(len/2+1,1,2));
rS2(:,2,1) = conj(rS2(:,1,2));


%  figure
%  subplot(2,2,1)
%  plot(rfreq,rS2(:,1,1),rfreq,rS(:,1,1))
%  subplot(2,2,2)
%  plot(rfreq,real(rS2(:,1,2)),rfreq,real(rS(:,1,2)))
%  subplot(2,2,3)
%  plot(rfreq,rS2(:,2,2),rfreq,rS(:,2,2))
%  subplot(2,2,4)
%  plot(rfreq,imag(rS2(:,1,2)),rfreq,imag(rS(:,1,2)))
% 
%  
%     SW = StdWhiteS(rS);
%    SW2 = StdWhiteS(rS2);
%   figure;plot(rfreq,abs(SW(:,1,2)),rfreq,abs(SW2(:,1,2)))
%   figure;plot(rfreq,angle(SW(:,1,2)),rfreq,angle(SW2(:,1,2)))
%   
%  getGCSapp_scaled(rS2,rfreq, 23)

%  figure
%  subplot(2,2,1)
%  plot(rfreq,rS2(:,1,1),rfreq,rS(:,1,1),ufreq,uS(:,1,1))
%  subplot(2,2,2)
%  plot(rfreq,real(rS2(:,1,2)),rfreq,real(rS(:,1,2)),ufreq,real(uS(:,1,2)))
%  subplot(2,2,3)
%  plot(rfreq,rS2(:,2,2),rfreq,rS(:,2,2),ufreq,uS(:,2,2))
%  subplot(2,2,4)
%  plot(rfreq,imag(rS2(:,1,2)),rfreq,imag(rS(:,1,2)),ufreq,imag(uS(:,1,2)))
% % 
% %  
%     SW = StdWhiteS(rS);
%    SW2 = StdWhiteS(rS2);
%    uSW = StdWhiteS(uS2);
%   figure;plot(rfreq,abs(SW(:,1,2)),rfreq,abs(SW2(:,1,2)),ufreq,abs(uSW(:,1,2)))
%   figure;plot(rfreq,angle(SW(:,1,2)),rfreq,angle(SW2(:,1,2)),ufreq,angle(uSW(:,1,2)))
  
  
  
  
  
  
  
  
  
  
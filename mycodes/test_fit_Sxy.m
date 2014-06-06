%fit Sxy
st = hhiS(real(rS(1:end/2,1,2)));
index = st:1000;
index2 = 2000 - index +1;
xx = freq(index);
yy = squeeze(rS(index,1,2)).';
yyr = real(yy);
wight = sqrt(rS(index,1,1).*rS(index,2,2));
yyi = imag(yy);
fr = createFit25(xx, yyr);
fi = createFit25(xx,yyi);
St = rS;
St(index,1,2) = fr(xx)+1i*fi(xx);
St(index2,1,2) = fr((2000-index2)/1000)-1i*fi((2000-index2)/1000);
St(:,2,1) = conj(St(:,1,2));

  figure;plot(ufreq,real(uS(:,1,2)),rfreq,real(rS(:,1,2)),freq,real(S(:,1,2)),freq,real(St(:,1,2)),'-k')
  figure;plot(ufreq,imag(uS(:,1,2)),rfreq,imag(rS(:,1,2)),freq,imag(S(:,1,2)),freq,imag(St(:,1,2)),'-k')
  
 getGCSapp_scaled(St,freq, od)

  SW = StdWhiteS(St);
  figure;plot(abs(SW(:,1,2)))
  figure;plot(angle(SW(:,1,2)))
  
    SW2 = StdWhiteS(rS2);   SW = StdWhiteS(rS);
  figure;plot(rfreq,abs(SW(:,1,2)),rfreq,abs(SW2(:,1,2)))
  figure;plot(rfreq,angle(SW(:,1,2)),freq,angle(SW2(:,1,2)))

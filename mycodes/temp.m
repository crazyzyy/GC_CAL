%temp
[srd, sas] = WhiteningFilter(XX(1,:), 13);
sdd = var(srd);
[Sxx,Hxx] = A2S(sas,sdd, 1000);
Sxx = squeeze(Sxx);
Hxx = squeeze(Hxx)*std(srd);

[Hxd, de] = S2X1D(Sxx);
figure;plot(1:1000,abs(Hxx),1:1000,abs(Hxd2))
figure;plot(1:1000,angle(Hxx),1:1000,angle(conj(Hxd2)))

So = A2S(Aall,Deps,1000);
[Hxd2, dex2] = S2X1D(squeeze(So(1,1,:)));
[Hyd2, dey2] = S2X1D(squeeze(So(2,2,:)));

[srX, saX] = WhiteningFilter(XX, 13);

[gcW,DeW,AW] = pos_nGrangerT2(srX,13);

SSW = A2S(AW,DeW,1000);
Sxy = squeeze(So(1,2,:));
Sxy2 = Sxy./Hxd2./conj(Hyd2)*sqrt(dex2)*sqrt(dey2);
SxyW = squeeze(SSW(1,2,:));

figure
subplot(1,2,1)
plot(1:1000, abs(Sxy2),1:1000,abs(SxyW))
subplot(1,2,2)
plot(1:1000, angle(Sxy2),1:1000,angle(SxyW))

%%%%%%%%%%%%%%%%%%

% figure
% subplot(1,2,1)
% plot(xx,yyr,xx,fr(xx))
% subplot(1,2,2)
% plot(xx,yyi,xx,fi(xx))


index = 50:1000;
xx = freq(index);
yy = squeeze(S(index,1,2)).';
yyr = real(yy);
yyi = imag(yy);
fr = createFit55(xx, yyr);
fi = createFit55(xx,yyi);
figure
subplot(1,2,1)
plot(xx,yyr,xx,fr(xx))
subplot(1,2,2)
plot(xx,yyi,xx,fi(xx))


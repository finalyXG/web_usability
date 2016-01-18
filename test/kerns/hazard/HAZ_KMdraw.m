function HAZ_KMdraw

mf=findobj('Tag','HAZ_MAIN');
udata=get(mf,'UserData');
X=udata.X;
d=udata.d;
xx=udata.xx;
%hist_bits=udata.hist_bits;
yy=kap_mei(xx,X,d);
figure(mf);
plot(xx,yy);
tit=title('Kaplan-Meier estimation of survival function');
set(tit,'FontUnits','Normalized');
set(tit,'FontSize',0.05);



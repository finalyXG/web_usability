function HAZ_estimdraw
% function HAZ_estimdraw
% draws the density estimate

mf=findobj('Tag','HAZ_MAIN');
udata=get(mf,'UserData');
K=udata.K;
d=udata.d;
xx=udata.xx;
X=udata.X;
h=udata.h;
haf_est=K_hafest(X,d,K,xx,h);
figure(mf);
plot(xx,haf_est);
tit=title('Kernel Estimate');
set(tit,'FontUnits','Normalized');
set(tit,'FontSize',0.05);
udata.haf_est=haf_est;
set(mf,'UserData',udata);

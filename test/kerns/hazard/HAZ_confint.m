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
V=K.var;
n=length(X);
haf_est=K_hafest(X,d,K,xx,h);
L=L_n(X,xx);
alpha=0.05;
differ=sqrt((V/(n*h))*(haf_est./(1-L)))*norminv(1-alpha/2);
figure(mf);
plot(xx,haf_est,xx,haf_est+differ,'--k',xx,haf_est-differ,'--k');
tit=title('Kernel Estimate');
set(tit,'FontUnits','Normalized');
set(tit,'FontSize',0.05);
udata.haf_est=haf_est;
set(mf,'UserData',udata);

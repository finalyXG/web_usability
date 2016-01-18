function HAZARD_confi
% function HAZARD_confi
% draws the density estimate with conf. int.

mf=findobj('Tag','HAZARD_MAIN');
udata=get(mf,'UserData');
K=udata.K;
d=udata.d;
xx=udata.xx;
X=udata.X;
h=udata.h;
V=K.var;
n=length(X);
lam_est=K_hafest(X,d,K,xx,h);
L=L_n(X,xx);
alpha=0.05;
differ=sqrt((V/(n*h))*(lam_est./(1-L)))*norminv(1-alpha/2);
lam1=lam_est-differ;
lam2=lam_est+differ;
lam1=lam1.*(lam1>0);
lam2=lam2.*(lam2>0);
figure(mf);
pl=plot(xx,lam_est,xx,lam1,'--k',xx,lam2,'--k');
set(pl,'LineWidth',2);
tit=title('Confidence intervals');
set(tit,'FontUnits','Normalized');
set(tit,'FontSize',0.05);
udata.lam_est=lam_est;
set(mf,'UserData',udata);

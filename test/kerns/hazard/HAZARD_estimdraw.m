function HAZARD_estimdraw
% function HAZARD_estimdraw
% draws the hazard function estimate

mf=findobj('Tag','HAZARD_MAIN');
udata=get(mf,'UserData');
K=udata.K;
xx=udata.xx;
X=udata.X;
d=udata.d;
h=udata.h;
lam_est=K_hafest(X,d,K,xx,h);

figure(mf);
pl=plot(xx,lam_est);
set(pl,'LineWidth',2);

tit=title('Kernel Estimate');
set(tit,'FontUnits','Normalized');
set(tit,'FontSize',0.05);
udata.lam_est=lam_est;
set(mf,'UserData',udata);
ac=get(mf,'CurrentAxes');
%set(ac,'Color',[1 1 1]);
reset(ac);

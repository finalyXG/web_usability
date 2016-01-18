function HAZARD_estimdraw
% function HAZARD_estimdraw
% draws the hazard function estimate

K0=K_def('opt',0,4,0);
K2=K_def('opt',2,4,0);
mf=findobj('Tag','HAZARD_MAIN');
udata=get(mf,'UserData');
K=udata.K;
xx=udata.xx;
X=udata.X;
d=udata.d;
h=udata.h;
h0=h_iter(X,d,K0);
h2=0.8919*h0;
lam2=K_hafest(X,d,K2,xx,h2);
%x0=52;
%x1=127;
inflex=[];
lx=length(xx);
ii=1;
while ii<lx-4
 if lam2(ii)<0 & lam2(ii+4)>0
  x0=xx(ii+1);x1=xx(ii+3);
  f0=lam2(ii+1);f1=lam2(ii+3);
  x2=x1-f1*(x1-x0)/(f1-f0);
  f2=K_hafest(X,d,K2,x2,h2);
  % secant method
  while abs((x2-x1)/x2)>0.001
   x0=x1;x1=x2;f0=f1;f1=f2;
   x2=x1-f1*(x1-x0)/(f1-f0);
   f2=K_hafest(X,d,K2,x2,h2);
  end
  inflex=[inflex,x2];
  ii=ii+4; 
 else
   ii=ii+1;
 end
end
lam_est=K_hafest(X,d,K,xx,h);
figure(mf);
pl=plot(xx,lam_est);
set(pl,'LineWidth',2);
hold on
n_infl=length(inflex);
for ii=1:n_infl
 x0=inflex(ii);
 lam0=K_hafest(X,d,K,x0,h);
 pl=plot([x0,x0],[0,lam0],'r--*');
 set(pl,'LineWidth',2);
end
tit=title('Kernel Estimate');
set(tit,'FontUnits','Normalized');
set(tit,'FontSize',0.05);
udata.lam_est=lam_est;
set(mf,'UserData',udata);
ac=get(mf,'CurrentAxes');
%set(ac,'Color',[1 1 1]);
reset(ac);

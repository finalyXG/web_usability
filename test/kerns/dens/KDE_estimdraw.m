function KDE_estimdraw
% function KDE_estimdraw
% draws the density estimate

mf=findobj('Tag','KDE_MAIN');
udata=get(mf,'UserData');
K=udata.K;
xx=udata.xx;
X=udata.X;
h=udata.h;
f_est=K_dest(xx,X,h,K);

f=udata.f;
df=findobj('Tag','KDE_DrawFunction');
drawn=get(df,'UserData');
figure(mf);
if drawn
  ftrue=f(xx);
  pl=plot(xx,f_est,xx,ftrue,'--');
  set(pl,'LineWidth',2);
else
  pl=plot(xx,f_est);
  set(pl,'LineWidth',2);
end

tit=title('Kernel Estimate');
set(tit,'FontUnits','Normalized');
set(tit,'FontSize',0.05);
udata.f_est=f_est;
set(mf,'UserData',udata);
ac=get(mf,'CurrentAxes');
%set(ac,'Color',[1 1 1]);
%reset(ac);

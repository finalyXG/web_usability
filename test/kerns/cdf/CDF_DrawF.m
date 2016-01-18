function CDF_DrawF

mf=findobj('Tag','CDF_MAIN');
udata=get(mf,'UserData');
X=udata.X;
K=udata.K;
F_est=udata.F_est;
f=udata.f;
xx=udata.xx;
h=udata.h;
df=findobj('Tag','CDF_DrawFunction');
drawn=get(df,'UserData');

figure(mf);
if ~drawn
  ftrue=f(xx);
  pl=plot(xx,F_est,xx,ftrue,'--');
  set(pl,'LineWidth',2);
  set(df,'String','Clear true dist.fun.');
  set(df,'UserData',1);
else
  pl=plot(xx,F_est);
  set(pl,'LineWidth',2);
  set(df,'String','Draw true dist.fun.');
  set(df,'UserData',0);
end
ac=get(mf,'CurrentAxes');
%set(ac,'Color',[1 1 1]);
reset(ac);

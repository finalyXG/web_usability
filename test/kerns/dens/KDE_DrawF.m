function KDE_DrawF

mf=findobj('Tag','KDE_MAIN');
udata=get(mf,'UserData');
X=udata.X;
K=udata.K;
f_est=udata.f_est;
f=udata.f;
xx=udata.xx;
h=udata.h;
df=findobj('Tag','KDE_DrawFunction');
drawn=get(df,'UserData');

figure(mf);
if ~drawn
  ftrue=f(xx);
  pl=plot(xx,f_est,xx,ftrue,'--');
  set(pl,'LineWidth',2);
  set(df,'String','Clear true density');
  set(df,'UserData',1);
else
  pl=plot(xx,f_est);
  set(pl,'LineWidth',2);
  set(df,'String','Draw true density');
  set(df,'UserData',0);
end
ac=get(mf,'CurrentAxes');
%set(ac,'Color',[1 1 1]);
%reset(ac);

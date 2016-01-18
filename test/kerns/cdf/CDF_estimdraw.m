function CDF_estimdraw
% function CDF_estimdraw
% draws the cdf estimate

mf=findobj('Tag','CDF_MAIN');
udata=get(mf,'UserData');
K=udata.K;
xx=udata.xx;
X=udata.X;
h=udata.h;
F_est=K_cdfest(X,K,xx,h);

f=udata.f;
df=findobj('Tag','CDF_DrawFunction');
drawn=get(df,'UserData');
figure(mf);
if drawn
  ftrue=f(xx);
  pl=plot(xx,F_est,xx,ftrue,'--');
  set(pl,'LineWidth',2);
else
  pl=plot(xx,F_est);
  set(pl,'LineWidth',2);
end

tit=title('Kernel Estimate');
set(tit,'FontUnits','Normalized');
set(tit,'FontSize',0.05);
udata.F_est=F_est;
set(mf,'UserData',udata);
ac=get(mf,'CurrentAxes');
%set(ac,'Color',[1 1 1]);
reset(ac);

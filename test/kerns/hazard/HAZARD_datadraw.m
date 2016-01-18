function HAZARD_datadraw

mf=findobj('Tag','HAZARD_MAIN');
udata=get(mf,'UserData');
X=udata.X;
d=udata.d;
i0=find(d==0);
i1=find(d==1);
X0=X(i0);
X1=X(i1);
figure(mf);
pl=plot(X1,zeros(size(X1)),'x',X0,zeros(size(X0)),'o');
set(pl,'MarkerSize',12);
tit=title('Data');
legend('uncensored','censored');
set(tit,'FontUnits','Normalized');
set(tit,'FontSize',0.05);
ac=get(mf,'CurrentAxes');
%set(ac,'Color',[1 1 1]);
reset(ac);


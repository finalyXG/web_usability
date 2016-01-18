function KDE_datadraw

mf=findobj('Tag','KDE_MAIN');
udata=get(mf,'UserData');
X=udata.X;
figure(mf);
plot(X,zeros(size(X)),'x');
tit=title('Data');
set(tit,'FontUnits','Normalized');
set(tit,'FontSize',0.05);
ac=get(mf,'CurrentAxes');
%set(ac,'Color',[1 1 1]);
%reset(ac);


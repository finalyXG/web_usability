function HAZ_datadraw

mf=findobj('Tag','HAZ_MAIN');
udata=get(mf,'UserData');
X=udata.X;
figure(mf);
plot(X,zeros(size(X)),'x');
tit=title('Data');
set(tit,'FontUnits','Normalized');
set(tit,'FontSize',0.05);


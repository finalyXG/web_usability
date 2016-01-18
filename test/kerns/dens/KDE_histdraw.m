function KDE_histdraw

mf=findobj('Tag','KDE_MAIN');
udata=get(mf,'UserData');
X=udata.X;
hist_bits=udata.hist_bits;
figure(mf);
hist(X,hist_bits);
tit=title('Histogram');
set(tit,'FontUnits','Normalized');
set(tit,'FontSize',0.05);
ac=get(mf,'CurrentAxes');
%set(ac,'Color',[1 1 1]);
%reset(ac);



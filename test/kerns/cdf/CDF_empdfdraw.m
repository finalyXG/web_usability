function CDF_empdfdraw

mf=findobj('Tag','CDF_MAIN');
udata=get(mf,'UserData');
X=udata.X;
xx=udata.xx;
Femp=distf_emp(X,xx);
figure(mf);
plot(xx,Femp);
tit=title('Empirical distribution function');
set(tit,'FontUnits','Normalized');
set(tit,'FontSize',0.05);
ac=get(mf,'CurrentAxes');
%set(ac,'Color',[1 1 1]);
%reset(ac);



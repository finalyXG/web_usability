function HAZARD_empdfdraw

mf=findobj('Tag','HAZARD_MAIN');
udata=get(mf,'UserData');
X=udata.X;
xx=udata.xx;
d=udata.d;
Femp=kap_mei(xx,X,d);
figure(mf);
plot(xx,Femp);
tit=title('Kaplan-Meier estimate of survival function');
set(tit,'FontUnits','Normalized');
set(tit,'FontSize',0.05);
ac=get(mf,'CurrentAxes');
%set(ac,'Color',[1 1 1]);
%reset(ac);



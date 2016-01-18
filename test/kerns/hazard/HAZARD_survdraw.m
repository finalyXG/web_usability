function HAZARD_estimdraw
% function HAZARD_estimdraw
% draws the hazard function estimate

mf=findobj('Tag','HAZARD_MAIN');
udata=get(mf,'UserData');
K=udata.K;
x=udata.xx;
X=udata.X;
d=udata.d;
h=udata.h;


X=row(X);
[XX,in]=sort(X);
dd=row(d(in));
x=row(x);
n=length(X);

pp=K.coef;
pp=polyint(pp);

y=[];
pn=1./(n+1-(1:n));
a=max([-1*ones(size(XX));-XX/h]);
pa=polyval(pp,a);
for xx=x
 b=min([1*ones(size(XX));(xx-XX)/h]);
 b(find(b<=-1))=-1;
 pb=polyval(pp,b);
 px=pb-pa;
 yp=dd.*px.*pn;
% yp=yp.*dd;
 y=[y sum(yp)];
end
% v y je integral od 0 do x z ~lamda(x)
Fbar=exp(-y);




figure(mf);
pl=plot(x,Fbar);
set(pl,'LineWidth',2);

tit=title('Kernel Estimate of Survival Function');
set(tit,'FontUnits','Normalized');
set(tit,'FontSize',0.05);
ac=get(mf,'CurrentAxes');
%set(ac,'Color',[1 1 1]);
reset(ac);

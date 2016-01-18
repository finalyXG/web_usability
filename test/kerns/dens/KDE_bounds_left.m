function KDE_bounds_left

mf=findobj('Tag','KDE_MAIN');
udata=get(mf,'UserData');
bounds=udata.bounds;
a=bounds(1);
X=udata.X;
K=udata.K;
f_est=udata.f_est;
xx=udata.xx;
h=udata.h;
I0=find(xx<a);
f_est(I0)=0;
I1=find((xx>=a) & (xx<=a+h));
xx1=xx(I1);
n=length(X);
y=zeros(size(xx1));
for ii=1:n
 px1=(xx1-X(ii))/h;
 px2=(xx1+X(ii)-2*a)/h;
 y=y+K_val(K,px1)+K_val(K,px2);
end
y=y/(n*h);
f_est(I1)=y;

f=udata.f;
df=findobj('Tag','KDE_DrawFunction');
drawn=get(df,'UserData');
figure(mf);
if drawn
  ftrue=f(xx);
  pl=plot(xx,f_est,xx,ftrue,'--');
  set(pl,'LineWidth',2);
else
  pl=plot(xx,f_est);
  set(pl,'LineWidth',2);
end

udata.f_est=f_est;
set(mf,'UserData',udata);
ac=get(mf,'CurrentAxes');
%set(ac,'Color',[1 1 1]);
%reset(ac);

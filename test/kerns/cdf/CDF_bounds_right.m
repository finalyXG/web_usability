function CDF_bounds_right

mf=findobj('Tag','CDF_MAIN');
udata=get(mf,'UserData');
bounds=udata.bounds;
b=bounds(2);
X=udata.X;
K=udata.K;
W=W_def(K);
F_est=udata.F_est;
xx=udata.xx;
h=udata.h;
I0=find(xx>b);
F_est(I0)=1;
I1=find((xx<=b) & (xx>=b-h));
xx1=xx(I1);
n=length(X);
y=zeros(size(xx1));
for ii=1:n
 px1=(xx1-X(ii))/h;
 px2=(xx1+X(ii)-2*b)/h;
 y=y+W_val(W,px1)+1-W_val(W,-px2);
end
y=y/(n);
F_est(I1)=y;

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

udata.F_est=F_est;
set(mf,'UserData',udata);
ac=get(mf,'CurrentAxes');
%set(ac,'Color',[1 1 1]);
reset(ac);

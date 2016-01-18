function KDE_kerdraw
% function KDE_kerdraw
% draws the kernel

sf=findobj('Tag','KDE_setting');
udata=get(sf,'UserData');
K=udata.K;
Interval=K.support;
l_bound=Interval(1);
u_bound=Interval(2);
if l_bound>u_bound
 l_bound=Interval(2);
 u_bound=Interval(1);
end
if isinf(l_bound) l_bound=-3; end
if isinf(u_bound) u_bound=3; end
l_i=u_bound-l_bound;
l_bound=l_bound-0.1*l_i;
u_bound=u_bound+0.1*l_i;
xx=linspace(l_bound,u_bound,201);
yy=K_val(K,xx);
figure;
plot(xx,yy);
tit=title('Shape of the Kernel');
set(tit,'FontUnits','Normalized');
set(tit,'FontSize',0.05);


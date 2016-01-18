function y=K_hafest(X,d,K,x,h)
% function y=K_hafest(X,d,K,xx,h)
% kernel estimation of hazard function

% new version

if 1
nu=K.nu;
k=K.k;

X=row(X);
[XX,in]=sort(X);
dd=row(d(in));

n=length(X);
pn=1./(n+1-(1:n));
I1=find(dd);
d1=dd.*pn;
d1=col(d1(I1));
X1=XX(I1);
n1=length(X1);
% only non-zero elements

x=col(x);
nx=length(x);
hp=h;
for i=1:nu
 hp=hp*h;
end
x_X=(x*ones(1,n1)-ones(nx,1)*X1)/h;
y=K_val(K,x_X)*d1;
y=row(y)/hp;
if nu==0
 y=y.*(y>0);
end
return


% old version follows
else %if 0/1
nu=K.nu;
k=K.k;

X=row(X);
[XX,in]=sort(X);
dd=row(d(in));

x=row(x);
n=length(X);
y=[];
hp=h;
for i=1:nu
 hp=hp*h;
end

pn=1./(n+1-(1:n));
for xx=x
 px=(xx-XX)/h;
 yp=dd.*K_val(K,px).*pn;
% yp=yp.*dd;
 y=[y sum(yp)/(hp)];
end
if nu==0
 y=y.*(y>0);
end
return
end %if 0
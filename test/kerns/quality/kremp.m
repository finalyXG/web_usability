function[KR,r,x,F1emp,F2emp]=kremp(x1,x2,C)
%spocita a vykresli empirickou KR krivku
x1=x1(:)';x2=x2(:)';

xsmes=[x1,x2];
k=length(x1)/length(xsmes);
[ni,nx]=hist(xsmes,1000);
nxd=nx(2)-nx(1);
nx=[-Inf,nx-nxd/2,nx(end)+nxd/2,Inf];
ni1=histc(x1,nx);
ni2=histc(x2,nx);
F1emp=cumsum(ni1)/length(x1);
F2emp=cumsum(ni2)/length(x2);

r=(F1emp-F2emp).^2./((F1emp-F2emp).^2+1/k*F2emp.*(1-F2emp)+1/(1-k)*F1emp.*(1-F1emp));
x=nx;

KR=max(abs(r));

if nargin==3
figure(C);
plot(x,r);
end;

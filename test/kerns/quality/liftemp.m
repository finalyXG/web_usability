function[lift,r,x,LR,Lift_id,IRL,Rlift,rand_lift,F1emp,F2emp]=liftemp(x1,x2,q,C)
%spocita a vykresli empirickou lift krivku
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

Femp=(k*F1emp+(1-k)*F2emp);
ind=(Femp==0);
Femp(ind)=[];
F1emp(ind)=[];
r=F1emp./Femp;
% nx(ind)=[];
% x=nx;
x=Femp;

dx=x(2:end)-x(1:end-1);
lift=(r(1:end-1)+r(2:end))/2*dx';

Lift_id=(x<=k)/k+(x>k)./x;
B=(Lift_id(1:end-1)+Lift_id(2:end))/2*dx';
LR=(lift-1)/(B-1);

Rlift=r./Lift_id;
IRL=(Rlift(1:end-1)+Rlift(2:end))/2*dx';
rand_lift=(x<=k)*k+(x>k).*x;

if nargin==3
    lift=qlift(x,r,q);
end
if nargin==4
figure(C);
p1=plot(x,r);
hold on;
p2=plot(x,Lift_id,'r');
legend([p1,p2],'Qlift','Ideal Qlift');
lift=qlift(x,r,q,C);

figure(C+1);
p1=plot(x,Rlift);
hold on;
p2=plot(x,rand_lift,'m');
legend([p1,p2],'Rlift','Random Rlift');

end;

function[lift,r,x,LR,Lift_id,IRL,Rlift,rand_lift,F1,F2]=liftker(x1,x2,q,C)
%spocita a vykresli kernel lift krivku
x1=x1(:)';x2=x2(:)';

xsmes=[x1,x2];
k=length(x1)/length(xsmes);

KK=K_def('epan');
h1=h_F(x1,KK);
h2=h_F(x2,KK);h=max([h1,h2]);
xx=linspace(min(xsmes)-h,max(xsmes)+h,1000); %tady jsem pridal -h1,+h2
%   h1=1;h2=1;
F1=ksF(x1,0,2,1,h1,xx);%keyboard;
F2=ksF(x2,0,2,1,h2,xx);%keyboard;

F=(k*F1+(1-k)*F2);
ind=(F==0);
F(ind)=[];
F1(ind)=[];
r=F1./F;
x=F;

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

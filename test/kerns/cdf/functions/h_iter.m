function h_new=h_iter(h_old,k,X)
% jeden krok iteracni metody pro vypocet sirky okna

%delta=0.1;
delta=0.04;
pol=k_opt(0,k,1);
DEST_PARAM=struct('X',X,'ny',0,'k',k,'mi',0,'delta0',1,'h',h_old);
n=length(X);
xmax=max(X);
xmin=min(X);
xrange=xmax-xmin;
%x=linspace(xmin,xmax,51);
x=linspace(xmin-h_old,xmax+h_old,51);
nx=length(x);
y=-1:delta:1;
ny=length(y);
vk=polyval(pol,y);
Icit=[];Ijmen=[];
for xx=x
 py=xx-h_old*y;
 v1=dedest(py,DEST_PARAM); %^f(x-hy)
 cit=(vk.^2).*v1;
 jmen=vk.*v1;
 CIT=delta*sum(cit); CIT=CIT-0.5*delta*(cit(1)+cit(ny));
 JMEN=delta*sum(jmen); JMEN=JMEN-0.5*delta*(jmen(1)+jmen(ny));
 JMEN=(JMEN-dedest(xx,DEST_PARAM))^2;
 Icit=[Icit, CIT];
 Ijmen=[Ijmen JMEN];
end
ICIT=sum(Icit)-0.5*(Icit(1)+Icit(nx));
IJMEN=sum(Ijmen)-0.5*(Ijmen(1)+Ijmen(nx));
h_new=(1/(2*k*n))*(ICIT/IJMEN);

function Q=movepol(P,c)
% function Q=movepol(P,c)
% Q(x)=P(x-c)

Q=[];
P0=P;
n=length(P);
for ii=1:n
    n0=length(P0);
    pom=P0(1);
    P1=pom;
    for jj=2:n0
        pom=P0(jj)-c*pom;
        P1=[P1,pom];
    end
    Q=[pom,Q];
    P0=P1(1:n0-1);
end

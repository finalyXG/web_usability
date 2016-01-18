function Hit=H_iter(XX,m,D)
% auxiliary function for KSBIVARDENS toolbox
%
% (C) Kamila Vopatova, Masaryk University (Czech Republic)

if nargin==2
    D='f';
end
[d,n]=size(XX);
S=cov(XX');
moc=((d+2*m+4)*(d+4)+4*m)/((d+2*m+4)*(d+4));
if strcmp(D,'d')==1
    P=(diag(diag(S))./S(1,1)).^moc;
else
    P=sign(S).*(abs(S./S(1,1))).^moc;
end
X=XX(1,:);
aa=diff(sort(X));
aa(aa==0)=[];
h_min_x=min(aa);%mean(aa);
h_max_x=(max(X)-min(X))/2;

% zakladni vztah
% AIV(H) =4/(d+2m)*AISB(H)

% nastreleni hodnot pro h11
jemnost=51;
nastrel=linspace(h_min_x^2,h_max_x^2,jemnost);
%nastrel=logspace(log10(h_min_x^2),log10(h_max_x^2),jemnost);
hodnoty=zeros(1,jemnost);
for k=1:jemnost
    h11=nastrel(k);
    H=h11*P;
    hodnoty(k)=(d+2*m)*AIV(H,n,m)-4*AISB(XX,H,m);
end;
zn_hodnoty=sign(hodnoty);
zn_posl=sign(hodnoty(jemnost));
idx_leva=find(zn_hodnoty~=zn_posl,1,'last');

% metoda regula falsi
x0=nastrel(idx_leva);
fx0=hodnoty(idx_leva);
x1=nastrel(idx_leva+1);
fx1=hodnoty(idx_leva+1);
M=[x0,x1;fx0,fx1];
pocet=1;
wai=waitbar(0,'Computing the bandwidth matrix by IT ...');
while ((abs((x0-x1)/x1)>=0.0001)&&(pocet<=100))
    x2=x1-fx1*(x1-x0)/(fx1-fx0);
    h11=x2;
    H=h11*P;
    fx2=(d+2*m)*AIV(H,n,m)-4*AISB(XX,H,m);
    M=[M,[x2;fx2]];
    idx_p=find(sign(fx2)~=sign(M(2,:)),1,'last');
    x0=M(1,idx_p);
    fx0=M(2,idx_p);
    x1=x2;
    fx1=fx2;
    pocet=pocet+1;
    waitbar(0.0001/abs((x0-x1)/x1),wai);    
end;
close(wai);
[~,sM2]=size(M);
h11a=M(1,sM2);
Hit=h11a*P;

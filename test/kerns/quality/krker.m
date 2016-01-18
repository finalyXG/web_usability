function[KR,r,x,F1,F2]=krker(x1,x2,C)
%spocita a vykresli kernel KR krivku
x1=x1(:)';x2=x2(:)';

xsmes=[x1,x2];
k=length(x1)/length(xsmes);

KK=K_def('epan');
h1=h_F(x1,KK);
h2=h_F(x2,KK);h=max([h1,h2]);
xx=linspace(min(xsmes)-h,max(xsmes)+h); %tady jsem pridal -h1,+h2
%   h1=1;h2=1;
F1=ksF(x1,0,2,1,h1,xx);%keyboard;
F2=ksF(x2,0,2,1,h2,xx);%keyboard;

r=(F1-F2).^2./((F1-F2).^2+1/k*F2.*(1-F2)+1/(1-k)*F1.*(1-F1));
x=xx;
        
KR=max(abs(r));

if nargin==3
figure(C);
plot(x,r);
end;

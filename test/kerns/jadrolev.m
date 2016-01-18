function[K,beta]=jadrolev(n,k,m,p);
%JADROLEV  compute special left boundary kernel
%
%[K,beta]=jadrolev(n,k,m,p) 
%        K ....... the kernel (polynomial)
%        beta .... int_{-1}^1 x^k K(x)dx
%       [n,k] .... order of kernel
%        m ....... the smoothness of used kernel
%        p ....... [-1,p] is the support of left boundary kernel
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

alfa=m+.5;
P=zeros(k);PP=P;
P(1,k)=1;Bn=P;PP(1,1)=1;
Bnk=P;Bk=ones(k)*prod(1:n);
if k>=2
   P(2,k-1)=2*alfa;
   PP(2,1)=2*alfa;
 for i=2:k-1
 P(i+1,:)=(2*(i-1+alfa))/i*conv(P(i,2:k),[1,0])-(i-2+2*alfa)/i*P(i-1,:);
 PP(i+1,1:i+1)=P(i+1,k-i:k);
end;
end;
Bn=tril(ones(k))*tril(ones(k),-1);
Bnk=Bn-n;Bnk(Bnk<=0)=1;
Bn(Bn==0)=1;Bk(Bk==0)=1;
B=cumprod(Bn)./(Bk.*cumprod(Bnk));B=tril(B,-n);
PP=PP.*B;
ind=tril(ones(k))*tril(ones(k),-1);ind(ind<n)=n;
pom=(1-p).^(ind-n)./((1+p).^ind);
PP=PP.*pom;
c=sum(PP')';
%vyrobime ai
fakt=[1,prod((triu(ones(k-1))^2)+tril(ones(k-1),-1))];
icka=0:k-1;
a=pi*2^(1-2*m)*gamma(2*m+icka+1)./(fakt.*(2*m+2*icka+1)*gamma(alfa)^2);
a=a';
pp=(c./a)*ones(1,k);
P=pp.*P;
K=(-1)^n*prod(1:n)*2^(n+1)/(p+1)*sum(P(n+1:k,:));
pred=1;
for i=1:m
   pred=conv(pred,[-1,0,1]);
end;
K=conv(pred,K);l=max(find(fliplr(K)));
pom=[1,zeros(1,k+1)];
beta=mypolyint(conv(pom,K),-1,1);
pol=poly2sym(K);
x=sym('x');x=(2*x-p+1)/(p+1);
newpol=eval(pol);
if l~=1
   K=sym2poly(newpol);
else
   K=newpol;
end;

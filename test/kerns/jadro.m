function[K,beta,delta,V]=jadro(n,k,m);
%JADRO  compute the kernel of order (n,k) and smoothness m
%
%[K,beta,delta,V]=jadro(n,k,m) 
%        K ....... the kernel (polynomial)
%        beta .... int_{-1}^1 x^k K(x)dx
%        delta ... canonical parameter (see theory)
%        V ....... int_{-1}^1 K(x)^2 dx
%       [n,k] .... order of kernel
%        m ....... the smoothness of used kernel
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

k=k-1;
alfa=m+.5;
P=zeros(k);
P(1,k)=1;
if k>=2
 P(2,k-1)=2*alfa;
 for i=2:k-1
 P(i+1,:)=(2*(i-1+alfa))/i*conv(P(i,2:k),[1,0])-(i-2+2*alfa)/i*P(i-1,:);
 end;
end;
%vyrobime ai
fakt=[1,prod((triu(ones(k-1))^2)+tril(ones(k-1),-1))];
icka=0:k-1;
a=pi*2^(1-2*m)*gamma(2*m+icka+1)./(fakt.*(2*m+2*icka+1)*gamma(alfa)^2);
a=a';
pp=(P(:,k-n)./a)*ones(1,k);
P=pp.*P;
if k>n+1
 K=(-1)^n*prod(1:n)*sum(P(n+1:k,:));
else
 K=(-1)^n*prod(1:n)*P(k,:);
end;
pred=1;
for i=1:m
   pred=conv(pred,[-1,0,1]);
end;
K=conv(pred,K);
pom=[1,zeros(1,k+1)];
beta=mypolyint(conv(pom,K),-1,1);
V=mypolyint(conv(K,K),-1,1);
delta=(V/beta^2)^(1/(2*k+3));
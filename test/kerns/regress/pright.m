function[p]=pright(n,k,m);
%PRIGHT  optimal knots for the right boundary kernel regression
%
%[p]=pright(n,k,m) 
%        p ....... vector of knots
%       [n,k] .... order of used kernel
%        m ....... the smoothness of used kernel
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

%Nejprve Gegenbauerovy polynomy 
alfa=m+n+1.5;
P=zeros(k-n);
P(1,k)=1;
if k>=2
 P(2,k-1)=2*alfa;
 for i=2:k-n-1
 P(i+1,:)=(2*(i-1+alfa))/i*conv(P(i,2:k),[1,0])-(i-2+2*alfa)/i*P(i-1,:);
 end;
end;
C=P(end,:);
%pak zaporne koreny
r=roots(C);
r=r(r>=0);
p=-(1-r)./(1+r);
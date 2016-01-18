function y=kap_mei(x,X,d)
% function y=kap_mei(x)
% Kaplan-Meier estimation of survival function
% x - eval. points
% X - data
% d - censors

[Z,I]=sort(X);
D=d(I);
n=length(X);
y=[];
for xx=row(x)
% if xx>Z(n)
%  yp=0;
% else
  I1=find(Z<xx);
  D1=D(I1);
  yp=prod(((n-I1)./(n+1-I1)).^D1);
% end
 y=[y, yp];
end
[mx,nx]=size(x);
if nx==1 y=y'; end

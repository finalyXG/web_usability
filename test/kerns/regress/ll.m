function[SS,yy]=ll(x,y,n,k,mm,h,C);
%LL  local - linear estimator
%
%[S,yy]=ll(x,y,n,k,m,h,C) 
%        S ...... smoothing matrix
%        yy ..... values of estimated curve
%       [x,y] ... data set
%       [n,k] ... order of used kernel
%        m ...... the smoothness of used kernel
%        h ...... bandwidth
%        C ...... figure handle for the error function plot (optional: default=[]=no plot)
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

x=x(:)';y=y(:)';
m=length(x);
K=jadro(n,k,mm);
if nargin>=6       
  krit=max(abs(x(2:m)-x(1:m-1)));
  

x_x=x'*ones(1,m)-ones(m,1)*x;
yy=[abs(x_x/h)<1-1e-8].*polyval(K,x_x/h)/h;
s2=yy.*x_x.^2;
s1=yy.*x_x;
s1=ones(m,1)*sum(s1)/m;
s2=ones(m,1)*sum(s2)/m;
s0=ones(m,1)*sum(yy)/m;
pom=find(abs(s0.*s2-s1.^2)<=1e-12);
s1=s1(pom);s2=s2(pom);s0=s0(pom);
if isempty(pom)
   pom=1;s0=1;s2=2;s1=1;%umele nastaveni si, aby se nedelilo 0
end;
yy(pom)=(s2-s1.*x_x(pom)).*yy(pom)./(s0.*s2-s1.^2);

SS=yy/m;
yy=y*yy/m;         
end;
if krit>h
   SS=[];
   disp(['For h=',num2str(h),' smoothing matrix does not exist !']);
end;

if nargin==7
   figure(C);
plot(x,y,'x');
hold on;axis(axis);
plot(x,yy,'g');hold off;
title(['The local-linear estimate with kernel of order (',num2str(n),...
    ', ',num2str(k),'), smoothness ',num2str(mm-1),' and h = ',num2str(h)]);
end;

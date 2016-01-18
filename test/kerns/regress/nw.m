function[SS,yy]=nw(x,y,n,k,mm,h,C);
%NW  Nadaraya - Watson estimator
%
%[S,yy]=nw(x,y,n,k,m,h,C) 
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
%R=fix(101/m);
%if R>0
%   xx=min(x):krit/R:max(x)+1e-8;
%else
%   xx=x;
%end;
%mp=length(xx);
  

x_x=x'*ones(1,m)-ones(m,1)*x;
yy=[abs(x_x/h)<1-1e-8].*polyval(K,x_x/h)/h;
s0=ones(m,1)*sum(yy);
pom=find(s0);
s0=s0(pom);
yy(pom)=yy(pom)./s0;

%x_xx=x'*ones(1,mp)-ones(m,1)*xx;
%yyp=[abs(x_xx/h)<1-1e-8].*polyval(K,x_xx/h)/h;
%s0p=ones(m,1)*sum(yyp);
%pomp=find(s0p);
%s0p=s0p(pomp);
%yyp(pomp)=yyp(pomp)./s0p;

SS=yy;
yy=y*yy;         
end;
if krit>h
   SS=[];
   disp(['For h=',num2str(h),' smoothing matrix does not exist !']);
end;

if nargin==7
   figure(C);
plot(x,y,'x');
hold on;axis(axis);
plot(x,yy,'r');hold off;
title(['The Nadaraya-Watson estimate with kernel of order (',num2str(n),...
    ', ',num2str(k),'), smoothness ',num2str(mm-1),' and h = ',num2str(h)]);
end;

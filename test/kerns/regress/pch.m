function[SS,yy]=pch(x,y,n,k,mm,h,C);
%PCH  Pristley - Chao estimator
%
%[S,yy]=pch(x,y,n,k,m,h,C) 
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
%K=[-.75,0,.75];
if nargin>=6       
  krit=max(abs(x(2:m)-x(1:m-1)));

x_x=x'*ones(1,m)-ones(m,1)*x;
yy=[abs(x_x/h)<1-1e-8].*polyval(K,x_x/h)/h;

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
plot(x,yy,'c');hold off;
title(['The Pristley-Chao estimate with kernel of order (',num2str(n),...
    ', ',num2str(k),'), smoothness ',num2str(mm-1),' and h = ',num2str(h)]);
end;

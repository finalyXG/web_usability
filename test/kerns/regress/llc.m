function[SS,yyp]=llc(x,y,n,k,mm,h,C)
%LLC  local - linear estimator for cyclic model
%
%[S,yy]=llc(x,y,n,k,m,h,C) 
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

if nargin>=6
   [SS,yyp]=nwc(x,y,n,k,mm,h);
end;

if nargin==7
   figure(C);
plot(x,y,'x');
hold on;axis(axis);
plot(x,yyp,'g');hold off;
title(['The local-linear estimate for cyclic model with kernel of order (',num2str(n),...
    ', ',num2str(k),'), smoothness ',num2str(mm-1),' and h = ',num2str(h)]);
end;

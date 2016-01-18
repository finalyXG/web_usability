function[yd,yh]=intsp(x,y,n,k,mm,h,alfa,S,f,C);
%INTSP  confidence intervals for kernel regression
%
%[yl,yr]=intsp(x,y,n,k,m,h,alfa,S,f,C) - vykresli intervaly spolehlivosti
%
%        [yl,yr] ... left and right boundary of confidence interval at design points 
%        [x,y] ..... data set
%        [n,k] ..... order of used kernel
%         m ........ the smoothness of used kernel
%         h ........ bandwidth
%         alfa ..... risk level
%         S ........ smoothing matrix
%         f(t) ..... regression function (optional: default=[]=kernel estimate will be used)
%         C ........ figure handle for the error function plot (optional: default=[]=no plot)
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

x=x(:)';y=y(:)';
m=length(x);
[K,beta,delta,V]=jadro(n,k,mm);

%odhad sigma
if nargin<=8
   f=1;C=1;
end;
if nargin>8 & isstr(f) 
   t=x;
   mx=eval(vectorize(f));mx=mx(:)';
else
   mx=y*S;C=f;
end;
sigma=abs(((y-mx).^2)*S); %ABS ??????!!!!!
u=norminv(1-alfa/2);
odchylka=u*sqrt((V*sigma)/(m*h));
yd=mx-odchylka;
yh=mx+odchylka;

if (nargin==9&~isstr(f))|nargin==10
   figure(C);
   plot(x,y,'x');hold on;
   axis(axis);
   plot(x,yd,'g:',x,yh,'g:');
end;

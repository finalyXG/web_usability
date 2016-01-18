function[xx,yy]=smpchright(x,y,n,k,mm,h,C,xp,yp);
%SMPCHRIGHT  smoothed data by Pristley - Chao estimator with using of special right boundary
%           kernel
%
%[xx,yy]=smpchright(x,y,n,k,m,h,C,xp,yp) 
%       [xx,yy] ... smoothed data
%       [x,y] ..... data set
%       [n,k] ..... order of used kernel
%        m ........ the smoothness of used kernel
%        h ........ bandwidth
%        C ........ figure handle for the estimated function plot (optional: default=[]=no plot)
%       [xp,yp] ... vector of points, for which will be computed values of
%                   estimated curve (optional: default=[]=[x,y])
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

krit=max(abs(x(2:end)-x(1:end-1)));
if krit>h
   h=krit;
   disp(['For h=',num2str(h),' smoothing matrix does not exist !']);
end;

jed=x(end);
yy=[];
p=pright(n,k,mm);
p=sort(p);
q=p*h;
if ~ismember(0,q) q=[q;0];end;
if ~ismember(-h,q) q=[-h,q'];end;
mu=sum(x<=jed-h);
xx=x(mu+1):(max(x)-min(x))/50:x(end);
if xx(1)==0 xx(1)=[];end;
l=length(q);
for j=2:l
 %  xx,q(j)+jed,q(j-1)+jed
   %xx(find((xx<=(q(j)+jed))&(xx>(q(j-1)+jed)))),pause;
   %xx(find((xx<=q(j))&(xx>q(j-1))))
   y1=pchright(x,y,n,k,mm,h,p(j-1),xx(find((xx<=(q(j)+jed))&(xx>(q(j-1)+jed)))));
   yy=[yy,y1];
end;

if nargin>=7
   figure(C);
   plot(x,y,'x');
   hold on;axis(axis);
   if nargin>7
      if length(xp)~=length(yp)
         error('xp and yp should be the same length!');
      end;
      mu=sum(xp<=jed-h);
      xp(mu+1:end)=[];yp(mu+1:end)=[];
      xx=[xp,xx];
      yy=[yp,yy];
   end;
   H=plot(xx,yy,'c');
   hold off;
   title('Pristley-Chao with boundary kernels');
end;

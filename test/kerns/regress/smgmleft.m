function[xx,yy]=smgmleft(x,y,n,k,mm,h,C,xp,yp);
%SMGMLEFT  smoothed data by Gasser - Mueller estimator with using of special left boundary
%          kernel
%
%[xx,yy]=smgmleft(x,y,n,k,m,h,C,xp,yp) 
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

yy=[];
p=pleft(n,k,mm);
p=sort(p);
q=p*h;
if ~ismember(0,q) q=[0;q];end;
if ~ismember(h,q) q=[q',h];end;
mu=sum(x<h);
xx=min(x):(max(x)-min(x))/50:x(mu);
%xx=x(1:mu);
if xx(1)==0 xx(1)=[];end;
l=length(q);
for j=2:l
   y1=gmleft(x,y,n,k,mm,h,p(j-1),xx(find((xx<=q(j))&(xx>q(j-1)))));
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
      mu=sum(xp<h);
      xp(1:mu)=[];yp(1:mu)=[];
      xx=[xx,xp];
      yy=[yy,yp];
   end;
   plot(xx,yy,'m');
   hold off;
   title('Gasser-Mueller with boundary kernels');
end;

   
function[yy]=pchright(x,y,n,k,mm,h,p,xx);
%PCHRIGHT  Pristley - Chao estimator with using of special right boundary
%          kernel
%
%[yy]=pchright(x,y,n,k,m,h,p,xx) 
%        yy ..... values of estimated curve
%       [x,y] ... data set
%       [n,k] ... order of used kernel
%        m ...... the smoothness of used kernel
%        h ...... bandwidth
%        p ...... [p,1] is the support of right boundary kernel
%        xx ..... vector of points, for which will be computed values of
%                 estimated curve
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

K=jadroprav(n,k,mm,p);
m=length(x);
for i=1:m
   v=(x(i)-xx)/h;
   yy(i,:)=[(v>=p)&(v<=1)].*polyval(K,v)/h;
end;
yy=y*yy/m;

function[yy]=pchleft(x,y,n,k,mm,h,p,xx);
%PCHLEFT  Pristley - Chao estimator with using of special left boundary
%         kernel
%
%[yy]=pchleft(x,y,n,k,m,h,p,xx) 
%        yy ..... values of estimated curve
%       [x,y] ... data set
%       [n,k] ... order of used kernel
%        m ...... the smoothness of used kernel
%        h ...... bandwidth
%        p ...... [-1,p] is the support of left boundary kernel
%        xx ..... vector of points, for which will be computed values of
%                 estimated curve
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

K=jadrolev(n,k,mm,p);
m=length(x);
for i=1:m
   v=(x(i)-xx)/h;
   yy(i,:)=[(v>=-1)&(v<=p)].*polyval(K,v)/h;
end;

yy=y*yy/m;

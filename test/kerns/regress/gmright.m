function[yy]=gmright(x,y,n,k,mm,h,p,xx);
%GMRIGHT  Gasser - Mueller estimator with using of special right boundary
%         kernel
%
%[yy]=gmright(x,y,n,k,m,h,p,xx) 
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

[x,ind]=sort(x); 
y=y(ind);
s=[zeros(1,m),1];
s(2:m)=(x(2:m)+x(1:m-1))/2;

for i=1:m
   v=(x(i)-xx)/h;
   yy(i,:)=[(v>=p)&(v<=1)].*mypolyint(K,(s(i)-xx)/h,(s(i+1)-xx)/h);
end;

yy=y*yy/h^n;         

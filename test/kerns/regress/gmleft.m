function[yy]=gmleft(x,y,n,k,mm,h,p,xx);
%GMLEFT  Gasser - Mueller estimator with using of special left boundary
%        kernel
%
%[yy]=gmleft(x,y,n,k,m,h,p,xx) 
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

[x,ind]=sort(x); 
y=y(ind);
s=[zeros(1,m),1];
s(2:m)=(x(2:m)+x(1:m-1))/2;

%s1=s(1:m)'*ones(1,m)-ones(m,1)*x;
%s2=s(2:m+1)'*ones(1,m)-ones(m,1)*x;

for i=1:m
   v=(x(i)-xx)/h;
   yy(i,:)=[(v>=-1)&(v<=p)].*mypolyint(K,(s(i)-xx)/h,(s(i+1)-xx)/h);
end;

yy=y*yy/h^n;         

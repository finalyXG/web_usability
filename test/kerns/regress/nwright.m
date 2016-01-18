function[yy]=nwright(x,y,n,k,mm,h,p,xx);
%NWRIGHT  Nadaraya - Watson estimator with using of special right boundary
%         kernel
%
%[yy]=nwright(x,y,n,k,m,h,p,xx) 
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
s=sum(yy);
pom=find(s);
S=ones(m,1)*s(pom);
yy=yy(:,pom)./S;
yy=y*yy;

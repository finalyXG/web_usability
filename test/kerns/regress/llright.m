function[yy]=llright(x,y,n,k,mm,h,p,xx);
%LLRIGHT  local - linear estimator with using of special right boundary
%         kernel
%
%[yy]=llright(x,y,n,k,m,h,p,xx) 
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
 s2(i,:)=yy(i,:).*(x(i)-xx).^2;
 s1(i,:)=yy(i,:).*(x(i)-xx);
end;
s1=1/m*sum(s1);
s2=1/m*sum(s2);
s0=1/m*sum(yy);
pom=find(abs(s0.*s2-s1.^2));
s1=s1(pom);s2=s2(pom);s0=s0(pom);%xx=xx(pom);yy=yy(:,pom);
for i=1:m
 yy(i,pom)=(s2-s1.*(x(i)-xx(pom))).*yy(i,pom)./(s0.*s2-s1.^2);
end;
yy=1/m*y*yy;


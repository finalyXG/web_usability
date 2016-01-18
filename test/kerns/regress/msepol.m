function[hmin,gmin,hhmse,fmse]=msepol(x,y,p,n,k,mm,C);
%MSEPOL  Mean Square Error for polynomial regression function
%
%[hmin,acvmin]=msepol(x,y,f,n,k,m,C) 
%       hmin ..... estimated value of optimal bandwidth
%       acvmin ... the value of error function in hmin
%       [x,y] .... data set
%        f ....... polynomial, regression function
%       [n,k] .... order of used kernel
%        m ....... the smoothness of used kernel
%        C ....... figure handle for the MSE error function plot (optional: default=[]=no plot)
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

fy=polyval(p,x);
sigma=var(y-fy);
m=length(x);
[K,bp,delta,V]=jadro(n,k,mm);A=V*sigma;
fpom=p;
for i=1:k
   fpom=polyder(fpom);
end;
fkder=polyval(fpom,x);
bp1=mean(fkder.^2);
B=bp^2*bp1;

h=k/m:.01:k/14+.3;
hhmse=h;
fmse=A./(m*h)+(h.^(2*k)*B)/(prod(1:k)^2);
%A,prod(1:k)^2,2*k*m*B
hmin=((A*(prod(1:k)^2)/(2*k*m*B))^(1/(2*k+1)));
hmin(hmin<h(1))=h(1);
hmin(hmin>h(end))=h(end);
gmin=A/(m*hmin)+(hmin^(2*k)*B)/(prod(1:k)^2);
%cwd = pwd;
%cd(tempdir);
%pack
%cd(cwd)

if nargin==7
   figure(C);
plot(h,fmse,'r',hmin,gmin,'o');
xlabel('h');
ylabel('MSE');
title('Mean Square Error function');
end;
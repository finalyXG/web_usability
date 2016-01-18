function[hmin,gmin,hhmse,fmse]=mse(x,y,f,prom,n,k,mm,C);
%MSE  Mean Square Error
%
%[hmin,acvmin]=mse(x,y,f,prom,n,k,m,C) 
%       hmin ..... estimated value of optimal bandwidth
%       acvmin ... the value of error function in hmin
%       [x,y] .... data set
%        f ....... string, regression function
%        prom .... string, variable of regression function
%       [n,k] .... order of used kernel
%        m ....... the smoothness of used kernel
%        C ....... figure handle for the MSE error function plot (optional: default=[]=no plot)
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

assignin('base',prom,x);
fy=evalin('base',vectorize(f));
sigma=var(y-fy);
f(f=='.')=[];
m=length(x)  ;
[K,bp,delta,V]=jadro(n,k,mm);A=V*sigma;
prom=sym(prom);
fkder=diff(f,k,prom);
bp1=double(int(fkder^2,0,1));
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

if nargin==8
   figure(C);
plot(h,fmse,'r',hmin,gmin,'o');
xlabel('h');
ylabel('MSE');
title('Mean Square Error function');
end;
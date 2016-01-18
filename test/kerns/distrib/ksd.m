function[f,x]=ksd(Xi,ny,k,mi,h,xx,C)
%   [F,XI]=KSD(X) computes a probability density estimate of the sample
%   in the vector X.  F is the vector of density values evaluated at the
%   points in XI.  The estimate is based on a normal kernel function, using a
%   window parameter (bandwidth) that is a function of the number of points
%   in X.  The density is evaluated at 100 equally-spaced points covering
%   the range of the data in X.

Xi=Xi(:)';
n=length(Xi);
K=jadro(ny,k,mi);
Ximin=min(Xi);
Ximax=max(Xi);
if nargin<6
    x=linspace(Ximin,Ximax);%-2*h+2*h
else
    x=xx(:)';
end;
m=length(x);

x_x=x'*ones(1,n)-ones(m,1)*Xi;
yy=[abs(x_x/h)<1-1e-8].*polyval(K,x_x/h)/h;
%size(yy)
f=sum(yy')/n;

if nargin==7
    figure(C);
    plot(x,f);
end;

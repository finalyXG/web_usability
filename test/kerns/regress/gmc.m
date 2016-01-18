function[SS,yy]=gm(x,y,n,k,mm,h,C);
%GMC  Gasser - Mueller estimator for cyclic model
%
%[S,yy]=gmc(x,y,n,k,m,h,C) 
%        S ...... smoothing matrix
%        yy ..... values of estimated curve
%       [x,y] ... data set
%       [n,k] ... order of used kernel
%        m ...... the smoothness of used kernel
%        h ...... bandwidth
%        C ...... figure handle for the error function plot (optional: default=[]=no plot)
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

x=x(:)';y=y(:)';
m=length(x);
K=jadro(n,k,mm);

[x,ind]=sort(x); 
y=y(ind);

xt=(-m:2*m-1)/(m);
yt=[y,y,y];
mt=length(xt);
s=[zeros(1,mt),1];
s(2:mt)=(xt(2:mt)+xt(1:mt-1))/2;

if nargin>=6       
  krit=max(abs(x(2:m)-x(1:m-1)));
  
s1=s(1:mt)'*ones(1,m)-ones(mt,1)*x;
s2=s(2:mt+1)'*ones(1,m)-ones(mt,1)*x;
x_x=xt'*ones(1,m)-ones(mt,1)*x;
yy=[abs(x_x/h)<1-1e-8].*mypolyint(K,s1/h,s2/h);

SS=yy/(h^n);
yy=yt*yy/h^n;         
SS=SS(1:m,:)+SS(m+1:2*m,:)+SS(2*m+1:end,:);
end;
if krit>h
   SS=[];
   disp(['For h=',num2str(h),' smoothing matrix does not exist !']);
end;

if nargin==7
   figure(C);
plot(x,y,'x');
hold on;axis(axis);
plot(x,yy,'m');
hold off;
title(['The Gasser-Mueller estimate for cyclic model with kernel of order (',num2str(n),...
    ', ',num2str(k),'), smoothness ',num2str(mm-1),' and h = ',num2str(h)]);end;

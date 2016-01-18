function[SS,yy]=pchc(x,y,n,k,mm,h,C);
%PCHC  Pristley - Chao estimator for cyclic model
%
%[S,yy]=pchc(x,y,n,k,m,h,C) 
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
K=jadro(n,k,mm);

if nargin>=6       
T=length(x);
xt=(-T:2*T-1)/(T);
yt=[y,y,y];

krit=max(abs(x(2:T)-x(1:T-1)));
kritm=min(abs(x(2:T)-x(1:T-1)));
if abs(krit-kritm)>1e-6
   error('Data are not equidistant!');
end;

if h>=1 h=.9999; end;

v=(xt'*ones(1,T)-ones(3*T,1)*x)/h;
v=[abs(v)<=1-1e-8].*polyval(K,v)/(T*h);

yy=v;

SS=yy;
SS=SS(1:T,:)+SS(T+1:2*T,:)+SS(2*T+1:end,:);
yy=yt*yy;         
end;
if krit>h
   SS=[];
   disp(['For h=',num2str(h),' smoothing matrix does not exist !']);
end;

if nargin==7
   figure(C);
plot(x,y,'x');
hold on;axis(axis);
plot(x,yy,'c');hold off;
title(['The Pristley-Chao estimate for cyclic model with kernel of order (',num2str(n),...
    ', ',num2str(k),'), smoothness ',num2str(mm-1),' and h = ',num2str(h)]);
end;

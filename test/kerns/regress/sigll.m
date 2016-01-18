function[hmin,rssmin,hh,chcv]=sigll(x,y,nn,k,m,C);
%SIGLL  estimation of optimal bandwidth for local - linear estimator
%       by using Mallows method
%
%[hmin,acvmin]=sigll(x,y,n,k,m,C) 
%       hmin ..... estimated value of optimal bandwidth
%       acvmin ... the value of error function in hmin
%       [x,y] .... data set
%       [n,k] .... order of used kernel
%        m ....... the smoothness of used kernel
%        C ....... figure handle for the error function plot (optional: default=[]=no plot)
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

x=x(:)';y=y(:)';
chcv=[];hh=[];mRSSLL=[];
K=jadro(nn,k,m);
n=length(y);
yres=y(2:n)-y(1:n-1);
sigodh=yres(:)'*yres(:)/(2*n-2); %odhad sigma^2

h=k/n;v5colset;hm=h;
wai=waitbar(0,['Computing optimal h for kernel of order (',num2str(nn),',',num2str(k),') ...']);
hx=k/14+.3;
while h<hx
SLL=ll(x,y,nn,k,m,h);
if ~isempty(SLL)
RSSLL=(y-y*SLL)*(y-y*SLL)'/n; %klasicka RSS pro LL
mRSSLL1=RSSLL-sigodh+2*sigodh*SLL(1,1); %modifikovana RSS pro LL
mRSSLL=[mRSSLL,mRSSLL1];
end;
hh=[hh,h];
h=h+0.01;waitbar((h-hm)/(hx-hm));
end;
close(wai);%v4colset;
[rssmin,l]=min(mRSSLL);
hmin=hh(l);
chcv=mRSSLL;
if nargin==7
   figure(C);
%   plot(hh,mRSSLL,'--');hold on;
   plot(hh,chcv,'r');
   xlabel('h');
   ylabel('MRSS');
   title('Mallows error function for LL estimator');
end;


function[hmin,rssmin,hh,chcv]=sigpch(x,y,nn,k,m,C);
%SIGPCH  estimation of optimal bandwidth for Pristley - Chao estimator
%        by using Mallows method
%
%[hmin,acvmin]=sigpch(x,y,n,k,m,C) 
%       hmin ..... estimated value of optimal bandwidth
%       acvmin ... the value of error function in hmin
%       [x,y] .... data set
%       [n,k] .... order of used kernel
%        m ....... the smoothness of used kernel
%        C ....... figure handle for the error function plot (optional: default=[]=no plot)
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

x=x(:)';y=y(:)';
chcv=[];hh=[];mRSSPCH=[];
K=jadro(nn,k,m);
n=length(y);
yres=y(2:n)-y(1:n-1);
sigodh=yres(:)'*yres(:)/(2*n-2); %odhad sigma^2

h=k/n;v5colset;hm=h;
wai=waitbar(0,['Computing optimal h for kernel of order (',num2str(nn),',',num2str(k),') ...']);
hx=k/14+.3;
while h<hx
SPCH=pch(x,y,nn,k,m,h);
if ~isempty(SPCH)
RSSPCH=(y-y*SPCH)*(y-y*SPCH)'/n; %klasicka RSS pro PCH
mRSSPCH1=RSSPCH-sigodh+2*sigodh*SPCH(1,1); %modifikovana RSS pro PCH
mRSSPCH=[mRSSPCH,mRSSPCH1];
end;
hh=[hh,h];
h=h+0.01;waitbar((h-hm)/(hx-hm));
end;
close(wai);%%%%v4colset;
[rssmin,l]=min(mRSSPCH);
hmin=hh(l);
chcv=mRSSPCH;
if nargin==7
   figure(C);
%   plot(hh,mRSSPCH,'--');hold on;
   plot(hh,chcv,'r');
   xlabel('h');
   ylabel('MRSS');
   title('Mallows error function for PCH estimator');
end;


function[hmin,rssmin,hh,chcv]=signw(x,y,nn,k,m,C);
%SIGNW  estimation of optimal bandwidth for Nadaraya - Watson estimator
%       by using Mallows method
%
%[hmin,acvmin]=signw(x,y,n,k,m,C) 
%       hmin ..... estimated value of optimal bandwidth
%       acvmin ... the value of error function in hmin
%       [x,y] .... data set
%       [n,k] .... order of used kernel
%        m ....... the smoothness of used kernel
%        C ....... figure handle for the error function plot (optional: default=[]=no plot)
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

x=x(:)';y=y(:)';
chcv=[];hh=[];mRSSNW=[];
K=jadro(nn,k,m);
n=length(y);
yres=y(2:n)-y(1:n-1);
sigodh=yres(:)'*yres(:)/(2*n-2); %odhad sigma^2

h=k/n;v5colset;hm=h;
wai=waitbar(0,['Computing optimal h for kernel of order (',num2str(nn),',',num2str(k),') ...']);
hx=k/14+.3;
while h<hx
SNW=nw(x,y,nn,k,m,h);
if ~isempty(SNW)
RSSNW=(y-y*SNW)*(y-y*SNW)'/n; %klasicka RSS pro NW
mRSSNW1=RSSNW-sigodh+2*sigodh*SNW(1,1); %modifikovana RSS pro NW
mRSSNW=[mRSSNW,mRSSNW1];
end;
hh=[hh,h];
h=h+0.01/3.2;waitbar((h-hm)/(hx-hm));
end;
close(wai);%v4colset;
[rssmin,l]=min(mRSSNW);
hmin=hh(l);
chcv=mRSSNW;
if nargin==6
   figure(C);
%   plot(hh,mRSSNW,'--');hold on;
   plot(hh,chcv,'r');
   xlabel('h');
   ylabel('MRSS');
   title('Mallows error function for NW estimator');
end;

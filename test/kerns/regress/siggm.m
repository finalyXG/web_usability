function[hmin,rssmin,hh,chcv]=siggm(x,y,nn,k,m,C);
%SIGGM  estimation of optimal bandwidth for Gasser - Mueller estimator
%       by using Mallows method
%
%[hmin,acvmin]=siggm(x,y,n,k,m,C) 
%       hmin ..... estimated value of optimal bandwidth
%       acvmin ... the value of error function in hmin
%       [x,y] .... data set
%       [n,k] .... order of used kernel
%        m ....... the smoothness of used kernel
%        C ....... figure handle for the error function plot (optional: default=[]=no plot)
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

x=x(:)';y=y(:)';
chcv=[];hh=[];mRSSGM=[];
K=jadro(nn,k,m);
n=length(y);
yres=y(2:n)-y(1:n-1);
sigodh=yres(:)'*yres(:)/(2*n-2); %odhad sigma^2

h=k/n;v5colset;hm=h;
wai=waitbar(0,['Computing optimal h for kernel of order (',num2str(nn),',',num2str(k),') ...']);
hx=k/14+.3;
while h<hx
SGM=gm(x,y,nn,k,m,h);
if ~isempty(SGM)
RSSGM=(y-y*SGM)*(y-y*SGM)'/n; %klasicka RSS pro GM
mRSSGM1=RSSGM-sigodh+2*sigodh*SGM(1,1); %modifikovana RSS pro GM
mRSSGM=[mRSSGM,mRSSGM1];
end;
hh=[hh,h];
h=h+0.01;waitbar((h-hm)/(hx-hm));
end;
close(wai);%v4colset;
[rssmin,l]=min(mRSSGM);
hmin=hh(l);
chcv=mRSSGM;
if nargin==7
   figure(C);
%   plot(hh,mRSSGM,'--');hold on;
   plot(hh,chcv,'r');
   xlabel('h');
   ylabel('MRSS');
   title('Mallows error function for GM estimator');
end;


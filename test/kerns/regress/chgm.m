function[hmin,rssmin,hh,chcv]=chgm(x,y,nn,k,m,c,C);
%CHGM   estimation of optimal bandwidth of Gasser - Mueller estimator
%       by using Fourier transformation
%
%[hmin,acvmin]=chgm(x,y,n,k,m,c,C) 
%       hmin ..... estimated value of optimal bandwidth
%       acvmin ... the value of error function in hmin
%       [x,y] .... data set
%       [n,k] .... order of used kernel
%        m ....... the smoothness of used kernel
%        c ....... constant, sets a treshold (optional: default=2)
%        C ....... figure handle for the error function plot (optional: default=[]=no plot)
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

if nargin<=5
   c=2;
end;

x=x(:)';y=y(:)';
chcv=[];hh=[];mRSSGM=[];mRSSFGM=[];
K=jadro(nn,k,m);
n=length(y);ind=round((n-1)/2);
yres=y(2:n)-y(1:n-1);
sigodh=yres(:)'*yres(:)/(2*n-2); %odhad sigma^2

yf=abs(fft(y)).^2/(2*pi*n);
yf(1)=[];yf=yf(1:ind);

J=find(yf<c*sigodh/(2*pi));J=J(1);
yfnew=yf;yfnew(J:end)=sigodh/(2*pi);
h=k/n;v5colset;hm=h;
wai=waitbar(0,['Computing optimal h for kernel of order (',num2str(nn),',',num2str(k),') ...']);
hx=k/14+.3;
while h<hx
[SGM]=gmc(x,y,nn,k,m,h);trS=trace(SGM);
if ~isempty(SGM)
RSSGM=(y-y*SGM)*(y-y*SGM)'/n; %klasicka RSS pro GM
mRSSGM1=RSSGM-sigodh+2*sigodh*SGM(1,1); %modifikovana RSS pro GM
mRSSGM=[mRSSGM,mRSSGM1];
%%%mRSSGM(l)=RSSGM(l)/(1-2*trS/n); %modifikovana "fourierovska" RSS pro GM
wgm=SGM(1,:);
wfgm=(fft(wgm));wfgm(1)=[];wfgm=wfgm(1:ind);
RSSFGM=4*pi*yfnew*(abs(1-wfgm).^2)'/n; %"fourierovska" RSS pro GM
%mRSSFGM1=RSSFGM-sigodh+2*sigodh*SGM(1,1); %modifikovana "fourierovska" RSS pro GM
mRSSFGM1=RSSFGM/(1-2*trS/n); %modifikovana "fourierovska" RSS pro GM
mRSSFGM=[mRSSFGM,mRSSFGM1];
end;
hh=[hh,h];
h=h+0.01;waitbar((h-hm)/(hx-hm));
end;
close(wai);%v4colset;
[rssmin,l]=min(mRSSFGM);
hmin=hh(l);
chcv=mRSSFGM;
if nargin==7
   figure(C);
%   plot(hh,mRSSGM,'--');hold on;
   plot(hh,chcv,'r');
   xlabel('h');
   ylabel('MRSS');
   title('Modified RSS for GM estimator');
end;


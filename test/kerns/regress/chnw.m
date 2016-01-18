function[hmin,rssmin,hh,chcv]=chnw(x,y,nn,k,m,c,C)
%CHNW   estimation of optimal bandwidth of Nadaraya - Watson estimator
%       by using Fourier transformation
%
%[hmin,acvmin]=chnw(x,y,n,k,m,c,C) 
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
chcv=[];hh=[];mRSSNW=[];mRSSFNW=[];
K=jadro(nn,k,m);
n=length(y);ind=round((n-1)/2);
yres=y(2:n)-y(1:n-1);
sigodh=yres(:)'*yres(:)/(2*n-2); %odhad sigma^2

yf=abs(fft(y)).^2/(2*pi*n);
yf(1)=[];yf=yf(1:ind);
%%%%%%%%%%%%%%
%%yf(2)=.16
%%plot(2:ind,yf(2:ind),'o');
%%for i=2:ind
%   line([i,i],[0,yf(i)]);
%%end;
%%line([0,ind],[c*sigodh/(2*pi),c*sigodh/(2*pi)])
%%%%%%%%%%%%%%%%%

J=find(yf<c*sigodh/(2*pi));
if length(J)>1
    J=J(1);
end
yfnew=yf;yfnew(J:end)=sigodh/(2*pi);
h=k/n;v5colset;hm=h;
wai=waitbar(0,['Computing optimal h for kernel of order (',num2str(nn),',',num2str(k),') ...']);
hx=k/14+.3;
while h<hx
[SNW]=nwc(x,y,nn,k,m,h);trS=trace(SNW);
if ~isempty(SNW)
RSSNW=(y-y*SNW)*(y-y*SNW)'/n; %klasicka RSS pro NW
mRSSNW1=RSSNW-sigodh+2*sigodh*SNW(1,1); %modifikovana RSS pro NW
mRSSNW=[mRSSNW,mRSSNW1];
%%%mRSSNW(l)=RSSNW(l)/(1-2*trS/n); %modifikovana "fourierovska" RSS pro NW
wnw=SNW(1,:);
wfnw=(fft(wnw));wfnw(1)=[];wfnw=wfnw(1:ind);
RSSFNW=4*pi*yfnew*(abs(1-wfnw).^2)'/n; %"fourierovska" RSS pro NW
mRSSFNW1=RSSFNW-sigodh+2*sigodh*SNW(1,1); %modifikovana "fourierovska" RSS pro NW
%mRSSFNW1=RSSFNW/(1-2*trS/n); %modifikovana "fourierovska" RSS pro NW
mRSSFNW=[mRSSFNW,mRSSFNW1];
end;
hh=[hh,h];
h=h+0.01/3.2;waitbar((h-hm)/(hx-hm));
end;
close(wai);%v4colset;
[rssmin,l]=min(mRSSFNW);
hmin=hh(l);
chcv=mRSSFNW;
if nargin==7
   figure(C);
   plot(hh,chcv,'r');
   xlabel('h');
   ylabel('MRSS');
   title('Modified RSS for NW estimator');
end;

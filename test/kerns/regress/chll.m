function[hmin,rssmin,hh,chcv]=chll(x,y,nn,k,m,c,C);
%CHLL   estimation of optimal bandwidth of local - linear estimator
%       by using Fourier transformation
%
%[hmin,acvmin]=chll(x,y,n,k,m,c,C) 
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
chcv=[];hh=[];mRSSLL=[];mRSSFLL=[];
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
[SLL]=llc(x,y,nn,k,m,h);trS=trace(SLL);
if ~isempty(SLL)
RSSLL=(y-y*SLL)*(y-y*SLL)'/n; %klasicka RSS pro LL
mRSSLL1=RSSLL-sigodh+2*sigodh*SLL(1,1); %modifikovana RSS pro LL
mRSSLL=[mRSSLL,mRSSLL1];
%%%mRSSLL(l)=RSSLL(l)/(1-2*trS/n); %modifikovana "fourierovska" RSS pro LL
wll=SLL(1,:);
wfll=(fft(wll));wfll(1)=[];wfll=wfll(1:ind);
RSSFLL=4*pi*yfnew*(abs(1-wfll).^2)'/n; %"fourierovska" RSS pro LL
%mRSSFLL1=RSSFLL-sigodh+2*sigodh*SLL(1,1); %modifikovana "fourierovska" RSS pro LL
mRSSFLL1=RSSFLL/(1-2*trS/n); %modifikovana "fourierovska" RSS pro LL
mRSSFLL=[mRSSFLL,mRSSFLL1];
end;
hh=[hh,h];
h=h+0.01;waitbar((h-hm)/(hx-hm));
end;
close(wai);%v4colset;
[rssmin,l]=min(mRSSFLL);
hmin=hh(l);
chcv=mRSSFLL;
if nargin==7
   figure(C);
   plot(hh,chcv,'r');
   xlabel('h');
   ylabel('MRSS');
   title('Modified RSS for LL estimator');
end;

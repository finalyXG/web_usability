function[hmin,rssmin,hh,chcv]=chpch(x,y,nn,k,m,c,C);
%CHPCH   estimation of optimal bandwidth of Pristley - Chao estimator
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
chcv=[];hh=[];mRSSPCH=[];mRSSFPCH=[];%RSSFPCH1=[];
K=jadro(nn,k,m);
n=length(y);ind=round((n-1)/2);
yres=y(2:n)-y(1:n-1);
sigodh=yres(:)'*yres(:)/(2*n-2); %odhad sigma^2

yf=abs(fft(y)).^2/(2*pi*n);
yf(1)=[];yf=yf(1:ind);

J=find(yf<c*sigodh/(2*pi));J=J(1);
yfnew=yf;yfnew(J:end)=sigodh/(2*pi);
%yfnew=yf;
h=k/n;v5colset;hm=h;
wai=waitbar(0,['Computing optimal h for kernel of order (',num2str(nn),',',num2str(k),') ...']);
hx=k/14+.3;
while h<hx
[SPCH]=pchc(x,y,nn,k,m,h);trS=trace(SPCH);
if ~isempty(SPCH)
RSSPCH=(y-y*SPCH)*(y-y*SPCH)'/n; %klasicka RSS pro PCH
mRSSPCH1=RSSPCH-sigodh+2*sigodh*SPCH(1,1); %modifikovana RSS pro PCH
mRSSPCH=[mRSSPCH,mRSSPCH1];
%%%mRSSPCH(l)=RSSPCH(l)/(1-2*trS/n); %modifikovana "fourierovska" RSS pro PCH
wpch=SPCH(1,:);
wfpch=(fft(wpch));wfpch(1)=[];wfpch=wfpch(1:ind);
RSSFPCH=4*pi*yfnew*(abs(1-wfpch).^2)'/n; %"fourierovska" RSS pro PCH
mRSSFPCH1=RSSFPCH-sigodh+2*sigodh*SPCH(1,1); %modifikovana "fourierovska" RSS pro PCH
%mRSSFPCH1=RSSFPCH/(1-2*trS/n); %modifikovana "fourierovska" RSS pro PCH
mRSSFPCH=[mRSSFPCH,mRSSFPCH1];
%RSSFPCH1=[RSSFPCH1,RSSFPCH];

end;
hh=[hh,h];
h=h+0.01;waitbar((h-hm)/(hx-hm));
end;
close(wai);%v4colset;
[rssmin,l]=min(mRSSFPCH);
hmin=hh(l);
chcv=mRSSFPCH;
if nargin==7
   figure(C);
   plot(hh,chcv,'r');
   xlabel('h');
   ylabel('MRSS');
   title('Modified RSS for PCH estimator');
end;


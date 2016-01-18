function [H_plcv]=plcv(XX,rad,sit)
% PLCV pseudo-likelihood cross-validation
%      for product kernels and dimension 2
%
% [H_plcv] = plcv(XX,rad,den)
% in:  XX .. data
%      rad .. order of kernel K (Epanecnik [0,2,1])
%      den .. density of net for optimalization (implicitly=100)
% out: H_plcv .. an estimate of bandwidth matrix
%
% (C) Kamila Vopatova, Jan Kolacek, Masaryk University (Czech Republic)

if nargin==1
  rad=[0,2,1];
end;

[d,n]=size(XX);
[K,beta,delta,V]=jadro(rad(1),rad(2),rad(3));

X=XX(1,:);
Y=XX(2,:);

% meze oblasti hledani optimalniho h
odxp=diff(sort(X));
odxp(odxp==0)=[];
odx=min(odxp);
dox=(max(X)-min(X))/2;
odyp=diff(sort(Y));
odyp(odyp==0)=[];
ody=min(odyp);
doy=(max(Y)-min(Y))/2;

% sit pro hledani h -> hh = hledane h
if nargin<=2
  sit=100;
end;
hh1=linspace(odx,dox,sit); 
hh2=linspace(ody,doy,sit);
[hh1,hh2]=meshgrid(hh1,hh2);

[pX1,pX2]=meshgrid(X);
X_X=pX1-pX2;
[pY1,pY2]=meshgrid(Y);
Y_Y=pY1-pY2;

% opravovaci matice -> bez diagonalnich prvku
WW=ones(n,n)-diag(ones(1,n)); 
lhh=zeros(sit);

wai=waitbar(0,['Computing the bandwidth matrix by PLCV ...']);
for k=1:sit
  for el=1:sit
    h1=hh1(k,el); 
    h2=hh2(k,el);
    KK=polyval(K,X_X./h1).*(abs(X_X./h1)<=1)...
      .*polyval(K,Y_Y./h2).*(abs(Y_Y./h2)<=1)...
      .*WW;
    cc=(sum(KK)==zeros(size(sum(KK)))); 
    % korekce pro KK=0, aby neblaznil logaritmus
    lhh(k,el)=-n*log(n-1)-n*log(h1)-n*log(h2)+sum(log(sum(KK)+cc*eps(0)));
  end;
    waitbar(k/sit,wai);
end;
close(wai);
PML=max(max(lhh));
[indi1,indi2]=find(lhh==PML);
hh=[hh1(indi1,indi2);hh2(indi1,indi2)];
H_plcv = [hh(1) 0;0 hh(2)].^2;
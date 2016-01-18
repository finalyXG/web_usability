function h2=iter_haz(h1,X,d,K);
% h2=iter_haz(h1,X,d,K);
% One iteration of iteration process

Nx=64;
Ny=32;

n=length(X);
S=max(X)+h1;
xx=linspace(0,S,Nx+1);
yy=linspace(-1,1,Ny+1);
Ky=K_val(K,yy);
xval1=[];
xval2=[];

for x=xx
 yval2=K_hafest(X,d,K,x-h1*yy,h1).*Ky;
 yval1=yval2.*Ky./(1-L_n(X,x-h1*yy));
% Romberg integration for y
 stepy=2;
 nRy=Ny;
% composed trap. rule - basic value
 CSRy1=stepy*(yval1(1)+yval1(Ny+1))/2;
 CSRy2=stepy*(yval2(1)+yval2(Ny+1))/2;
 IRy1=[CSRy1];
 IRy2=[CSRy2];
 while nRy>1
  II=[nRy/2:nRy:Ny]+1;
  stepy=stepy/2;
% composed trap. rule
  CSRy1=CSRy1/2+sum(yval1(II))*stepy;
  CSRy2=CSRy2/2+sum(yval2(II))*stepy;
  IRy1=[IRy1,CSRy1];
  IRy2=[IRy2,CSRy2];
  nRy=nRy/2;
 end
% IRy1,IRy2
 lRy=length(IRy1);
 coef=4;
 while lRy>1;
  IRy1=(coef*IRy1(2:lRy)-IRy1(1:lRy-1))/(coef-1);
  IRy2=(coef*IRy2(2:lRy)-IRy2(1:lRy-1))/(coef-1);
  coef=4*coef;
  lRy=length(IRy1);
%  pause
 end
 xval1=[xval1,IRy1];
 xval2=[xval2,IRy2];
end
lam=K_hafest(X,d,K,xx,h1);
xval2=(xval2-lam).^2;
% Romberg integration for x
stepx=S;
nRx=Nx;
% composed trap. rule - basic value
CSRx1=stepx*(xval1(1)+xval1(Nx+1))/2;
CSRx2=stepx*(xval2(1)+xval2(Nx+1))/2;
IRx1=[CSRx1];
IRx2=[CSRx2];
while nRx>1
 II=[nRx/2:nRx:Nx]+1;
 stepx=stepx/2;
% composed trap. rule
 CSRx1=CSRx1/2+sum(xval1(II))*stepx;
 CSRx2=CSRx2/2+sum(xval2(II))*stepx;
 IRx1=[IRx1,CSRx1];
 IRx2=[IRx2,CSRx2];
 nRx=nRx/2;
end
lRx=length(IRx1);
coef=4;
while lRx>1;
 IRx1=(coef*IRx1(2:lRx)-IRx1(1:lRx-1))/(coef-1);
 IRx2=(coef*IRx2(2:lRx)-IRx2(1:lRx-1))/(coef-1);
 coef=4*coef;
 lRx=length(IRx1);
end
h2=IRx1/(IRx2*2*n*K.k);

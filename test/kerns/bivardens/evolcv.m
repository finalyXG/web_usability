function[H,hod,hodnota]=evolcv(r,X,nn)
% EVOLCV finds a minimum of LSCV (for kernel density and its first derivative) by evolution algorithm
%
% [H,val]=evolcv(r,X,n)
% r ... 0 for kernel density
%       1 for kernel density first derivative
% X ... the matrix of observations
% n ... number of grid points
%
% H ..... 'optimal' bandwidth matrix
% val ... value of LSCV at H
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

[d,n]=size(X);

if d>=n
    error('dimenze je vetsi nez pocet pozorovani!')
end
if (r~=0)&&(r~=1)
    error('r should be 0 or 1!')
end

RandStream.setGlobalStream(RandStream('mt19937ar','seed',sum(100*clock)));

sigma=cov(X');

roz=diag(sigma)';

Miny=-sqrt(roz);
Maxy=sqrt(roz);
rozpeti=[min(Miny,[],1);max(Maxy,[],1)];
rozpeti=sign(rozpeti).*sqrt(abs(rozpeti));

vechH=zeros(d,d,nn);
met=1;
for i=1:d
    for j=i:d
        vechH(j,i,:)=rozpeti(1)+rand(1,nn)*(rozpeti(2)-rozpeti(1));
    end
end

if nargin<8
    epsil=0.05;
end
fin=find(vechH(:,:,1));
wai=waitbar(0,'Computing the bandwidth matrix by LSCV ...');
for i=1:nn
    H=vechH(:,:,i);
    H=H'*H;
    x(:,i)=H(~~tril(H));
%    HH(:,:,i)=H;
    fxy1(i)=cv(r,X,H,met);
    waitbar(i/nn,wai);    
end

fxy=fxy1;
fxyN=fxy1;

hodnota=min(fxyN);
zz=1;
poc=round(nn/(2*zz));
hod=hodnota;

while (hod>epsil)&&(poc>2)
    zz=zz+1;
    [hod,ind]=min(fxy);
    [fsor,indexy]=sort(fxy);
    fsorN=sort(fxyN);
    xpul=[x(:,indexy(2)),x(:,indexy(2:poc))];
    x_opt=x(:,ind);
    
    w1=rand(poc,2);
    w1=w1./(ones(2,1)*sum(w1,2)')';
    for ii=2:poc
        xnew(:,ii)=[x_opt,xpul(:,ii)]*w1(ii,:)';
    end
    xpul(:,1)=x_opt;
    x=[xpul,xnew];
    fxynew1=[];
    for l=1:poc
        H(:)=0;
        H(fin)=xnew(:,l);
        H=H+tril(H,-1)';
        fxynew1(l)=cv(r,X,H,met);
    end
    fxynew=fxynew1;
    fxy=[fsor(1:poc),fxynew];
    fxyN=[fsorN(1:poc),fxynew1];
    hodnota=min(fxyN);
    poc=round(nn/(2*zz));
end
close(wai);
[hod,ind]=min(fxy);

opt_est=x(:,ind);
H(:)=0;
H(fin)=opt_est;
H=H+tril(H,-1)';


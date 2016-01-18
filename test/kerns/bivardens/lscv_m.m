function[h,y,lsmin]=lscv_m(Xi,ny,k,mi,CC)
% LSCV_M Least-square cross-validation for diagonal matrix,
%         product kernels and dimension 2
%
% H=lscv_m(X,nu,k,mi,fig)
% finds diagonal bandwidth matrix H, which minimizes the LSCV
% X............ matrix of observations
% nu,k,mi ..... order of product kernel ([0,2,1] = Epanechnik)
% fig ......... specifies number of figure (only for dimension 2)
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

[dim,n]=size(Xi);
[K,beta,delta,V]=jadro(ny,k,mi);
K0=polyval(K,0);

if dim~=2
    error('Wrong dimension!');
end

H=wand(Xi);
h1w=H(1,1).^(1/2);  %%%%%%%%%%%%%%%
h2w=H(2,2).^(1/2);
gr=30;
h1=linspace(h1w/4,4*h1w,gr);
h2=linspace(h2w/4,4*h2w,gr);
[hh1,hh2]=meshgrid(h1,h2);

X1=Xi(1,:);
X2=Xi(2,:);
[XX1,YY1]=meshgrid(X1,X1);
[XX2,YY2]=meshgrid(X2,X2);

if exist('konvy.mat')
    load('konvy.mat');
else
    [C,supp_C]=kernconv(ny,k,mi,2,'jirka');
    [D,supp_D]=kernconv(ny,k,mi,3,'jirka');
    [E,supp_E]=kernconv(ny,k,mi,4,'jirka');
    save('konvy.mat','C','supp_C','D','supp_D','E','supp_E');
end

delka_C=supp_C(:,2)-supp_C(:,1);
stred_C=(supp_C(:,2)+supp_C(:,1))/2;

wai=waitbar(0,'Computing the bandwidth matrix by LSCV ...');
for i=1:gr
    for j=1:gr
        h1=hh1(i,j);
        h2=hh2(i,j);
        d1=(YY1-XX1)/h1;
        d2=(YY2-XX2)/h2;

C1=polyval(C(1,:),d1).*(abs(d1-stred_C(1))<=delka_C(1)/2)+polyval(C(2,:),d1).*(abs(d1-stred_C(2))<=delka_C(2)/2);
C1=C1-diag(diag(C1))/2;  
K1=polyval(K,d1).*(abs(d1)<=1);
C2=polyval(C(1,:),d2).*(abs(d2-stred_C(1))<=delka_C(1)/2)+polyval(C(2,:),d2).*(abs(d2-stred_C(2))<=delka_C(2)/2);
C2=C2-diag(diag(C2))/2;  
K2=polyval(K,d2).*(abs(d2)<=1);

y(i,j)=sum(sum(C1.*C2-2*K1.*K2))/(n^2*h1*h2)+2*K0^2/(n*h1*h2);
    end
    waitbar(i/gr,wai);
end
close(wai);

lsmin=min(min(y));
[ind_r,ind_s]=find(y==lsmin);
h=[hh1(ind_r,ind_s) 0;0 hh2(ind_r,ind_s)].^2;   %??

if nargin==5
    figure(CC);
    mesh(hh1,hh2,y);
    hold on;
    plot3(hh1(ind_r,ind_s),hh2(ind_r,ind_s),lsmin,'r*');
end




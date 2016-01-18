function[z,Z,V,beta,sympol]=productkern(ny,k,mi,X,C)
% PRODUCTKERN multidimensional product kernel
%
% val=productkern(nu,k,mi,X,fig)
%
% [nu,k] .... order of kernel
% mi ......., the smoothness of kernel
% X ... the matrix of input points
% fig ... specify number of figure (only for dimension 2)
% val ... values of product kernel at X
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

[K,beta,delta,V]=jadro(ny,k,mi);
[dim,n]=size(X);
V=V^dim;
z=prod((polyval(K,X)).*(abs(X)<1));
Z=[];
sympol1=poly2sym(K);
sympol2=poly2sym(K,'y');
sympol=sympol1*sympol2;
if (dim==2)
    x=X(1,:);
    y=X(2,:);
    [X,Y]=meshgrid(x,y);
    Z=polyval(K,X).*(abs(X)<1).*polyval(K,Y).*(abs(Y)<1);
    if (nargin==5)
        mesh(X,Y,Z);figure;
        contour(X,Y,Z);
    end
end;
function[z,Z,V,beta]=gausskern(XX,C)
% GAUSSKERN multidimensional Gaussian kernel
%
% val=gausskern(X,fig)
%
% X ... the matrix of input points
% fig ... specify number of figure (only for dimension 2)
% val ... values of Gaussian kernel at X
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

V=0.0796;
beta=1;
[dim,n]=size(XX);
z=(2*pi)^(-dim/2)*exp(-0.5*diag(XX'*XX)');
Z=[];

if (dim==2)
  K='(2*pi)^(-dim/2)*exp(-1/2*(x.^2+y.^2))';
    X=XX(1,:);
    Y=XX(2,:);
    [x,y]=meshgrid(X,Y);
    Z=eval(K);
    if (nargin==2)
        figure(C);
        mesh(x,y,Z);figure(C+1);
        contour(x,y,Z);
    end
end;
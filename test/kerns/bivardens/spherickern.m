function[z,Z,V,beta,const]=spherickern(ny,k,mi,X,C)
% SPHERICKERN multidimensional spheric kernel
%
% val=spherickern(nu,k,mi,X,fig)
%
% [nu,k] .... order of kernel
% mi ......., the smoothness of kernel
% X ... the matrix of input points
% fig ... specify number of figure (only for dimension 2)
% val ... values of spheric kernel at X
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

K=jadro(ny,k,mi);
[dim,n]=size(X);
Z=[];
if dim==2
    pol=poly2sym(K,'t');
    new=subs(pol,'t','sqrt(x^2+y^2)');
    new=subs(new,{'x','y'},{'ro*cos(phi)','ro*sin(phi)'});
    if (ny==0)&&(k==2)&&(mi==0)
    new=sym(1/2);
    end;
    new=sym(['(',char(new),')*ro']);
    const=int(int(new,'ro',0,1),'phi',0,2*pi);
    const=double(const);
    if nargout>=3
    pol=poly2sym(conv(K,K),'t');
    new=subs(pol,'t','sqrt(x^2+y^2)');
    new=subs(new,{'x','y'},{'ro*cos(phi)','ro*sin(phi)'});
    if (ny==0)&&(k==2)&&(mi==0)
    new=sym(1/4);
    end;
    new=sym(['(',char(new),')*ro']);
    V=int(int(new,'ro',0,1),'phi',0,2*pi);
    V=double(V);
    end
    if nargout>=4
    pol=poly2sym(K,'t');
    new=subs(pol,'t','sqrt(x^2+y^2)');
    new=subs(new,{'x','y'},{'ro*cos(phi)','ro*sin(phi)'});
    if (ny==0)&&(k==2)&&(mi==0)
    new=sym(1/2);
    end;
    new=sym(['(',char(new),')*ro^3*cos(phi)^2']);
    beta=int(int(new,'ro',0,1),'phi',0,2*pi);
    beta=double(beta);
    end
else
    const=1; %pro vyssi dimenze neumime spocitat?!
end;
z=1/const*polyval(K,sqrt(sum(X.^2))).*(abs(sqrt(sum(X.^2)))<=1);

if dim==2
    x=X(1,:);
    y=X(2,:);
    [X,Y]=meshgrid(x,y);
    Z=1/const*polyval(K,sqrt(X.^2+Y.^2)).*(abs(sqrt(X.^2+Y.^2))<=1);
    if (nargin==5)
        mesh(X,Y,Z);figure;
        contour(X,Y,Z);
    end
end;
function[H]=amiseopt2(ny,k,m,styl,n,a,b,C,fig)

%H=amiseopt2(ny,k,m,style,n,a,b,f,fig)
%
%Computes AMISE optimal diagonal matrix H for dimension 2
%ny,k,m.... order of kernel
%style......type of kernel : 'sphe'....spherical
%                       'prod'....prod
%                       'gaus'....Gaussian
%n......... number of observations
%a......... 2x1 vector of minimal limits of support of f
%b......... 2x1 vector of maximal limits of support of f
%f......... string of density OR 
%           covariance matrix (supp. regular and diagonal) for normal
%           density
% (C) Jan Kolacek, Masaryk University (Czech Republic)

x=sym('x');
y=sym('y');

if ~ischar(C)
detC=det(C);
if abs(detC)<1e-6
    error('Covariance matrix seems to be singular!');
end
C=inv(C);
c11=C(1,1);c12=C(1,2);c22=C(2,2);c21=C(2,1);

if c12~=c21
    error('Covariance matrix should be symmetric!');
end
if c12~=0
    disp('Covariance matrix should be diagonal!');
end
f=1/(2*pi*sqrt(detC))*exp(-0.5*(c11*x^2+2*c12*x*y+c22*y^2));
else
    f=C;
end
wai=waitbar(0,'Computing the AMISE optimal bandwidth matrix ...');
d40=diff(f,4,x);
waitbar(1/6,wai);
d04=diff(f,4,y);
waitbar(2/6,wai);
d22=diff(diff(f,2,x),2,y);
waitbar(3/6,wai);
% new40=subs(f*d40,{'x','y'},{'ro*cos(phi)','ro*sin(phi)'});
% new40=sym(['(',char(new40),')*ro']);
% new04=subs(f*d04,{'x','y'},{'ro*cos(phi)','ro*sin(phi)'});
% new04=sym(['(',char(new04),')*ro']);
% new22=subs(f*d22,{'x','y'},{'ro*cos(phi)','ro*sin(phi)'});
% new22=sym(['(',char(new22),')*ro']);

% psi40=double(int(int(new40,'phi',0,2*pi),'ro',0,inf));
% psi04=double(int(int(new04,'phi',0,2*pi),'ro',0,inf));
% psi22=double(int(int(new22,'phi',0,2*pi),'ro',0,inf));
a1=a(1);b1=b(1);
a2=a(2);b2=b(2);
if (a1>=b1)||(a2>=b2)
    error('wrong boundaries!');
end
psi40=double(int(int(f*d40,x,a1,b1),y,a2,b2));
waitbar(4/6,wai);
psi04=double(int(int(f*d04,x,a1,b1),y,a2,b2));
waitbar(5/6,wai);
psi22=double(int(int(f*d22,x,a1,b1),y,a2,b2));
waitbar(1,wai);

switch styl
     case 'prod'
         [z,zz,V,beta]=productkern(ny,k,m,ones(2,n));
     case 'sphe'
         [z,zz,V,beta]=spherickern(ny,k,m,ones(2,n));
     case 'gaus'
         [z,zz,V,beta]=gausskern(ones(2,n));
     otherwise
         error('wrong style!');
end;
h1=real((psi04^(3/4)*V/(beta^2*psi40^(3/4)*(psi22+sqrt(psi04*psi40))*n))^(1/6));
h2=real((psi40^(3/4)*V/(beta^2*psi04^(3/4)*(psi22+sqrt(psi04*psi40))*n))^(1/6)); %!Real!!!
H=diag([h1,h2]);
H=H.^2;
close(wai);
if nargin==9
    sh1=2*h1/3;
    sh2=2*h2/3;
    x=linspace(h1-sh1,h1+sh1);
    y=linspace(h2-sh2,h2+sh2);
    [xx,yy]=meshgrid(x,y);
    amise=V./(n*xx.*yy)+beta^2/4*(psi40*xx.^4+2*psi22*xx.^2.*yy.^2+psi04*yy.^4);
    figure(fig);
    mesh(xx,yy,amise);
    title('AMISE');
    hold on;
    xx=h1;
    yy=h2;
    amise=V./(n*xx.*yy)+beta^2/4*(psi40*xx.^4+2*psi22*xx.^2.*yy.^2+psi04*yy.^4);
    plot3(h1,h2,amise,'c*');
end
% hh=steff_spec(X,0,2,1);
%     xx=hh(1,1);
%     yy=hh(2,2);
%     amise=V./(n*xx.*yy)+beta^2/4*(psi40*xx.^4+2*psi22*xx.^2.*yy.^2+psi04*yy.^4);
%     plot3(xx,yy,amise,'r*');



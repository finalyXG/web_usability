function[f,xsit,Z]=ksmultidens(Xi,ny,k,mi,h,xx,styl,C)

[dim,n]=size(Xi);
Ximin=min(Xi');
Ximax=max(Xi');
pres=100;
H5=h^(1/2);
dif=2;

if nargin<7
    styl='prod';
end
if xx==0;
    for i=1:dim
        xsit(i,:)=linspace(Ximin(i)-dif*H5(i,i),Ximax(i)+dif*H5(i,i),pres);
    end
else
    xsit=xx;
end;
m=length(xsit);
Z=zeros(m,m);
yy=zeros(1,m);
hinv=h^(-1/2);
deth=det(hinv);

[iks,yps]=meshgrid(xsit(1,:),xsit(2,:));


K='(2*pi)^(-dim/2)*exp(-1/2*(x.^2+y.^2))';
K1=jadro(ny,k,mi);
for i=1:n
    x_x=xsit-Xi(:,i)*ones(1,m);
    x=hinv(1,1)*(iks-Xi(1,i))+hinv(1,2)*(yps-Xi(2,i));
    y=hinv(2,1)*(iks-Xi(1,i))+hinv(2,2)*(yps-Xi(2,i));

    switch styl
        case 'prod'
            [z,zz,neco,neco1,K]=productkern(ny,k,mi,hinv*x_x);
           x=(hinv(1,1)*(iks-Xi(1,i))+hinv(1,2)*(yps-Xi(2,i)));
           y=(hinv(2,1)*(iks-Xi(1,i))+hinv(2,2)*(yps-Xi(2,i)));
           zz=eval(vectorize(K)).*(abs(hinv(1,1)*(iks-Xi(1,i))+hinv(1,2)*(yps-Xi(2,i)))<=1).*(abs(hinv(2,1)*(iks-Xi(1,i))+hinv(2,2)*(yps-Xi(2,i)))<=1);
        case 'sphe'
            [z,zz,neco,neco1,const]=spherickern(ny,k,mi,hinv*x_x);
            zz=1/const*polyval(K1,sqrt(x.^2+y.^2)).*(abs(sqrt(x.^2+y.^2))<=1);
        case 'gaus'
            z=gausskern(hinv*x_x);
            zz=eval(K);            
        otherwise
            error('wrong parameter!')
    end;
    Z=Z+zz*deth/n;
    yy=yy+z*deth/n;
end
f=yy;  

if (nargin==8)&&(dim==2)
    figure(C);
    mesh(iks,yps,Z);
    figure(C+1);
    contour(iks,yps,Z);hold on;
    plot(Xi(1,:),Xi(2,:),'x');
end;

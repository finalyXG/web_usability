function[f,x,Z]=ksmultidens_p(Xi,ny,k,mi,h,xx,styl,C)

[dim,n]=size(Xi);
Ximin=min(Xi');
Ximax=max(Xi');
if nargin<6
    styl='prod';
    for i=1:dim
        x(i,:)=linspace(Ximin(i),Ximax(i));
    end
else
    x=xx;
end;
m=length(x);
deth=sqrt(abs(det(h)));
%Z=zeros(m);
hinv=h^(-1/2);
for i=1:n
    x_x=x-Xi(:,i)*ones(1,m);
    switch styl
        case 'prod'
            [z,zz]=productkern(ny,k,mi,hinv*x_x);
        case 'sphe'
            [z,zz]=spherickern(ny,k,mi,hinv*x_x);
        case 'gaus'
            [z,zz]=gausskern(hinv*x_x);
    end;        
    Z(i,:)=zz'/deth;
    %%yy(i,:)=z/deth;
end
%size(yy)
%%f=sum(yy)/n;  
Z=sum(Z)/n;
Z=reshape(Z',m,m);
f=diag(Z);
if (nargin==8)&&(dim==2)
    xx=x(1,:);
    yy=x(2,:);
    [X,Y]=meshgrid(xx,yy);
    figure(C);
    mesh(X,Y,Z);
    figure(C+1);
    contour(X,Y,Z);hold on;
    plot(Xi(1,:),Xi(2,:),'x');
end;

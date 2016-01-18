function[opt_est,hod,hodnota]=izelpokus2(X,ny,k,mi,xsup,ysup,n,epsil)
% auxiliary function for KSBIVARDENS toolbox
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

a=xsup(1);
b=xsup(2);
c=ysup(1);
d=ysup(2);

RandStream.setGlobalStream(RandStream('mt19937ar','seed',sum(100*clock)));

x=(b-a)*rand(1,n)+a;
y=(d-c)*rand(1,n)+c;

if nargin<8
    epsil=0.05;
end

for l=1:n
    fxy1(l)=abs(funkce_g(X,ny,k,mi,x(l),y(l))-1);
    fxy2(l)=abs(funkce_g3(X,ny,k,mi,x(l),y(l)));
end

scale1=max(fxy1)-min(fxy1);
scale2=max(fxy2)-min(fxy2);
k1=scale2/(scale1+scale2);
k2=scale1/(scale1+scale2);
K=[k1,k2];
%   SC=[scale1,scale2];
%fxy=fxy1/scale1+fxy2/scale2;
fxy=fxy1*k1+fxy2*k2;
fxyN=fxy1+fxy2;

hodnota=min(fxyN);
zz=1;
poc=round(n/(2*zz));
hod=hodnota;
%while poc>1
while (hod>epsil)&&(poc>2)
%for i=1:repl
    zz=zz+1;
%     plot(x,y,'x'); hold on; axis([a,b,c,d]);
%     load casy
%     hodnoty1=g1;hodnoty2=g2;
%     contour(xx,yy,hodnoty1,.01,'color',[0 0 1],'linewidth',2);
%     contour(xx,yy,hodnoty2,.01,'color',[0.01 0 0],'linewidth',2);
    [hod,ind]=min(fxy);
    [fsor,indexy]=sort(fxy);
    [fsorN,iiindexy]=sort(fxyN);
%     plot(x(ind),y(ind),'r.','markersize',20);axis([a,b,c,d]);
%     plot(x(indexy(2)),y(indexy(2)),'g.','markersize',20);
%     
%     hold off;pause(1);
    xpul=[x(indexy(2)),x(indexy(2:poc))];
    ypul=[y(indexy(2)),y(indexy(2:poc))];
    x_opt=x(ind);
    y_opt=y(ind);
    
    w1=rand(poc,2);
    w1=w1./(ones(2,1)*sum(w1,2)')';
    w2=rand(poc,2);
    w2=w2./(ones(2,1)*sum(w2,2)')';
    
    xnew=diag(w1*[x_opt*ones(1,poc);xpul])';
    ynew=diag(w2*[y_opt*ones(1,poc);ypul])';

    xpul(1)=x_opt;
    ypul(1)=y_opt;
    x=[xpul,xnew];
    y=[ypul,ynew];
    fxynew1=[];fxynew2=[];
    for l=1:poc
        fxynew1(l)=abs(funkce_g(X,ny,k,mi,xnew(l),ynew(l))-1);
        fxynew2(l)=abs(funkce_g3(X,ny,k,mi,xnew(l),ynew(l)));
    end
    scale1=max(fxynew1)-min(fxynew1);
    scale2=max(fxynew2)-min(fxynew2);
    K=[K;scale2/(scale1+scale2),scale1/(scale1+scale2)];
%     SC=[SC;scale1,scale2];
%     SCy=mean(SC);
%     scale1=SCy(1);scale2=SCy(2);
    ky=mean(K);
%    fxynew=fxynew1/scale1+fxynew2/scale2;
    fxynew=fxynew1*ky(1)+fxynew2*ky(2);
    fxy=[fsor(1:poc),fxynew];
    fxyN=[fsorN(1:poc),fxynew1+fxynew2];
    hodnota=min(fxyN);%,hod
    poc=round(n/(2*zz));
end

[hod,ind]=min(fxy);

opt_est=[x(ind),y(ind)]';



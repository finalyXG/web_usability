function[H,minMISE]=sitnase(r,X,nn)
% auxiliary function for KSBIVARDENS toolbox
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

[d,n]=size(X);

if d>=n
    error('Wrong dimension!')
end
RandStream.setGlobalStream(RandStream('mt19937ar','seed',sum(100*clock)));

sx=sort(X,2);
distan=min(sx(2:end,:)-sx(1:end-1,:),2);
%mu=mean(X,2)';
sigma=cov(X');

%roz=diag(sigma)*2^(1/2);
roz=diag(sigma)';
% Miny=-sqrt(roz);
% Maxy=sqrt(roz);
% rozpeti=[Miny;Maxy];
%rozpeti=sign(rozpeti).*sqrt(abs(rozpeti));

vechH=zeros(d,d,nn);
   
for i=1:d
    for j=i:d
%        vechH(j,i,:)=rozpeti(1,i)+rand(1,nn)*(rozpeti(2,i)-rozpeti(1,i));
        vechH(i,j,:)=distan(i)*(i==j)+(2*rand(1,nn)-1)*sqrt((roz(i)-distan(i))*(roz(j)-distan(j)));
    end
end

wai=waitbar(0,'Computing the bandwidth matrix by IT ...');
for ii=1:nn
H=vechH(:,:,ii);
H=H'*H;
HH(:,:,ii)=H;
MISE(ii)=abs(nase(r,X,H));
waitbar(ii/nn,wai);    
end
[minMISE,ind]=min(MISE);
H=HH(:,:,ind);
close(wai);

% 
% else
% od1=0.02;
% do1=1;
% od2=0.02;
% do2=1;
% pp=22; %pocet 
% ha1=linspace(od1,do1,pp);
% ha2=linspace(od2,do2,pp);
% er=linspace(-0.98,0.98,pp);
% [h11,h22,rr]=ndgrid(ha1,ha2,er);
% 
% ii=1;
% for ka=1:pp
%   for el=1:pp
%     for em=1:pp
%       h1=h11(ka,el,em);
%       h2=h22(ka,el,em);
%       h12=sqrt(h1*h2)*r(ka,el,em);
%       H=[h1,h12;h12,h2];
%       HH(:,:,ii)=H;
% MISE(ii)=abs(nase(r,X,H));
% ii=ii+1;
%     end;
%   end;
% waitbar(ka/pp,wai);    
% end;
% close(wai);
% [minMISE,ind]=min(MISE);
% H=HH(:,:,ind);
% 
% end

function[H,minMISE]=sitmise(r,n,mu,sigma,w)
%SITMISE estimates a MISE optimal bandwidth matrix for normal mixture densities
%
%H=sitmise(r,n,mu,sigma,w)
%r......... 0 for density estimation, 1 for the first derivative
%n......... sample size
%mu......... matrix of means
%sigma......... array of covariance matrices
%w............ wieght vector for all terms of mixture
%
%H.........MISE optimal bandwidth matrix
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

d=size(mu,2);
w=w(:);
k=length(w);

for i=1:k
    roz(i,:)=diag(sigma(:,:,i));
end
Miny=-sqrt(roz);
Maxy=sqrt(roz);
rozpeti=[min(Miny,[],1);max(Maxy,[],1)];
rozpeti=sign(rozpeti).*sqrt(abs(rozpeti));
m=5000; %pocet bodu v siti
vechH=zeros(d,d,m);

for i=1:d
    for j=i:d
        vechH(j,i,:)=mean([rozpeti(1,i),rozpeti(1,j)])+...
            rand(1,m)*(mean([rozpeti(2,i),rozpeti(2,j)])-mean([rozpeti(1,i),rozpeti(1,j)]));        
    end
end

wai=waitbar(0,'Computing the MISE optimal bandwidth ...');
for ii=1:m
H=vechH(:,:,ii);
H=H'*H;
HH(:,:,ii)=H;
MISE(ii)=misefull(r,n,mu,sigma,w,H);
waitbar(ii/m,wai);    
end
[minMISE,ind]=min(MISE);
H=HH(:,:,ind);
close(wai);
% else
% od1=0.02;
% do1=1;
% od2=0.02;
% do2=1;
% pp=22; %pocet 
% ha1=linspace(od1,do1,pp);
% ha2=linspace(od2,do2,pp);
% er=linspace(-0.98,0.98,pp);
% [h11,h22,r]=ndgrid(ha1,ha2,er);
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
% MISE(ii)=misefull(r,n,mu,sigma,w,H);
% ii=ii+1;
%     end;
%   end;
% end;
% [minMISE,ind]=min(MISE);
% H=HH(:,:,ind);
% 
% end

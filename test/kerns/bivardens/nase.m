function[mise]=nase(r,X,H)
% auxiliary function for KSBIVARDENS toolbox
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

%hodnota=nase(X,H)
%vypocet nasi metody v matici H
%X............ matice namerenych hodnot
%H............ matice, ve ktere to pocita

[d,n]=size(X);

if d>=n
    error('dimenze je vetsi nez pocet pozorovani!')
end
if (r~=0)&&(r~=1)
    error('r should be 0 or 1!')
end

Mu = zeros(1,d); % Means
I=eye(d);
p = 1; % Mixing proportions
obj4 = gmdistribution(Mu,4*I,p);
obj3 = gmdistribution(Mu,3*I,p);
obj2 = gmdistribution(Mu,2*I,p);

Hna12=H^(-1/2);
Hna1=H^(-1);
Hna2=Hna1^2;
tr=trace(Hna1);
detH=det(H)^(-1/2);
% tic
% for i=1:n
%     for j=1:n
%         X_ij=Hna12*(X(:,i)-X(:,j));
%         XX=Hna12*(X_ij*X_ij');
%         Omega4(i,j)=pdf(obj4,X_ij')*trace(Hna1*(XX*Hna12/4-I))/4;
%         Omega3(i,j)=pdf(obj3,X_ij')*trace(Hna1*(XX*Hna12/3-I))/3;
%         Omega2(i,j)=pdf(obj2,X_ij')*trace(Hna1*(XX*Hna12/2-I))/2;
%     end
% end
% mise1=1/(2*n)*(4*pi)^(-d/2)*detH*trace(Hna1)-4*detH/(n^2)*sum(sum(Omega4-2*Omega3+Omega2))
% toc
% X_ij=[];Omega4=[];Omega3=[];Omega2=[];XX=[];
% tic
for i=1:n
    X_ij=Hna12*(X(:,i)*ones(1,n)-X);
    XX=diag(X_ij'*Hna2*X_ij);
    Omega4(:,i)=pdf(obj4,X_ij').*((XX/4-tr)/4).^r;
    Omega3(:,i)=pdf(obj3,X_ij').*((XX/3-tr)/3).^r;
    Omega2(:,i)=pdf(obj2,X_ij').*((XX/2-tr)/2).^r;
end
%mise=(d+2)/(2*n)*(4*pi)^(-d/2)*detH*trace(Hna1)-4*detH/(n^2)*sum(sum(Omega4-2*Omega3+Omega2));
mise=(d+2)/(2^r*n)*(4*pi)^(-d/2)*detH*(trace(Hna1))^r-4*detH/(n^2)*sum(sum(Omega4-2*Omega3+Omega2));

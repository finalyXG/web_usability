function[mise]=cv(r,X,H,met)
% CV Least-square cross-validation
%
%value=cv(X,H)
%computes the value of LSCV at H
%X............ matrix of observations
%H............ bandwidth matrix
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

[d,n]=size(X);

if d>=n
    error('dimenze je vetsi nez pocet pozorovani!')
end

if (r~=0)&&(r~=1)
    error('r should be 0 or 1!')
end

Mu = zeros(1,d); % Means
p = 1; % Mixing proportions
obj2 = gmdistribution(Mu,2*H,p);
obj = gmdistribution(Mu,H,p);

Hna1=H^(-1);
Hna2=Hna1^2;
tr=trace(Hna1);
if met==1
    detH=det(H)^(-1/2);
    
    for i=1:n
        X_ij=(X(:,i)*ones(1,n-1)-X(:,[1:i-1,i+1:end]));
        XX=diag(X_ij'*Hna2*X_ij);
        Omega2(:,i)=pdf(obj2,X_ij').*((XX/2-tr)/2).^r;
        Omega(:,i)=pdf(obj,X_ij').*((XX-tr)).^r;
    end
    mise=1/(2^r*n)*(4*pi)^(-d/2)*detH*(trace(Hna1))^r+1/(n*(n-1))*sum(sum(Omega2-2*Omega));
    
else
    for i=1:n
        X_ij=(X(:,i)*ones(1,n)-X);
        XX=diag(X_ij'*Hna2*X_ij);
        Omega2(:,i)=pdf(obj2,X_ij').*((XX/2-tr)/2).^r;
        X_ij=(X(:,i)*ones(1,n-1)-X(:,[1:i-1,i+1:end]));
        XX=diag(X_ij'*Hna2*X_ij);
        Omega(:,i)=pdf(obj,X_ij').*(XX-tr).^r;
    end
    mise=(-1)^r*(1/(n^2)*sum(sum(Omega2))-2/(n*(n-1))*sum(sum(Omega)));
end


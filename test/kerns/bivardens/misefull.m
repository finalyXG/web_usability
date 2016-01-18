function[mise]=misefull(r,n,mu,sigma,w,H)
%MISEFULL value of MISE for normal mixture densities
%
%H=misefull(r,n,mu,sigma,w,H)
%r......... 0 for density estimation, 1 for the first derivative
%n......... sample size
%mu......... matrix of means
%sigma......... array of covariance matrices
%w............ wieght vector for all terms of mixture
%H............ bandwidth matrix
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

d=size(mu,2);
w=w(:);
k=length(w);

if (r~=0)&&(r~=1)
    error('r should be 0 or 1!')
end

for i=1:k
    for j=1:k
        Mu = zeros(1,d); % Means
        Sig0 = cat(3,sigma(:,:,i)+sigma(:,:,j)); % Covariances
        Sig1 = cat(3,H+sigma(:,:,i)+sigma(:,:,j)); % Covariances
        Sig2 = cat(3,2*H+sigma(:,:,i)+sigma(:,:,j)); % Covariances
        p = 1; % Mixing proportions
        obj0 = gmdistribution(Mu,Sig0,p);
        obj1 = gmdistribution(Mu,Sig1,p);
        obj2 = gmdistribution(Mu,Sig2,p);
        mu_ij=(mu(i,:)-mu(j,:))';
        Omega0(i,j)=(-1)^r*pdf(obj0,mu_ij')*(mu_ij'*Sig0^(-2)*mu_ij-2*trace(Sig0^(-1)))^r;
        Omega1(i,j)=(-1)^r*pdf(obj1,mu_ij')*(mu_ij'*Sig1^(-2)*mu_ij-2*trace(Sig1^(-1)))^r;
        Omega2(i,j)=(-1)^r*pdf(obj2,mu_ij')*(mu_ij'*Sig2^(-2)*mu_ij-2*trace(Sig2^(-1)))^r;
    end
end
mise=1/n*2^(-r)*(4*pi)^(-d/2)*det(H)^(-1/2)*trace(inv(H))^r+w'*((1-1/n)*Omega2-2*Omega1+Omega0)*w;

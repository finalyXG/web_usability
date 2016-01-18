function [h,psi2]=h_Altman(X,K)

X=row(X);
nor=sym('1/sqrt(2*pi)*exp(-x^2/2)');
nor2d=diff(nor,2);
n2ds=char(nor2d);
n2ds=strrep(n2ds,'*','.*');
n2ds=strrep(n2ds,'/','./');
n2ds=strrep(n2ds,'^','.^');
n2d=inline(n2ds);
n=length(X);
g=n^(-0.3);
psi2=0;
for XX=X;
    psi2=psi2+sum(n2d((XX-X)/g));
end
psi2=psi2/(n*n*g*g*g);
W=W_def(K);
c1=c_one(W);
h=(c1/(-K.beta^2*n*psi2))^(1/3);
psi2=abs(psi2);

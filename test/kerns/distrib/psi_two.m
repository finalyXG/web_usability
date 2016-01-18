function psi2=psi_two(X,K,h)

X=row(X);
n=length(X);
psi2=0;
xx=X;
for x=xx
 xp=(x-X)/h;
 psi2=psi2+sum(K_val(K,xp));
end
psi2=psi2/(n^2*h^3);

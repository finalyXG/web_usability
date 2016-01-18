function h1=iter1(h0,X,K)
% function h1=iter1(h0,X,K)
% one iteration of the iteration function for bandwidth h0,
% data X and kernel K

k=K.k;
CK=Kconv_def(K);
X=row(X);
n=length(X);
xmax=max(X);
xmin=min(X);
ICIT=K.var;
x=linspace(xmin-2*h0,xmax+2*h0,101);
delta=(xmax-xmin+4*h0)/100;
JMEN=zeros(size(x));
for XX=X
    u=(x-XX)/h0;
    JMEN=JMEN+Kconv_val(CK,u)-K_val(K,u);
end
IJMEN=sum(JMEN.^2)*delta;
h1=((h0^2*n)/(2*k))*(ICIT/IJMEN);

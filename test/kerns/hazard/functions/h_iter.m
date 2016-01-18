function h=h_iter(X,d,K)

if 1
n=length(X);
s0=std(X);
XS=sort(X);
%sq=(XS(floor(3*n/4))-XS(floor(n/4)))/(norminv(0.75,0,1)-norminv(0.25,0,1));
%sq=(XS(floor(3*n/4))-XS(floor(n/4)))/(0.67448975- (-0.67448975));
sq=(XS(floor(3*n/4))-XS(floor(n/4)))/(2*0.67448975);
sigma=min([s0,sq]);
k=K.k;
V=K.var;
beta=K.beta;
coef=((2*k+1)*(2*k+5)*(k+1)*(k+1)*(factorial(k))^4*V)/(k*factorial(2*k+3)*factorial(2*k+2)*beta*beta);
b_k=2*sqrt(2*k+5)*coef^(1/(2*k+1));
h0=sigma*b_k*n^(-1/(2*k+1));
else
h0=max(X)/4;
end
[h,nit,iterations]=iter_bistef(h0,X,d,K);

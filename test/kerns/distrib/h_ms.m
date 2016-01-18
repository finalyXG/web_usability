function [h,psi2]=h_MS(X,K)

w=W_def(K);
c1=c_one(w);
n=length(X);
beta2=K.beta;
beta2=beta2^2;

s0=std(X);
XS=sort(X);
sq=(XS(floor(3*n/4))-XS(floor(n/4)))/(norminv(0.75,0,1)-norminv(0.25,0,1));
s=min([s0,sq]);

h=s*sqrt(7)*(7*c1/(15*beta2*n))^(1/3);
psi2=15/(49*sqrt(7)*s^3);

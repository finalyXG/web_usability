function [h,psi2]=h_F(X,K)

W=W_def(K);
c1=c_one(W);
c2=c_two(X,K);
n=length(X);
h=(c1/(4*c2*n))^(1/3);
psi2=4*c2/K.beta^2;
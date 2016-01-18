function y=Phi(hh,X,K)
% function Phi(hh,X,K)
% zero of Phi is approximation of optimal bandwidth h
% hh - set of bandwidths h, X - data, K - kernel

K2=Kconv_def(K,2);
K3=Kconv_def(K,3);
K4=Kconv_def(K,4);

k=K.k;
n=length(X);
XP=X(:)*ones(1,length(X));
MX=XP-XP';
y=[];
for h0=hh
 MXh=MX/h0;
 C=Kconv_val(K4,MXh)-2*Kconv_val(K3,MXh)+Kconv_val(K2,MXh);
 y0=2*k*sum(sum(C))/n-K.var;
 y=[y,y0];
end
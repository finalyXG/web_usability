function y=Phi(hh,X,K)
% function Phi(hh,X,K)
% derivative of function Phi
% zero of Phi is approximation of optimal bandwidth h 
% hh - set of bandwidths h, X - data, K - kernel 

K2=Kconv_def(K,2);
K3=Kconv_def(K,3);
K4=Kconv_def(K,4);
dK2=Kconv_der(K2);
dK3=Kconv_der(K3);
dK4=Kconv_der(K4);

k=K.k;
n=length(X);
XP=X(:)*ones(1,length(X));
MX=XP-XP';
y=[];
for h0=hh
 MXh=MX/h0;
 Cd=Kconv_val(dK4,MXh)-2*Kconv_val(dK3,MXh)+Kconv_val(dK2,MXh);
 y0=-2*k*sum(sum(MX.*Cd))/(n*h0*h0);
 y=[y,y0];
end
function h1=newton1(h0,X,K)
% function h1=newton1(h0,X,K)
% one iteration of the Newton method iteration function for bandwidth h0,
% data X and kernel K for bandwidth choice using convolutions

K2=Kconv_coef(K,2);
K3=Kconv_coef(K,3);
K4=Kconv_coef(K,4);
dK2=Kconv_der(K2);
dK3=Kconv_der(K3);
dK4=Kconv_der(K4);

k=K.k;
n=length(X);
odecist=K.var*n/(2*k);
XP=X(:)*ones(1,length(X));
MX=XP-XP';
MXh=MX/h0;
C=Kconv_val(K4,MXh)-2*Kconv_val(K3,MXh)+Kconv_val(K2,MXh);
cit=sum(sum(C));
J=Kconv_val(dK4,MXh)-2*Kconv_val(dK3,MXh)+Kconv_val(dK2,MXh);
jmen=sum(sum(MX.*J));
h1=h0+h0^2*(cit-odecist)/jmen;

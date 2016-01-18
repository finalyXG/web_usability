function [h_new,pociter,iterace]=iter_bisnewt(h_old,X,K,maxiter,pres)
% function [h_new,pociter,iterace]=iter_bisnewt(h_old,X,K,maxiter,pres)
% bisection method combined with Newton's iterative procedure
% for bandwidth choice using convolutions

mulkoef=2;

if nargin<5
 pres=0.0001;
 if nargin==3
  maxiter=50;
 end
end
pociter=0;
iterace=h_old;
x0=h_old;
I0=Phi(x0,X,K);
if I0>0
	x1=x0/mulkoef;
	I1=Phi(x1,X,K);
	while (I1>0) & (pociter<maxiter)
		iterace=[iterace,x1];
		pociter=pociter+1;
		x0=x1; I0=I1;
		x1=x0/mulkoef;
		I1=Phi(x1,X,K);
	end
	a=x1;b=x0;
else
	x1=x0*mulkoef;
	I1=Phi(x1,X,K);
	while (I1<0) & (pociter<maxiter)
		iterace=[iterace,x1];
		pociter=pociter+1;
		x0=x1; I0=I1;
		x1=x0*mulkoef;
		I1=Phi(x1,X,K);
	end
	a=x0;b=x1;
end
c=(a+b)/2;
x0=c;
%h_old=c;
iterace=[iterace,x0];
pociter=pociter+1;
k=K.k;
% CK=CK_coef(K);
Ic=Phi(c,X,K);
Icd=Phi_der(c,X,K);
h_new=c-Ic/Icd;
while (abs((h_old-h_new)/h_new)>pres) & (pociter<maxiter)
 while(h_new<a) | (h_new>b)
	if Ic<0 a=c;
	else b=c;
	end
	c=(a+b)/2;
	x0=c;
	iterace=[iterace,x0];
	pociter=pociter+1;
	Ic=Phi(c,X,K);
	Icd=Phi_der(c,X,K);
	h_new=c-Ic/Icd;
 end
 h_old=h_new;
 x0=h_old;
 Ic=Phi(h_old,X,K);
 Icd=Phi_der(h_old,X,K);
 h_new=h_old-Ic/Icd;
 pociter=pociter+1;
 iterace=[iterace,h_old];
end
iterace=[iterace,h_new];

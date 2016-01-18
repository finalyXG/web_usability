function [h_new,pociter,iterace]=iter_stef(h_old,X,d,K,maxiter,pres)
% function [h_new,pociter,iterace]=iter_stef(h_old,X,d,K,maxiter,pres)
% bisection method combined with Steffensen's iterative procedure

mulkoef=1.5;

if nargin<6
 pres=0.0001;
 if nargin==4
  maxiter=50;
 end
end
Mx=max(X);
pociter=0;
iterace=h_old;
x0=h_old;
I0=iter_haz(x0,X,d,K);
if I0>=x0
	x1=mulkoef*x0;
	I1=iter_haz(x1,X,d,K);
	while (I1>=x1) & (x1<Mx) &  (pociter<maxiter)
		iterace=[iterace,x1];
		pociter=pociter+1;
		x0=x1; I0=I1;
		x1=mulkoef*x0;
		I1=iter_haz(x1,X,d,K);
	end
	a=x0;b=x1;
    if I1>x1
        h_new=NaN;
        return
    end
else
	x1=x0/mulkoef;
	I1=iter_haz(x1,X,d,K);
	while (I1<x1) & (pociter<maxiter)
		iterace=[iterace,x1];
		pociter=pociter+1;
		x0=x1; I0=I1;
		x1=x0/mulkoef;
		I1=iter_haz(x1,X,d,K);
	end
	a=x1;b=x0;
    if I1<x1
        h_new=NaN;
        return
    end
end
c=(a+b)/2;
x0=c;
iterace=[iterace,x0];
pociter=pociter+1;
k=K.k;
% CK=CK_coef(K);
x1=iter_haz(x0,X,d,K);
x2=iter_haz(x1,X,d,K);
Ic=x1;
h_new=abs(x0-(x1-x0)^2/(x2-2*x1+x0));
while (abs((h_old-h_new)/h_new)>pres) & (pociter<maxiter)
 while(h_new<a) | (h_new>b)
	if Ic>c a=c;
	else b=c;
	end
	c=(a+b)/2;
	x0=c;
	iterace=[iterace,x0];
	pociter=pociter+1;
	x1=iter_haz(x0,X,d,K);
	x2=iter_haz(x1,X,d,K);
	Ic=x1;
	h_new=abs(x0-(x1-x0)^2/(x2-2*x1+x0));
 end
 h_old=h_new;
 x0=h_old;
 x1=iter_haz(x0,X,d,K);
 x2=iter_haz(x1,X,d,K);
 h_new=abs(x0-(x1-x0)^2/(x2-2*x1+x0));
 pociter=pociter+1;
 iterace=[iterace,h_old];
end
iterace=[iterace,h_new];

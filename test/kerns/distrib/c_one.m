function c1=c_one(W)

w=W.coef;
lw=length(w);
p=[zeros(1,lw-1),1]-w;
p=conv(w,p);
ip=polyint(p);
c1=polyval(ip,1)-polyval(ip,-1);

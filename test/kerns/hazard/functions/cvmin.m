function h0=cvmin(X,d,K)

tol=0.001;
nit=0;
MX=max(X);
hh=linspace(MX/100,2*MX/3,20);
cv=crossval(X,d,hh,K);
[cv0,I]=min(cv);

if I<=2
 m1=cv(1);m4=cv(5);
 h1=hh(1);h4=hh(5);
elseif I>=19
 m1=cv(16);m4=cv(20);
 h1=hh(16);h4=hh(20);
else
 m1=cv(I-2);m4=cv(I+2);
 h1=hh(I-2);h4=hh(I+2);
end
dist=h4-h1;
gr=(sqrt(5)+1)/2;
% golden ratio minimisation
dist=dist/gr;
h2=h4-dist;
h3=h1+dist;
cv=crossval(X,d,[h2,h3],K);
m2=cv(1);
m3=cv(2);
while abs((h3-h2)*2/(h3+h2))>tol
nit=nit+1;
 dist=dist/gr;
 if m3<m2
  h1=h2;h2=h3;h3=h1+dist;
  m1=m2;m2=m3;m3=crossval(X,d,h3,K);
 else
  h4=h3;h3=h2;h2=h4-dist;
  m4=m3;m3=m2;m2=crossval(X,d,h2,K);
 end
end 
h0=(h2+h3)/2;

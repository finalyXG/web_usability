function h0=mlmax(X,d,K)

tol=0.001;
nit=0;
MX=max(X);
hh=linspace(MX/100,MX/2,20);
ml=maxlike(X,d,hh,K);
[ml0,I]=max(ml);
if I<=2
 m1=ml(1);m4=ml(5);
 h1=hh(1);h4=hh(5);
elseif I>=19
 m1=ml(16);m4=ml(20);
 h1=hh(16);h4=hh(20);
else
 m1=ml(I-2);m4=ml(I+2);
 h1=hh(I-2);h4=hh(I+2);
end
dist=h4-h1;
gr=(sqrt(5)+1)/2;
% golden ratio maximisation
dist=dist/gr;
h2=h4-dist;
h3=h1+dist;
ml=maxlike(X,d,[h2,h3],K);
m2=ml(1);
m3=ml(2);
while abs((h3-h2)*2/(h3+h2))>tol
nit=nit+1;
 dist=dist/gr;
 if m3>m2
  h1=h2;h2=h3;h3=h1+dist;
  m1=m2;m2=m3;m3=maxlike(X,d,h3,K);
 else
  h4=h3;h3=h2;h2=h4-dist;
  m4=m3;m3=m2;m2=maxlike(X,d,h2,K);
 end
end 
h0=(h2+h3)/2;
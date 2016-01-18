function y=maxlike(X,d,hh,K)
% function y=maxlike(X,d,hh,K)
% cross-val. function

y=[];
n=length(X);
X=row(X);
d=row(d);
for h=hh
 S=max(X)+h;
 xx=linspace(0,S,201);
 I1=find(d==1);
 pomsum=1;
 for ind1=1:n;
  XX=X;
  dd=d;
  XX(ind1)=[];
  dd(ind1)=[];
  if d(ind1)==1
   val1=K_hafest(XX,dd,K,X(ind1),h);
  else
   val1=1;
  end
  xx=linspace(0,X(ind1),101);
  val2=sum(K_hafest(XX,dd,K,xx,h))*X(ind1)/100;
  pomsum=pomsum*val1*exp(-val2);
 end
 y=[y,pomsum];
end
return

% wrong version?
if 0
y=[];
n=length(X);
X=row(X);
d=row(d);
for h=hh
 S=max(X)+h;
 xx=linspace(0,S,201);
 I1=find(d==1);
 pomsum=1;
 for ind1=I1
  XX=X;
  dd=d;
  XX(ind1)=[];
  dd(ind1)=[];
  val1=K_hafest(XX,dd,K,X(ind1),h);
  xx=linspace(0,X(ind1),201);
  val2=sum(K_hafest(XX,dd,K,xx,h))*X(ind1)/200;
  pomsum=pomsum*val1*exp(-val2);
 end
 y=[y,pomsum];
end
end
% if 0
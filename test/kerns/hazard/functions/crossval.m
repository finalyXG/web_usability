function y=crossval(X,d,hh,K)
% function y=crossval(X,d,hh,K)
% cross-val. function

NI=64;

y=[];
n=length(X);
for h=hh
 S=max(X)+h;
 xx=linspace(0,S,NI+1);
 lam=K_hafest(X,d,K,xx,h);
 lam2=lam.^2;
% Romberg integration
 step=S;
 nR=NI;
% composed trap. rule - basic value
 CSR=step*(lam2(1)+lam2(NI+1))/2;
 IR=[CSR];
 while nR>1
  II=[nR/2:nR:NI]+1;
  step=step/2;
% composed trap. rule
  CSR=CSR/2+sum(lam2(II))*step;
  IR=[IR,CSR];
  nR=nR/2;
 end
 lR=length(IR);
 coef=4;
 while lR>1;
  IR=(coef*IR(2:lR)-IR(1:lR-1))/(coef-1);
  coef=4*coef;
  lR=length(IR);
 end

 I1=find(d==1);
 I1=row(I1);
 pomsum=0;
 for ind1=I1
  XX=X;
  dd=d;
  XX(ind1)=[];
  dd(ind1)=[];
  pomsum=pomsum+K_hafest(XX,dd,K,X(ind1),h)/(1-L_n(XX,X(ind1)));
 end
 y=[y,IR-pomsum*2/n];
end

return


% old version

if 0
y=[];
n=length(X);
for h=hh
 S=max(X)+h;
 xx=linspace(0,S,201);
 lam=K_hafest(X,d,K,xx,h);
 II=sum(lam.^2)*S/200;
 I1=find(d==1);
 pomsum=0;
 for ind1=I1
  XX=X;
  dd=d;
  XX(ind1)=[];
  dd(ind1)=[];
  pomsum=pomsum+K_hafest(XX,dd,K,X(ind1),h)/(1-L_n(XX,X(ind1)));
 end
 y=[y,II-pomsum*2/n];
end
end % if 0
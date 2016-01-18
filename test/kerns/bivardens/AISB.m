function b=AISB(XX,H,m)
% pro normalni jadro
% vola soubor: konvoluceC
% pro d =1,2,3,4

Hi=inv(H);
if m==0
  vecHjm=1;
else
  Hjm=1;
  k=1;
  while k<=m
    Hjm=kron(Hi,Hjm);
    k=k+1;
  end
  vecHjm=Hjm(:);
end

[d,n]=size(XX);
XX_XX=zeros([n,n,d]);
for u=1:d
  aa=XX(u,:);
  XX_XX(:,:,u)=repmat(aa,n,1)-repmat(aa',1,n);
end

Hip=H^(-1/2);
xx=zeros([n,n,d]);
for u=1:d
  ab=zeros([n,n,d]);
  for el=1:d
    ab(:,:,el)=Hip(u,el)*XX_XX(:,:,el);
  end;
  xx(:,:,u)=sum(ab,3);
end

jmeno=['konvik_CK',num2str(d),num2str(m),'.mat'];
if exist(jmeno,'file')
    load(jmeno);
else
    DmCK=konvoluceC(d,m);
    save(jmeno,'DmCK');
end

seznam=sym('x_%d', [1 d]); % nejde ve verzi 2010a
if d==1
  CK=subs(DmCK,seznam,{xx(:,:,1)});
elseif d==2
  CK=subs(DmCK,seznam,{xx(:,:,1),xx(:,:,2)});
elseif d==3
  CK=subs(DmCK,seznam,{xx(:,:,1),xx(:,:,2),xx(:,:,3)});
elseif d==4
  CK=subs(DmCK,seznam,{xx(:,:,1),xx(:,:,2),xx(:,:,3),xx(:,:,4)});
end

vecDCK=zeros([d^(2*m),1]);
WW=ones([n,n])-diag(ones([1,n]));
for u=1:(d^(2*m))
  vecDCK(u)=sum(sum(CK((u-1)*n+1:u*n,:).*WW));
end

b=(-1)^m*n^(-2)*(det(H))^(-1/2)*(vecHjm.')*vecDCK;

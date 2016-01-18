function v=AIV(H,n,m)
% pro normalni jadro
% vola soubor: komutacni_matice
% m =0,1,2

if nargin==2
  m=0;
end

Hi=inv(H);
if m==0
  Hjm=1;
else
  Hjm=1;
  k=1;
  while k<=m
    Hjm=kron(Hi,Hjm);
    k=k+1;
  end
end

d=length(H);
erKa=(2^(d+m)*sqrt(pi)^d)^(-1);
if m<=1
  RDmK=eye(d^m)*erKa;
elseif m==2
  Kd=komutacni_matice(d,d);
  Id2=eye(d^m);
  Id=eye(d);
  vecId=Id(:);
  IdId=vecId*(vecId)';
  RDmK=(Kd+Id2+IdId)*erKa;
end

v=n^(-1)*(det(H))^(-1/2)*trace(Hjm*RDmK);

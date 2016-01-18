function KM=komutacni_matice(m,n)
% The commutation matrix by Magnus & Neudecker (1979)
if nargin==1
  n=m;
end

KM=zeros(m*n);
ai=zeros([m,1]);  % sloupec
ej=zeros([1,n]);  % radek
for i=1:m
  for j=1:n
    ai(i)=1;
    ej(j)=1;
    Hij=ai*ej;
    KM=KM+kron(Hij,Hij.');
    ai=zeros([m,1]);  % sloupec
    ej=zeros([1,n]);  % radek
  end
end

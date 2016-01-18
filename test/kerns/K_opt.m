function k_o=k_opt(nu,k,mu)
% function k_o=k_opt(nu,k,mu)
% Coefficients of the optimal kernel of order nu,k, with smoothnes mu

alpha=mu+1.5;
if k==2
 geg=1;
else
 % counting the matrix with coefficients of Gegenbauer polynomials
 geg=[0 1;2*alpha 0]; % initial values for degree 0 and 1
 for j=2:k-2
  t_geg=conv([2*(alpha+j-1)/j, 0],geg(j,:));
  t_geg=t_geg-[0 ((2*alpha+j-2)/j)*geg(j-1,:)];
  geg=[zeros(j,1), geg];
  geg=[geg; t_geg];
 end
end
geg=geg(nu+1:k-1,:);
pom=0.5:mu+0.5;
pom=prod(pom);
pom=(2^(-1-2*mu))/(pom*pom);
a=[];
for j=nu+1:k-1
 t_a=prod(1:2*mu+j+1)/(prod(1:j-1)*(2*mu+2*j+1));
 a=[a, t_a];
end
a=a*pom;
koef=[geg(:,k-1-nu)]';
koef=koef./a;
k_pom=koef*geg;
p_pom=1;
for j=1:mu+1
 p_pom=conv(p_pom,[-1 0 1]);
end
konst=-2*mod(nu,2)+1; % (-1)^nu
konst=konst*prod(1:nu);
k_o=konst*conv(k_pom,p_pom);

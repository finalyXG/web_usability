function h=CDF_bandw(X,K,meth)
% function h=CDF_bandw(X,K,meth)

n=length(X);
s0=std(X);
XS=sort(X);
%sq=(XS(floor(3*n/4))-XS(floor(n/4)))/(norminv(0.75,0,1)-norminv(0.25,0,1));
%sq=(XS(floor(3*n/4))-XS(floor(n/4)))/(0.67448975- (-0.67448975));
sq=(XS(floor(3*n/4))-XS(floor(n/4)))/(2*0.67448975);
sigma=min([s0,sq]);

k=2;
V=K.var;
beta=K.beta;
nu=K.nu;
gamma=V/beta^2;

w=W_def(K);
c1=c_one(w);
beta2=beta^2;

switch lower(meth(1:2))
 case 'it'
  h=h_F(X,K);
 case 'dp'
  h=h_Altman(X,K);
 case 'ms'
  h=sigma*sqrt(7)*(7*c1/(15*beta2*n))^(1/3);
 case 'rd'
  h=sigma*(4*sqrt(pi)*c1/(n*beta2))^(1/3);
 otherwise
  error('CDF_bandw: unknown method.')
end
function h=HAZARD_bandw(X,K,meth)
% function h=HAZARD_bandw(X,K,meth)

k=K.k;
nu=K.nu;
mu=K.mu;
if nu>1
  if mod(k,2), nup=1; else nup=0; end
  Kp=K_def('opt',nup,k,mu);
else
  Kp=k;
end
swith lower(meth(1:2))
 case 'it'
 case 'dp'
 case 'ms'
  n=length(X);
  s0=std(X);
  XS=sort(X);
  sq=(XS(floor(3*n/4))-XS(floor(n/4)))/(norminv(0.75,0,1)-norminv(0.25,0,1));
  sigma=min([s0,sq]);
  k=K.k;
  V=K.var;
  beta=K.beta;
  I=
  coef=((2*k+1)*(2*k+5)*(k+1)*(k+1)*(fa(k))^4*V)/(k*fa(2*k+3)*fa(2*k+2)*beta*beta);
  b_k=2*sqrt(2*k+5)*coef^(1/(2*k+1));
  h_m=sigma*b_k*n^(-1/(2*k+1));
  
 case 'bc'
 case 'lc'
 case 'rd'
 otherwise error('HAZARD_bandw: unknown method.')
end
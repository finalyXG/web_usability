function h=KDE_bandw(X,K,meth)
% function h=KDE_bandw(X,K,meth)

n=length(X);
s0=std(X);
XS=sort(X);
%sq=(XS(floor(3*n/4))-XS(floor(n/4)))/(norminv(0.75,0,1)-norminv(0.25,0,1));
%sq=(XS(floor(3*n/4))-XS(floor(n/4)))/(0.67448975- (-0.67448975));
sq=(XS(floor(3*n/4))-XS(floor(n/4)))/(2*0.67448975);
sigma=min([s0,sq]);

k=K.k;
V=K.var;
beta=K.beta;
nu=K.nu;
gamma=V/beta^2;

switch lower(meth(1:2))
 case 'it'
  D_k=(prod(1:2:2*k+1))^2*(2*k+3)/((prod(1:k))^2*(2*k+1)*(2*k+5));
  h_m=sigma*sqrt(2*k+5)*(gamma/(2*(k-nu)*n*D_k))^(1/(2*k+1));
  [h,pociter,iterace]=iter_bisnewt(h_m,X,K,50,0.0001);
 case 'dp'
  XX=X/sigma;h=dpi(XX,K);h=h*sigma;
 case 'ms'
  D_k=(prod(1:2:2*k+1))^2*(2*k+3)/((prod(1:k))^2*(2*k+1)*(2*k+5));
  h=sigma*sqrt(2*k+5)*(gamma/(2*(k-nu)*n*D_k))^(1/(2*k+1));
 case 'bc'
  h=bcv(X,K);
 case 'lc'
  h=lscv(X,K);
 case 'rd'
  D_k=prod(1:2*k)/(sqrt(pi)*(prod(1:k))^3*2^(2*k+1));
  h=sigma*(gamma/(2*(k-nu)*n*D_k))^(1/(2*k+1));
 otherwise
  error('KDE_bandw: unknown method.')
end
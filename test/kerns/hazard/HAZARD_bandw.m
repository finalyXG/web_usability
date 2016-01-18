function h=HAZARD_bandw(X,d,K,meth)
% function h=HAZARD_bandw(X,d,K,meth)

switch lower(meth(1:2))
 case 'it'
  h=h_iter(X,d,K);
 case 'cv'
  h=cvmin(X,d,K);
 case 'ml'
  h=mlmax(X,d,K);
 otherwise
  error('HAZARD_bandw: unknown method.')
end
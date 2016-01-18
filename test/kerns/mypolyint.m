function[P]=mypolyint(p,a,b);
%MYPOLYINT  polynomial integration
%
%[P]=polyint(p,a,b) 
%       P ....... integral of p
%       p ....... integrated polynomial
%       [a,b] ... boundary of interval (optional: default=[]=indefinite integral)
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

n=length(p);
q=n:-1:1;
P=[p./q,0];
if nargin==3
   P=polyval(P,b)-polyval(P,a);
end;

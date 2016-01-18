function [h_new,pociter,iterace]=iter_newton(h_old,X,K,maxiter,pres)
% function [h_new,pociter,iterace]=iter_newton(h_old,X,K,maxiter,pres)
% Newton's iterative procedure for bandwidth choice using convolutions

mulkoef=2;

if nargin<5
 pres=0.0001;
 if nargin==3
  maxiter=50;
 end
end
pociter=0;
iterace=h_old;
h_new=newton1(h_old,X,K);
while (abs((h_new-h_old)/h_new)>pres) & (pociter<maxiter)
  h_old=h_new;
  pociter=pociter+1;
  iterace=[iterace,h_old];
  h_new=newton1(h_old,X,K);
end
iterace=[iterace,h_new];

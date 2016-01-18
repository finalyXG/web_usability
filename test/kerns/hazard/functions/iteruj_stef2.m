function [h_new,pociter,iterace]=iteruj_s(h_old,ksi,k,data,maxiter,pres)

if nargin<5
 pres=0.001;
 if nargin==3
  maxiter=50;
 end
end
pociter=0;
iterace=h_old;
x0=h_old;
x1=h_iter2(x0,ksi,k,data);
x2=h_iter2(x1,ksi,k,data);
h_new=x0-(x1-x0)^2/(x2-2*x1+x0);
h_new=abs(h_new);
while ((abs((h_old-h_new)/h_new)>pres) & (pociter<maxiter)) | pociter<3
 h_old=h_new;
 x0=h_old;
 x1=h_iter2(x0,ksi,k,data);
 x2=h_iter2(x1,ksi,k,data);
 h_new=x0-(x1-x0)^2/(x2-2*x1+x0);
 h_new=abs(h_new)
 pociter=pociter+1;
 iterace=[iterace,h_new];
end

function F=distf_est(X,K,x,h)

F=[];
W=W_def(K);
n=length(X);
for xx=x
 px=(xx-X)/h;
 F=[F, sum(W_val(W,px))];
end
F=F/n;

function y=L_n(X,x)
% empirical distribution function
y=[];
n=length(X);
x=row(x);
for xx=x
    yp=sum(X<=xx);
    y=[y,yp];
end
y=y/(n+1);
function y=distf_emp(X,x)
% empirical distribution function
y=[];
n=length(X);
for xx=x
    yp=sum(X<=xx);
    y=[y,yp];
end
y=y/n;
function h_m=h_ms(X,K);
% function h_m=h_ms(X,K);
% bandwidth choice: maximal smoothing principle

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
coef=((2*k+1)*(2*k+5)*(k+1)*(k+1)*(fa(k))^4*V)/(k*fa(2*k+3)*fa(2*k+2)*beta*beta);
b_k=2*sqrt(2*k+5)*coef^(1/(2*k+1));
h_m=sigma*b_k*n^(-1/(2*k+1));

end % function

function f=fa(n)
% factorial
f=prod(1:n);
end % function fa

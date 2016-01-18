function y=col(x)
% function y=col(x)
%          retur column vector for row vector
y=x(:);
return;

y=x;
[m,n]=size(y);
if m==1
   y=y.';
end
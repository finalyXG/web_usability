function y=row(x)
% function y=row(x)
%          return row vector for column vector
% y=x';
y=x(:)';
return;

y=x;
[m,n]=size(y);
if n==1
   y=y.';
end
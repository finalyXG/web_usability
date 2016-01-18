  
  
function y = hess_vect_mult(w,sv,C)
  % Compute the Hessian times a given vector x.
  global X A
  y = w;
  z = (C.*sv).*(A*(X*w));  % Computing X(sv,:)*x takes more time in Matlab :-(
  y = y + ((z'*A)*X)';
  
  
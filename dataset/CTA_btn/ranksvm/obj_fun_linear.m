  
function [obj, grad, sv] = obj_fun_linear(w,C,out)
  % Compute the objective function, its gradient and the set of support vectors
  % Out is supposed to contain 1-A*X*w
  global X A
  out = max(0,out);
  obj = sum(C.*out.^2)/2 + w'*w/2; % L2 penalization of the errors
  grad = w - (((C.*out)'*A)*X)'; % Gradient
  sv = out>0;  



function [t,out] = line_search_linear(w,d,out,C) 
  % From the current solution w, do a line search in the direction d by
  % 1D Newton minimization
  global X A
  t = 0;
  % Precompute some dots products
  Xd = A*(X*d);
  wd = w'*d;
  dd = d'*d;
  while 1
    out2 = out - t*Xd; % The new outputs after a step of length t
    sv = find(out2>0);
    g = wd + t*dd - (C(sv).*out2(sv))'*Xd(sv); % The gradient (along the line)
    h = dd + Xd(sv)'*(Xd(sv).*C(sv)); % The second derivative (along the line)
    t = t - g/h; % Take the 1D Newton step. Note that if d was an exact Newton
                 % direction, t is 1 after the first iteration.
    if g^2/h < 1e-10, break; end;
  end;
  out = out2;
  
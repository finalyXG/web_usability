function y=W_val(W,x)
% function y=W_val(W,x)
% value of the weight function W in the point(s) x
% W(x) =\int_{-inf}^x K(t)dt
% K- kernel (structure):
% K.type  - type of the kernel:
%      'opt' - optimal kernel (default)
%      'fun' - external function
%      'str' - string (variable denoted as 'x')
%      'pol' - polynomial kernel
% K.name - string with kernel expression or function name,
%               ignored for optimal and polynomial kernel
% K.coef - coefficients of the optimal or polynomial kernel
% K.support - support of the kernel, default [-1,1]
% K.nu, K.k, K.mu - parameters of the kernel (order etc.)
% K.var  - variance of the kernel
% K.beta - k-th moment of the kernel
a=W.support(1);
b=W.support(2);

switch W.type
    case {'opt','pol'}
        y=polyval(W.coef,x).*(x>=a & x<=b)+(x>=b);
    case 'str'
        y=eval(W.name).*(x>=a & x<=b)+(x>=b);
    case 'fun'
        y=feval(W.name,x).*(x>=a & x<=b)+(x>=b);
end

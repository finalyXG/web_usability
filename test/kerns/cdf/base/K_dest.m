function y=K_dest(x,X,h,K)
% function y=K_dest(x,X,h,K)
% kernel estimator of a density or its derivative
% x - point(s) for estimtion
% X - data
% K- kernel (structure), Epanechnikov kernel is used as default:
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

if nargin==3 K=K_def('epan'); end
nu=K.nu;
x=row(x);
n=length(X);
y=zeros(size(x));
for ii=1:n
 px=(x-X(ii))/h;
 y=y+K_val(K,px);
end
hp=prod(h*ones(1,nu+1)); % h^{nu+1}
y=y/(n*hp);

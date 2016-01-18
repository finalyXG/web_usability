function W=W_def(K)
% function W=W_def(K)
% creates weight function for distribution function estimate
%
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
%
% only optimal or polynomial kernels are supposed
%

W=K;
p0=K.coef;
pp0=polyint(p0);
pom0=polyval(pp0,W.support(1));
lp0=length(pp0);
pp0(lp0)=pp0(lp0)-pom0;
W.coef=pp0;

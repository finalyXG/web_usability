function dK=K_der(K,m)
% function dK=K_der(K,m)
% m-th derivative of kernel K
% m - order of derivative (default 1)
%
% K- kernel (structure):
% K.type  - type of the kernel:
%      'opt' - optimal kernel (default)
%      'fun' - external function
%      'str' - string (variable denoted as 'x')
%      'pol' - polynomial kernel
%      'tri' - triangular kernel
%      'gau' - gaussian kernel with scale parameter s (default equal to 1)
% K.name - string with kernel expression or function name,
%               ignored for optimal and polynomial kernel
% K.coef - coefficients of the optimal or polynomial kernel
% K.support - support of the kernel, default [-1,1]
% K.nu, K.k, K.mu - parameters of the kernel (order etc.)
% K.var  - variance of the kernel
% K.beta - k-th moment of the kernel
%

if nargin==1
 m=1;
end
dK=K;
switch K.type
  case {'opt','pol'}
    P=K.coef;
      for jj=1:m;
    	P=polyder(m);
      end
   dK.coef=P;
  case 'gau'
    if isempty(K.coef)
      P=1;
    else
      P=K.coef;
    end
    P1=[-1/K.beta, 0];
    for ii=1:m
      P2=conv(P,P1);DP=polyder(P);
      nzer=length(P2)-length(DP);
      P=P2+[zeros(1,nzer),DP];
    end
    dK.coef=P;
  otherwise
    error('Kernel type is not supported  for derivative.')
end

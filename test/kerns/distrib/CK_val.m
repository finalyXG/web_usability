function y=CK_val(CK,u)
% function y=CK_val(K,u)
% value of convolution CK function for kernel K
% CK is the convolution: CK(u)=\int K(u-y)K(y)dy
% CK (structure): CK.L - coefficients for [-2,0]
%                 CK.R - coefficients for [0,2]
% u - variable
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
% K.ny, K.k, K.mi - parameters of the kernel (order etc.)
% K.var  - variance of the kernel
% K.beta - k-th moment of the kernel
%
% polynomial or optimal kernels are allowed only

y=zeros(size(u));
L=CK.L;
R=CK.R;
IL=find(u>=-2 & u<0);
y(IL)=polyval(L,u(IL));
IR=find(u<=2 & u>=0);
y(IR)=polyval(R,u(IR));

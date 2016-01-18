function CK=CK_coef(K)
% function CK=CK_coef(K)
% coefficients of CK function for kernel K
% CK is the convolution: CK(u)=\int K(u-y)K(y)dy
% CK (structure): CK.L - coefficients for [-2,0]
%                 CK.R - coefficients for [0,2]
% K - kernel (structure):
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

P=K.coef;
m=length(P)-1; % order of the polynomial
% table for left and right part of L function
L=zeros(1,m+1);
R=zeros(1,m+1);
% left and right part of L function
Lpom=P;
Rpom=P;
for l=0:m
    % left part
    Lpom=polyint(Lpom);
    npom=length(Lpom);
    valpom=polyval(Lpom,-1);
    Lpom(npom)=Lpom(npom)-valpom;
    % right part
    Rpom=polyint(Rpom);
    npom=length(Rpom);
    valpom=polyval(Rpom,1);
    Rpom(npom)=Rpom(npom)-valpom;

    Lcoefpom=0;
    Rcoefpom=0;
    for jj=l:m
        cpom=P(m+1-jj)*prod(jj-l+1:jj);
        Lcoefpom=Lcoefpom+(-1)^(jj-l)*cpom;
        Rcoefpom=Rcoefpom-cpom;
    end
    L=[0,L]+Lcoefpom*Lpom;
    R=[0,R]+Rcoefpom*Rpom;
end
L=movepol(L,-1);
R=movepol(R,1);
CK=struct('L',L,'R',R);

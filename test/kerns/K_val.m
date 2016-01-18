function y=K_val(K,x)
% function y=K_val(K,x)
% value of the kernel K in the point(s) x
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
% pre-defined types: 'epan','quart','rect','trian','gauss'
% call e.g. K=K_def('epan');
%           K=K_def('gauss'); - gaussian (stand. normal) kernel
%           K=K_def('gauss',s); - gaussian kernel with variance s^2 (defalt 1)
%
%
a=K.support(1);
b=K.support(2);
y=zeros(size(x));
I=find(x>=a & x<=b);
x=x(I);

switch K.type 
    case {'opt','pol'}
        y(I)=polyval(K.coef,x);
    case 'str'
        fs=K.name;
        fs=strrep(fs,'*','.*');
        fs=strrep(fs,'/','./');
        fs=strrep(fs,'^','.^');
        y(I)=eval(fs);
    case 'fun'
        y(I)=feval(K.name,x);
    case 'gau'
    P=K.coef;
    if isempty(P)
      P=1;
    end
    s=sqrt(K.beta);
    y1=1/(s*sqrt(2*pi))*exp(-0.5*(x/s).^2);
    y(I)=y1.*polyval(P,x);
    case 'tri'
        y(I)=1-abs(x);
end


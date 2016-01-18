function K=K_def(method,par1,par2,par3)
% function K=K_def(method,par1,par2,par3)
% creates a kernel
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

tol=1000*eps;
default=0;
K=struct('type',char(0),'name',char(0),'coef',[],'support',[-1,1],'nu',NaN,'k',NaN,'mu',NaN,'var',NaN,'beta',NaN);
if nargin==0 default=1;
elseif strncmpi(method,'defa',4) | strncmpi(method,'epan',4)
    default=1;
end
if default
    K.type='opt';
    K.coef=[-0.75,0,0.75];
    K.nu=0;
    K.k=2;
    K.mu=0;
    p1=K.coef;
    p2=conv(p1,p1);
    p3=polyint(p2);
    K.var=polyval(p3,1)-polyval(p3,-1);
    p2=conv(p1,[1 0 0]);
    p3=polyint(p2);
    K.beta=polyval(p3,1)-polyval(p3,-1);
elseif strncmpi(method,'rect',4)
    K.type='opt';
    K.coef=0.5;
    K.nu=0;
    K.k=2;
    K.mu=-1;
    p1=K.coef;
    p2=conv(p1,p1);
    p3=polyint(p2);
    K.var=polyval(p3,1)-polyval(p3,-1);
    p2=conv(p1,[1 0 0]);
    p3=polyint(p2);
    K.beta=polyval(p3,1)-polyval(p3,-1);
elseif strncmpi(method,'quar',4)
    K.type='opt';
    K.coef=conv([-1,0,1],[-1,0,1])*15/16;
    K.nu=0;
    K.k=2;
    K.mu=1;
    p1=K.coef;
    p2=conv(p1,p1);
    p3=polyint(p2);
    K.var=polyval(p3,1)-polyval(p3,-1);
    p2=conv(p1,[1 0 0]);
    p3=polyint(p2);
    K.beta=polyval(p3,1)-polyval(p3,-1);
elseif strcmpi(method,'opt')
    K.type='opt';
    nu=par1;
    k=par2;
    mu=par3;
    K.nu=nu;
    K.k=k;
    K.mu=mu;
    K.coef=K_opt(nu,k,mu);
    p1=K.coef;
    p2=conv(p1,p1);
    p3=polyint(p2);
    K.var=polyval(p3,1)-polyval(p3,-1);
    p2=conv(p1,[1 zeros(1,k)]);
    p3=polyint(p2);
    K.beta=polyval(p3,1)-polyval(p3,-1);
elseif strcmpi(method,'pol')
    K.type='pol';
    P=par1;
    a=par2;
    b=par3;
    nu=0;
    P0=P;
    P1=polyint(P0);
    I=polyval(P1,b)-polyval(P1,a);
    while abs(I)<tol
        nu=nu+1;
        P0=conv(P0,[1,0]);
        P1=polyint(P0);
        I=polyval(P1,b)-polyval(P1,a);
    end
    P=(-1)^nu*prod(1:nu)/I*P;
    K.nu=nu;
    k=nu+1;
    P0=conv(P,[1,zeros(1,k)]);
    P1=polyint(P0);
    I=polyval(P1,b)-polyval(P1,a);
    while abs(I)<tol
        k=k+1;
        P0=conv(P0,[1,0]);
        P1=polyint(P0);
        I=polyval(P1,b)-polyval(P1,a);
    end
    K.k=k;
    K.beta=I;
    P0=conv(P,P);
    P1=polyint(P0);
    I=polyval(P1,b)-polyval(P1,a);
    K.var=I;
    mu=-1;
    P0=P;
    while abs(polyval(P0,a)) < tol & abs(polyval(P0,b)) < tol
        mu=mu+1;
        P0=polyder(P0);
    end
    K.mu=mu;
    K.coef=P;
    K.support=[a,b];
elseif strcmpi(method,'str')
    K.type='str';
    fs=strrep(par1,'.*','*');
    fs=strrep(fs,'./','/');
    fs=strrep(fs,'.^','^');
    K.name=fs;
    K.support=[par2,par3];
    if exist('sym')
        a=par2;
        b=par3;
        nu=0;
        f=sym(fs);
        f0=f;
        I=int(f0,a,b);
        while abs(eval(I))<tol
            nu=nu+1;
            f0=f0*sym('x');
            I=int(f0,a,b);
        end
        f=(-1)^nu*prod(1:nu)/I*f;
	fs=char(f);
        K.name=fs;
        K.nu=nu;
        k=nu+1;
        f0=f*sym(['x^',num2str(k)]);
        I=int(f0,a,b);
        while abs(eval(I))<tol
            k=k+1;
            f0=f0*sym('x');
            I=int(f0,a,b);
        end
        K.k=k;
        K.beta=eval(I);
        f0=f*f;
        I=int(f0,a,b);
        K.var=eval(I);
        mu=-1;
        f0=f;
        fa=limit(f0,a);
        fb=limit(f0,b);
        while (abs(eval(fa)) < tol & abs(eval(fb)) < tol) & mu<20
            mu=mu+1;
            f0=diff(f0);
            fa=limit(f0,a);
            fb=limit(f0,b);
        end
	if mu>=20 mu=inf; end
        K.mu=mu;
    end
elseif strcmpi(method,'fun')
    K.type='fun';
    K.name=par1;
    K.support=[par2,par3];
elseif strncmpi(method,'gaus',4) % Gauss kernel
    K.type='gau';
%    K.name='1/sqrt(2*pi)*exp(-x^2/2)';
    if nargin==1
	K.beta=1;
    else
	K.beta=par1^2;
    end
    s=sqrt(K.beta);
    K.support=[-inf,inf];
    K.nu=0;
    K.k=2;
    K.mu=inf;
    K.var=1/(2*s*sqrt(pi));
    K.coef=1; % used for derivatives of gaussian kernel
%    K.beta=s^2;
elseif strncmpi(method,'tria',4) % triangular kernel
    K.type='tri';
    K.support=[-1,1];
    K.nu=0;
    K.k=2;
    K.mu=0;
    K.var=2/3;
    K.beta=1/6;
else
    error('Unrecognized parameter')
end

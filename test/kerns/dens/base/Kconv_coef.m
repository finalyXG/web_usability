function Kc=Kconv_coef(K,degr)
% function Kc=Kconv_coef(K,degr)
% coefficients of convolution function of higher degree for kernel K
%
% Kc - structure:
% K.CP   - cutoff point
% K.coef - coefficients of polynomial on each subinterval
%
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
% polynomial or optimal kernels with support [-1,1] are allowed only
% degr - degree of the convolution (2 is the implicit value)
%

zerobound=1.0e6*eps;
if nargin==1 degr=2; end
CP=[-1,1]; % initial cut-off points
Po=K.coef; % initial convolution
Kc=K.coef; % coefficents of the kernel
m=length(K.coef)-1; % order of the kernel polynomial

for ii=2:degr % main loop
   % initial table for parts of ii-th convolution
%   Pn=zeros(ii,size(Po,2));
   Pn=[];
   nCP=length(CP);
   for jj=1:nCP
   % left and right integral of the convolution on [ CP(jj)-1 , CP(jj)+1 ]
      if jj==nCP % the right part is zero
         R=0;
      else
         R=zeros(1,size(Po,2));
         Rpom=Po(jj,:);
         for l=0:m
            % rigth part
            Rpom=polyint(Rpom);
            npom=length(Rpom);
            valpom=polyval(Rpom,CP(jj));
            Rpom(npom)=Rpom(npom)-valpom;
            Rcoefpom=0;
            for jj0=l:m
                cpom=Kc(m+1-jj0)*prod(jj0-l+1:jj0);
                Rcoefpom=Rcoefpom+(-1)^(jj0-l)*cpom;
            end
            R=[0,R]+Rcoefpom*Rpom;
         end
         R=movepol(R,-1);
      end
      if jj==1 % the left part is zero
         L=0;
      else
         L=zeros(1,size(Po,2));
         Lpom=Po(jj-1,:);
         for l=0:m
            % left part
            Lpom=polyint(Lpom);
            npom=length(Lpom);
            valpom=polyval(Lpom,CP(jj));
            Lpom(npom)=Lpom(npom)-valpom;
            Lcoefpom=0;
            for jj0=l:m
                cpom=Kc(m+1-jj0)*prod(jj0-l+1:jj0);
                Lcoefpom=Lcoefpom-cpom;
            end
            L=[0,L]+Lcoefpom*Lpom;
         end
         L=movepol(L,1);
      end
      Pn=[Pn;L+R];
   end
   Po=Pn;
   Pn=Pn.*(abs(Pn)>zerobound);
   CP=[CP-1,CP(nCP)+1];
end
Kc=struct('CP',CP,'coef',Pn);

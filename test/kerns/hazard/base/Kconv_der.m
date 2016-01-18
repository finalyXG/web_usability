function dKc=Kconv_der(Kc,m)
% function dKc=Kconv_der(Kc,x)
% m-th derivative of convolution function Kc
%
% Kc - structure:
% Kc.CP   - cutoff point
% Kc.coef - coefficients of polynomial on each subinterval
% m - order of derivative (default 1)

if nargin==1
 m=1;
end
dKc=Kc;
switch Kc.type
  case {'opt','pol'}
    CP=Kc.CP;
    P=Kc.coef;
    dP=[];
    nCP=length(CP);
    for ii=1:nCP-1
      Pom=P(ii,:);
      for jj=1:m;
	Pom=polyder(Pom);
      end
      dP=[dP;Pom];
    end
    dKc.coef=dP;
  case 'gau'
    if isempty(Kc.coef)
      P=1;
    else
      P=Kc.coef;
    end
    P1=[-1/Kc.beta, 0];
    for ii=1:m
      P2=conv(P,P1);DP=polyder(P);
      nzer=length(P2)-length(DP);
      P=P2+[zeros(1,nzer),DP];
    end
    dKc.coef=P;
  otherwise
    error('Kernel type is not supported  for convolution.')
end
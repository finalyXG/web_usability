function y=Kconv_val(Kc,x)
% function y=Kconv_val(Kc,x)
% values of convolution function Kc in points x
%
% Kc - structure:
% Kc.CP   - cutoff points
% Kc.coef - coefficients of polynomial on each subinterval
%	    or polynomial for gaussian kernel derivative
%


P=Kc.coef;
switch Kc.type
  case {'opt','pol'}
    CP=Kc.CP;
    nCP=length(CP);
    y=zeros(size(x));
    for ii=1:nCP-1
      Ix=find(x>=CP(ii) & x<=CP(ii+1));
      if ~isempty(Ix)
	  xx=x(Ix);
	  py=polyval(P(ii,:),xx);
	  y(Ix)=py;
      end
    end
  case 'gau'
    if isempty(P)
      P=1;
    end
    s=sqrt(Kc.beta);
    y1=1/(s*sqrt(2*pi))*exp(-0.5*(x/s).^2);
    y=y1.*polyval(P,x);
  otherwise
    error('Kernel type is not supported  for convolution.')
end
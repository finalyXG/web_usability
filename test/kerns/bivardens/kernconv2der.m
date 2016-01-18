function[p,X]=kernconv2der(ny,k,mi,C)
% KERNCONV2DER Convolution of second derivative of kernels
%
% p=kernconv2der(ny,k,mi);
%
% ny,k,mi ... order of kernel ([0,2,1] = Epanechnik)
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

[q,X]=kernconv(ny,k,mi,2,'jirka');
p(1,:)=polyder(polyder(polyder(polyder(q(1,:)))));
p(2,:)=polyder(polyder(polyder(polyder(q(2,:)))));

if nargin==4
    figure(C);hold on;
    for i=1:2
        x=linspace(X(i,1),X(i,2));
        plot(x,polyval(p(i,:),x));
    end
end


function CK=konvoluceC(d,m)
% konvoluce normalniho jadra pro iteracni metodu
% d =dimenze
% m =derivace
% opatrne pro vetsi d a m

seznam=sym('x_%d', [1 d]); 
pi=sym('pi'); % zpatky je to pi=double(pi)

ef2=(2*pi*2)^(-d/2)*exp(-1/(2*2)*sum(seznam.^2));
ef3=(2*pi*3)^(-d/2)*exp(-1/(2*3)*sum(seznam.^2));
ef4=(2*pi*4)^(-d/2)*exp(-1/(2*4)*sum(seznam.^2));
CK0=ef4 -2*ef3 +ef2;

if m==0
  CK=CK0;
else
  DmK=CK0;
  k=1;
  while k<=2*m
    DmK=jacobian(DmK(:),seznam);
    k=k+1;
  end
  CK=DmK(:);
end

pi=double(pi);
function[]=drkern(n,k,m)
%DRKERN  draws the kernel of order (n,k) and smoothness m
%
%  drkern(n,k,m) 
%       [n,k] .... order of kernel
%        m ....... the smoothness of used kernel
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

p=jadro(n,k,m);
x=-1:.01:1;
y=polyval(p,x);
figure;
plot(x,y,'r');hold on;
xx=-1:.1:1;
plot(xx,0*xx,'k');
title(['Kernel of order ',num2str(n),',',num2str(k),' and smoothness ',num2str(m-1)]);
if [n,k,m]==[0,2,0]
   text(.25,.6,'Rectangle kernel');
end;
if [n,k,m]==[0,2,1]
   text(.4,.75,'Epanechnik kernel');
end;
if [n,k,m]==[0,2,2]
   text(.4,.75,'Kvartic kernel');
end;

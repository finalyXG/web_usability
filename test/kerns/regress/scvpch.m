function[hmin,gcvmin,hh,gcv,trs]=scvpch(x,y,n,k,mm,C);
%SCVPCH  estimation of optimal bandwidth for Pristley - Chao estimator
%        by using Shibata's penalizing function
%
%[hmin,acvmin]=scvpch(x,y,n,k,m,C) 
%       hmin ..... estimated value of optimal bandwidth
%       acvmin ... the value of error function in hmin
%       [x,y] .... data set
%       [n,k] .... order of used kernel
%        m ....... the smoothness of used kernel
%        C ....... figure handle for the error function plot (optional: default=[]=no plot)
%                  C+1 - figure handle for the penalizing function plot
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

if nargin>=5
gcv=[];hh=[];trs=[];
nn=length(y);
h=k/nn;v5colset;hm=h;
wai=waitbar(0,['Computing optimal h for kernel of order (',num2str(n),',',num2str(k),') ...']);
hx=k/14+.3;%skok=(hx-h)/100;
while h<hx
   S=pch(x,y,n,k,mm,h);
   if ~isempty(S)
   m=y*S;
   tr=trace(S);
   gcv1=(y-m)*(y-m)'*(1+2*tr/nn)/nn;
   gcv=[gcv,gcv1];hh=[hh,h];tr=1+2*tr/nn;
   trs=[trs,tr];
   end;
   h=h+0.01;waitbar((h-hm)/(hx-hm));
end;
close(wai);%v4colset;
[gcvmin,l]=min(gcv);
hmin=hh(l);
end;
if nargin==6
   figure(C);
plot(hh,gcv,'r');
xlabel('h');
ylabel('SCV');
title('Shibata error function for PCH estimator');
figure(C+1);
plot(hh,trs,'b');
title('Shibata penalizing function for PCH estimator');
end;


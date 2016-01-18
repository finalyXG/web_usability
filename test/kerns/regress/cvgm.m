function[hmin,gcvmin,hh,gcv]=cvgm(x,y,n,k,mm,C);
%CVGM   estimation of optimal bandwidth of Gasser - Mueller estimator
%       by using classic cross-validation
%
%[hmin,acvmin]=cvgm(x,y,n,k,m,C) 
%       hmin ..... estimated value of optimal bandwidth
%       acvmin ... the value of error function in hmin
%       [x,y] .... data set
%       [n,k] .... order of used kernel
%        m ....... the smoothness of used kernel
%        C ....... figure handle for the error function plot (optional: default=[]=no plot)
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

if nargin>=5
gcv=[];hh=[];trs=[];
nn=length(y);
h=k/nn;v5colset;hm=h;
wai=waitbar(0,['Computing optimal h for kernel of order (',num2str(n),',',num2str(k),') ...']);
hx=k/14+.3;
while h<hx
   S=gm(x,y,n,k,mm,h);
   if ~isempty(S)
   m=y*S;
   tr=trace(S);
   gcv1=((y-m)./(1-diag(S'))')*((y-m)./(1-diag(S'))')'/nn;
   gcv=[gcv,gcv1];hh=[hh,h];
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
ylabel('CV');
title('Classic cross-validation function for GM estimator');
end;
function[hmin,gcvmin,hh,gcv]=cvnw(x,y,n,k,mm,C,L);
%CVNW   estimation of optimal bandwidth of Nadaraya - Watson estimator
%       by using classic leave-(2L+1)-out cross-validation
%
%[hmin,acvmin]=cvnw(x,y,n,k,m,C,L) 
%       hmin ..... estimated value of optimal bandwidth
%       acvmin ... the value of error function in hmin
%       [x,y] .... data set
%       [n,k] .... order of used kernel
%        m ....... the smoothness of used kernel
%        C ....... figure handle for the error function plot (optional: default=0=no plot)
%        L ....... how much points (2L+1) will be leave-out (optional: default=0=L)
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

if nargin<7
    L=0;
end
if nargin>=5
gcv=[];hh=[];trs=[];
nn=length(y);
h=k/nn;v5colset;hm=h;
wai=waitbar(0,['Computing optimal h for kernel of order (',num2str(n),',',num2str(k),') ...']);
hx=k/14+.3;
while h<hx
   S=nw(x,y,n,k,mm,h);
   Sp=tril(S',L)-tril(S',-L-1);
   sSp=sum(Sp');krit=sum(sSp==1);
   if (~isempty(S))&(krit<1)
       yy=ones(nn,1)*y;
       yiy=yy';
       a1=triu(yy,L+1)+tril(yy,-L-1);
       a2=tril(yiy,L)-tril(yiy,-L-1);
       yy=a1+a2;
   m=diag(yy*S)';
   gcv1=((y-m)./(1-sSp))*((y-m)./(1-sSp))'/nn;
   gcv=[gcv,gcv1];hh=[hh,h];
   end;
   h=h+0.01;waitbar((h-hm)/(hx-hm));
end;
close(wai);%v4colset;
[gcvmin,l]=min(gcv);
hmin=hh(l);
end;
if (nargin>5)&(C~=0)
   figure(C);
plot(hh,gcv,'r');
xlabel('h');
ylabel('CV');
title('Classic cross-validation function for NW estimator');
end;

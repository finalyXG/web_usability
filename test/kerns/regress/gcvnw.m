function[hmin,gcvmin,hh,gcv,trs]=gcvnw(x,y,n,k,mm,C,L);
%GCVNW  estimation of optimal bandwidth of Nadaraya - Watson estimator
%       by using generalized leave-(2L+1)-out cross-validation
%
%[hmin,acvmin]=gcvnw(x,y,n,k,m,C) 
%       hmin ..... estimated value of optimal bandwidth
%       acvmin ... the value of error function in hmin
%       [x,y] .... data set
%       [n,k] .... order of used kernel
%        m ....... the smoothness of used kernel
%        C ....... figure handle for the error function plot (optional: default=0=no plot)
%                  C+1 - figure handle for the penalizing function plot
%        L ....... how much points (2L+1) will be leave-out (optional:
%                  default=0=L)
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
NN=nn+(2*nn-1)*L-L^2;
while h<hx
   S=nw(x,y,n,k,mm,h);
   Sp=tril(S',L)-tril(S',-L-1);
   krit=sum(sum(abs(Sp)>1e-10));
   sSp=sum(Sp');tr=sum(sSp);%sum(sum(sSp~=0))
   if (~isempty(S))&(krit==NN)
       yy=ones(nn,1)*y;
       yiy=yy';
       a1=triu(yy,L+1)+tril(yy,-L-1);
       a2=tril(yiy,L)-tril(yiy,-L-1);
       yy=a1+a2;
   m=diag(yy*S)';
%   tr=trace(S);
   gcv1=((y-m)/(1-tr/NN))*((y-m)/(1-tr/NN))'/nn;
   gcv=[gcv,gcv1];hh=[hh,h];tr=1/((1-tr/NN)*(1-tr/NN));
   trs=[trs,tr];
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
ylabel('GCV');
title('Generalized cross-validation for NW estimator');
figure(C+1);
plot(hh,trs,'b');
title('GCV penalizing function for NW estimator');
end;

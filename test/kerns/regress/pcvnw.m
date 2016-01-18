function[hmin,gcvmin,hh,gcv]=pcvnw(x,y,n,k,mm,C,L);
%CVNW   estimation of optimal bandwidth of Nadaraya - Watson estimator
%       by using classic cross-validation with splitting the observations
%       into L subgroups
%
%[hmin,acvmin]=pcvnw(x,y,n,k,m,C,L) 
%       hmin ..... estimated value of optimal bandwidth
%       acvmin ... the value of error function in hmin
%       [x,y] .... data set
%       [n,k] .... order of used kernel
%        m ....... the smoothness of used kernel
%        C ....... figure handle for the error function plot (optional: default=0=no plot)
%        L ....... how much subgroups will be taken (optional: default=1=L)
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

if nargin<7
    L=1;
end
if nargin>=5
gcv=[];hh=[];trs=[];gcv1=[];tri=[];
nn=floor(length(y)/L)*L;
x=x(1:nn);y=y(1:nn);
N=nn/L;
X=reshape(x,L,N);
Y=reshape(y,L,N);
h=k/N;v5colset;hm=h;
wai=waitbar(0,['Computing optimal h for kernel of order (',num2str(n),',',num2str(k),') ...']);
hx=k/14+.3;
while h<hx
    for i=1:L
        S=nw(X(i,:),Y(i,:),n,k,mm,h);
        if ~isempty(S)
            m=Y(i,:)*S;
            tr=trace(S);
            gcv1(i)=((Y(i,:)-m)/(1-tr/N))*((Y(i,:)-m)/(1-tr/N))'/N;
            %tri(i)=1/((1-tr/N)*(1-tr/N)');
        end;
    end;
    gcv1(gcv1==0)=[];
    %tri(tri==0)=[];
    if ~isempty(gcv1)
        gcv=[gcv,mean(gcv1)];hh=[hh,h];
        %trs=[trs,mean(tri)];
    end;
    h=h+0.01;waitbar((h-hm)/(hx-hm));
end;
close(wai);%%v4colset;
hh=hh*L^(-1/(2*k+1));
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

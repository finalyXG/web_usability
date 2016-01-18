function[hmin,gmin,hhpin,fpin,EMSE,I]=plugin(x,y,n,k,mm,c,C);
%PLUGIN   estimation of optimal bandwidth
%         by using plug-in method
%
%[hmin,acvmin]=plugin(x,y,n,k,m,c,C) 
%       hmin ..... estimated value of optimal bandwidth
%       acvmin ... the value of error function in hmin
%       [x,y] .... data set
%       [n,k] .... order of used kernel
%        m ....... the smoothness of used kernel
%        c ....... constant, sets a treshold (optional: default=2)
%        C ....... figure handle for the error function plot (optional: default=[]=no plot)
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

if nargin<=5
   c=1;
end;

EMSE=[];hh=[];
T=length(x);
[K,beta,delta,V]=jadro(n,k,mm);

%%%%%%%%%%%%%%%%%%%%
yres=y(2:T)-y(1:T-1);
sigodh=yres(:)'*yres(:)/(2*T-2); %odhad sigma^2
ind=round((T-1)/2);
yf=abs(fft(y)).^2/(2*pi*T);
yf(1)=[];yf=yf(1:ind);
%c*sigodh/(2*pi)
hodh=T^(-1/(2*k+1));
hodh=k/T;

kch=k+2;
P=(0.001*prod(1:kch))^(1/kch)/(2*pi*hodh);
P=round(P)+1;
J=find(yf<c*sigodh/(2*pi));%JJ=J;J(1:3)
while isempty(J)
   c=c+.5;
   J=find(yf<c*sigodh/(2*pi));
end;
st=1;
if J(1)==1
   J=min(find(yf>c*sigodh/(2*pi)))+1;
   P=J;st=J-1;
end;
%P=J(1);
J=max(min(J(1),P),2)-1; %,J=1
yfnew=yf;yfnew(J:end)=sigodh/(2*pi);
%yfnew=yf;
tt=st:J;
vect=(2*pi*tt).^(2*k).*(yf(tt)-sigodh/(2*pi));
I=4*pi*sum(vect)/(T*1);

%%%%%%%%%%%%%%%%%
%%%xpom=x;
%%x=sym('x');
%f='12*sin(11*x+5)/2/cot(6-x+1)';
%%f(findstr(f,'.'))=[];
%%vyraz=diff(f,k)
%%I=int(vyraz^2,-1,1);
%%double(I)
%%x=xpom;break
%%%%%%%%%%%%%%%%%%%%

h=k/T:.01:k/14+.3;
EMSE=sigodh*V./(T*h)+(h.^k*beta/prod(1:k)).^2*I; %plug-in MSE

[gmin,l]=min(EMSE);
L=min(2*l,length(h));

hhpin=h(1:L);
fpin=EMSE(1:L);
hmin=(sigodh*V*(prod(1:k)^2)/(2*T*k*I*beta^2))^(1/(2*k+1));
if ~isreal(hmin)
    hmin=real(hmin);
   %sigodh,V,I,beta^2,pause
end;

if nargin==7
   figure(C);
%   plot(hh,mRSSNW,'--');hold on;
   plot(hhpin,fpin,'r');
   xlabel('h');
   ylabel('MSE');
   title('Plug-in error function');
end;

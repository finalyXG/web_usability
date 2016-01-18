function[r,x,F1,xx1,F2,xx2,KS,Gini,AUC]=roc(x1,x2,C)
%spocita a vykresli ROC krivku
x1=x1(:)';x2=x2(:)';
% if min(x1)>min(x2)
%     if max(x1)<max(x2)
%         error('co to je za kravsky data?');
%     end;
%     z=x1;
%     x1=x2;
%     x2=z;
% end;

xsmes=[x1,x2];

KK=K_def('epan');
h1=h_F(x1,KK);
h2=h_F(x2,KK);h=max([h1,h2]);
xx=linspace(min(xsmes)-h,max(xsmes)+h); %tady jsem pridal -h1,+h2
%   h1=1;h2=1;
[F1,xx1]=ksF(x1,0,2,1,h1,xx);%keyboard;
[F2,xx2]=ksF(x2,0,2,1,h2,xx);%keyboard;
%F1,F2
x=1-F1;
r=1-F2;

KS=max(abs(F1-F2));
xstep=x(1:end-1)-x(2:end);
AUC=sum((r(1:end-1)+r(2:end))/2.*xstep);
Gini=2*AUC-1;

if nargin==3
figure(C);
    plot(1-F1,1-F2);
hold on;
%empiricky:
% [ni,nx]=hist(xsmes,30);
% nxd=nx(2)-nx(1);
% nx=[-Inf,nx-nxd/2,nx(end)+nxd/2,Inf];
% ni1=histc(x1,nx);
% ni2=histc(x2,nx);
% F1emp=cumsum(ni1)/length(x1);
% F2emp=cumsum(ni2)/length(x2);
% plot(1-F1emp,1-F2emp,'x');
plot([0 1],[0 1],'k:')
end;

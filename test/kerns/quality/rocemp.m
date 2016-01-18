function[r,x,F1emp,F2emp,nx,KS,Gini,AUC]=rocemp(x1,x2,C)
%spocita a vykresli empirickou ROC krivku
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

[ni,nx]=hist(xsmes,1000);
nxd=nx(2)-nx(1);
nx=[-Inf,nx-nxd/2,nx(end)+nxd/2,Inf];
ni1=histc(x1,nx);
ni2=histc(x2,nx);
F1emp=cumsum(ni1)/length(x1);
F2emp=cumsum(ni2)/length(x2);

% alternativni postup podle HomeCredit
% uu=linspace(min(xsmes),max(xsmes),1003);
% F1 = EmpCDF(x1',uu);
% F2 = EmpCDF(x2',uu);

%plot(uu,F1emp,uu,F2emp);pause;

x=1-F1emp;
r=1-F2emp;

KS=max(abs(F1emp-F2emp));
xstep=x(1:end-1)-x(2:end);
AUC=sum((r(1:end-1)+r(2:end))/2.*xstep);
Gini=2*AUC-1;

if nargin==3
figure(C);
plot(1-F1emp,1-F2emp);
hold on;
plot([0 1],[0 1],'k:')
%plot(1-F1,1-F2,'r');
end;

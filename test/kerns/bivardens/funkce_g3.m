function[y]=funkce_g3(Xi,ny,k,mi,h1,h2)
% auxiliary function for KSBIVARDENS toolbox (condition 2)
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

[dim,n]=size(Xi);

if dim~=2
    error('The dimension should be 2!');
end

X1=Xi(1,:);
X2=Xi(2,:);
[XX1,YY1]=meshgrid(X1,X1);
d1=(YY1-XX1)/h1;
[XX2,YY2]=meshgrid(X2,X2);
d2=(YY2-XX2)/h2;

jmeno=['konvyder',num2str(k),num2str(mi),'.mat'];

if exist(jmeno,'file')
    load(jmeno);
else
    [C,supp_C]=kernconv(ny,k,mi,2,'jirka');
    [D,supp_D]=kernconv2der(ny,k,mi);
    save(jmeno,'C','supp_C','D','supp_D');
end

delka_C=supp_C(:,2)-supp_C(:,1);
stred_C=(supp_C(:,2)+supp_C(:,1))/2;
delka_D=supp_D(:,2)-supp_D(:,1);
stred_D=(supp_D(:,2)+supp_D(:,1))/2;

zaokr=1e+12;    % pocet mist pro zaokrouhlovani
%d1=round(zaokr*d1)/zaokr;
%d2=round(zaokr*d2)/zaokr;
%d1-stred_D(1)
%abs(d1-stred_C(1))<=(delka_C(1))/2
%abs(d1-stred_C(2))<=delka_C(2)/2

C1=polyval(C(1,:),d1).*(abs(d1-stred_C(1))<=delka_C(1)/2)+polyval(C(2,:),d1).*(abs(d1-stred_C(2))<=delka_C(2)/2);
C1=C1-diag(diag(C1))/2; %sparse(C1)  %nove
D1=polyval(D(1,:),d1).*(abs(d1-stred_D(1))<=delka_D(1)/2)+polyval(D(2,:),d1).*(abs(d1-stred_D(2))<=delka_D(2)/2);
D1=D1-diag(diag(D1))/2; %sparse(C1)  %nove

C2=polyval(C(1,:),d2).*(abs(d2-stred_C(1))<=delka_C(1)/2)+polyval(C(2,:),d2).*(abs(d2-stred_C(2))<=delka_C(2)/2);
C2=C2-diag(diag(C2))/2;  %nove
D2=polyval(D(1,:),d2).*(abs(d2-stred_D(1))<=delka_D(1)/2)+polyval(D(2,:),d2).*(abs(d2-stred_D(2))<=delka_D(2)/2);
D2=D2-diag(diag(D2))/2;  %nove

% max(max(abs(d1))), max(max(abs(d2)))
y= sum(sum(C1.*D2))-sum(sum(D1.*C2));
% y=sum(sum(C1.*D2))/sum(sum(D1.*C2)); 
% y=y^(1/4)*h1/h2;
%y=y/(10*n);


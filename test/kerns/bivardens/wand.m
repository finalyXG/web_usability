function[H,c]=wand(X)
%WAND estimates a bandwidth matrix from a covariance matrix
%     see Wand,Jones; Kernel Smoothing (1995) - Exercise 4.7.
%
%     H = wand(X)
%       X......... matrix of observations
%       H......... bandwidth matrix
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

[dim,n]=size(X);

S=cov(X');
H=n^(-2/(dim+4))*S*(4/(dim+2))^(2/(dim+4)); 

X=X';
v1=var(X);
% v2=mad(X);        % jine robustnejsi odhady rozptylu
% v3=mad(X,1);
% v4=iqr(X);
% vv=[v1;v2;v3;v4];
% [vmin,ind]=min(vv(:,1)./vv(:,2));
% v=vv(ind,:);
c=v1(1)/v1(2);
%c=v3(1)/v3(2);

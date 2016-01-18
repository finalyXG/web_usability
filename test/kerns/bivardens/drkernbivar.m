function[]=drkernbivar(style,n,k,m)
%DRKERNBIVAR  draws the bivariate kernel of order (n,k) and smoothness m
%
%  drkernbivar(style,n,k,m) 
%       style .... style of kernel ('gaus','prod','sphe')
%       [n,k] .... order of kernel
%        m ....... the smoothness of used kernel
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

if nargin < 1
    style='gaus';
end
Cfig=figure;
    C = get(Cfig,'Number');
    if ischar(C)
        C = Cfig;
    end

switch style
    case 'gaus'
        x=linspace(-3,3);
        X=[x;x];        
        gausskern(X,C);
        tit='Gaussian';
        titul=[tit,' kernel'];
    case 'prod'
        x=linspace(-1.2,1.2);
        X=[x;x];
        productkern(n,k,m,X,C);
        tit='Product';
        titul=[tit,' kernel of order (',num2str(n),',',num2str(k),',',num2str(m-1),')'];
    case 'sphe'
        x=linspace(-1.1,1.1);
        X=[x;x];
        spherickern(n,k,m,X,C);
        tit='Spherically symmetric';
        titul=[tit,' kernel of order (',num2str(n),',',num2str(k),',',num2str(m-1),')'];        
    otherwise
        error('The style should be ''gaus'',''prod'' or ''sphe''.');
end
set(C,'Units','normalized');
set(C+1,'Units','normalized');
pos=get(C,'Position');
set(C,'Position',[0.1 pos(2) pos(3) pos(4)]);
set(C+1,'Position',[0.11+pos(3) pos(2) pos(3) pos(4)]);
figure(C);
title(titul);
figure(C+1);
title([titul,' - contour plot']);

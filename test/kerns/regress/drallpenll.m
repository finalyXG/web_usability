%DRALLPENLL  draws all penalizing functions for selection of optimal bandwidth for
%            local - linear estimator
%
%     Use only in procedure KERN
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

Invec=Inmat(1:7,2);
hhcv=char('hhg2','hha2','hhfp2','hhs2','hhr2','hhf2','hhk2');
hodcv=char('gtr2','atr2','fptr2','str2','rtr2','ftr2','ktr2');
namecv=char('gcv','acv','fpecv','scv','rcv','fcv','kcv');
symb=char('**','--','-.-. ','....  ','_ _','__','.... ');
zpus=char('r*','g:','b-.','y.','m--','c-','k');
barvy=char('r','g','b','y','m','c','k');

indll=find((1:7).*Invec');
figure;
title('Penalizing functions dependence on h for LL estimator');
hold on;
for i=indll
   hacka=eval(hhcv(i,:));
   hod=eval(hodcv(i,:));
   plot(hacka,hod,zpus(i,:));
uicontrol('Style','push','Units','normalized', ...
          'Position',[.4,.9-i*.03,.03,.03], ...
          'Callback',['pom=get(gcbo,''Position'');close;',...
          'j=round((-pom(2)+.9)/.03);Inmat(j,2)=0;jj=j;drallpenll;'],...
          'BackgroundColor',[.8,0.8,0.8], ...
          'String','x');   
   
uicontrol( ...
     	  'Style','text', ...
        'Units','normalized', ...
        'Backgroundcolor','white',...
        'ForegroundColor',barvy(i),...
        'Position',[.3,.9-i*.03,.1,.03], ...
        'String',[symb(i,:),namecv(i,:)]);
   
    end;

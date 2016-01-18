%DRALLPENPCH  draws all penalizing functions for selection of optimal bandwidth for
%             Pristley - Chao estimator
%
%     Use only in procedure KERN
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

Invec=Inmat(1:7,4);
hhcv=char('hhg4','hha4','hhfp4','hhs4','hhr4','hhf4','hhk4');
hodcv=char('gtr4','atr4','fptr4','str4','rtr4','ftr4','ktr4');
namecv=char('gcv','acv','fpecv','scv','rcv','fcv','kcv');
symb=char('**','--','-.-. ','....  ','_ _','__','.... ');
zpus=char('r*','g:','b-.','y.','m--','c-','k.');
barvy=char('r','g','b','y','m','c','k');

indgm=find((1:7).*Invec');
figure;
title('Penalizing functions dependence on h for PCH estimator');
hold on;
for i=indgm
   hacka=eval(hhcv(i,:));
   hod=eval(hodcv(i,:));
   plot(hacka,hod,zpus(i,:));
uicontrol('Style','push','Units','normalized', ...
          'Position',[.4,.9-i*.03,.03,.03], ...
          'Callback',['pom=get(gcbo,''Position'');close;',...
          'j=round((-pom(2)+.9)/.03);Inmat(j,3)=0;jj=j;drallpengm;'],...
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

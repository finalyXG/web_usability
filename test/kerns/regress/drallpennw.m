%DRALLPENNW  draws all penalizing functions for selection of optimal bandwidth for
%            Nadaraya - Watson estimator
%
%     Use only in procedure KERN
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

Invec=Inmat(1:7,1);
hhcv=char('hhg1','hha1','hhfp1','hhs1','hhr1','hhf1','hhk1');
hodcv=char('gtr1','atr1','fptr1','str1','rtr1','ftr1','ktr1');
namecv=char('gcv','acv','fpecv','scv','rcv','fcv','kcv');
symb=char('**','--','-.-. ','....  ','_ _','__','- ');
zpus=char('r*','g:','b-.','y.','m--','c-','k');
barvy=char('r','g','b','y','m','c','k');

indnw=find((1:7).*Invec');
figure;
title('Penalizing functions dependence on h for NW estimator');
hold on;
for i=indnw
   hacka=eval(hhcv(i,:));
   hod=eval(hodcv(i,:));
   plot(hacka,hod,zpus(i,:));
uicontrol('Style','push','Units','normalized', ...
          'Position',[.4,.9-i*.03,.03,.03], ...
          'Callback',['pom=get(gcbo,''Position'');close;',...
          'j=round((-pom(2)+.9)/.03);Inmat(j,1)=0;jj=j;drallpennw;'],...
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

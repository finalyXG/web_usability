%DRALLPCH  draws all error functions for selection of optimal bandwidth for
%          Pristley - Chao estimator
%
%     Use only in procedure KERN
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)


Invec=Inmat(:,4);
hhcv=char('hhg4','hha4','hhfp4','hhs4','hhr4','hhf4','hhk4','hhch4','hhsig4','hhmse','hhcv4','hhplugin');
hodcv=char('gcv4','acv4','fpcv4','scv4','rcv4','fcv4','kcv4','chcv4','sigcv4','fmse','cv4','fplugin');
namecv=char('gcv','acv','fpe','scv','rcv','fcv','kcv','chi','sig','mse','CV','pin');
symb=char('**','- -','-.-. ','....  ','_ _','__','__ ','-.-.','__','--','__','--');
zpus=char('r*','g:','b-.','y.','m--','c-','k','b-.','g','r','y','c--');
barvy=char('r','g','b','y','m','c','k','b','g','r','y','c');

indpch=find((1:12).*Invec');
figure;
title('CV dependence on h for PCH estimator');
hold on;
for i=indpch
   hacka=eval(hhcv(i,:));
   hod=eval(hodcv(i,:));[kk,l]=min(hod);
   plot(hacka,hod,zpus(i,:));plot(hacka(l),kk,'o');
uicontrol('Style','push','Units','normalized', ...
          'Position',[.4,.9-i*.03,.03,.03], ...
          'Callback',['pom=get(gcbo,''Position'');close;',...
          'j=round((-pom(2)+.9)/.03);Inmat(j,4)=0;jj=j;drallpch;'],...
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

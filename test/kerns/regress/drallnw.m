%DRALLNW  draws all error functions for selection of optimal bandwidth for
%         Nadaraya - Watson estimator
%
%     Use only in procedure KERN
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)


Invec=Inmat(:,1);
hhcv=char('hhg1','hha1','hhfp1','hhs1','hhr1','hhf1','hhk1','hhch1','hhsig1','hhmse','hhcv1','hhplugin');
hodcv=char('gcv1','acv1','fpcv1','scv1','rcv1','fcv1','kcv1','chcv1','sigcv1','fmse','cv1','fplugin');
namecv=char('gcv','acv','fpe','scv','rcv','fcv','kcv','chi','sig','mse','CV','pin');
symb=char('**','- -','-.-. ','....  ','_ _','__','__ ','-.-.','__','--','__','--');
zpus=char('r*','g:','b-.','y.','m--','c-','k','b-.','g','r','y','c--');
barvy=char('r','g','b','y','m','c','k','b','g','r','y','c');

indnw=find((1:12).*Invec');
figure;
title('CV dependence on h for NW estimator');
hold on;
for i=indnw
   hacka=eval(hhcv(i,:));
   hod=eval(hodcv(i,:));[kk,l]=min(hod);
   plot(hacka,hod,zpus(i,:));plot(hacka(l),kk,'o');
uicontrol('Style','push','Units','normalized', ...
          'Position',[.4,.9-i*.03,.03,.03], ...
          'Callback',['pom=get(gcbo,''Position'');close;',...
          'j=round((-pom(2)+.9)/.03);Inmat(j,1)=0;jj=j;drallnw;'],...
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

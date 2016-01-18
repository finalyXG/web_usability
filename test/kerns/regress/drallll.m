%DRALLLL  draws all error functions for selection of optimal bandwidth for
%         local - linear estimator
%
%     Use only in procedure KERN
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)


Invec=Inmat(:,2);
hhcv=char('hhg2','hha2','hhfp2','hhs2','hhr2','hhf2','hhk2','hhch2','hhsig2','hhmse','hhcv2','hhplugin');
hodcv=char('gcv2','acv2','fpcv2','scv2','rcv2','fcv2','kcv2','chcv2','sigcv2','fmse','cv2','fplugin');
namecv=char('gcv','acv','fpe','scv','rcv','fcv','kcv','chi','sig','mse','CV','pin');
symb=char('**','- -','-.-. ','....  ','_ _','__','__ ','-.-.','__','--','__','--');
zpus=char('r*','g:','b-.','y.','m--','c-','k','b-.','g','r','y','c--');
barvy=char('r','g','b','y','m','c','k','b','g','r','y','c');

indll=find((1:12).*Invec');
figure;
title('CV dependence on h for LL estimator');
hold on;
for i=indll
   hacka=eval(hhcv(i,:));
   hod=eval(hodcv(i,:));[kk,l]=min(hod);
   plot(hacka,hod,zpus(i,:));plot(hacka(l),kk,'o')
uicontrol('Style','push','Units','normalized', ...
          'Position',[.4,.9-i*.03,.03,.03], ...
          'Callback',['pom=get(gcbo,''Position'');close;',...
          'j=round((-pom(2)+.9)/.03);Inmat(j,2)=0;jj=j;drallll;'],...
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

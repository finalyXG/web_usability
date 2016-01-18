%DRALLGM  draws all error functions for selection of optimal bandwidth for
%         Gasser - Mueller estimator
%
%     Use only in procedure KERN
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

Invec=Inmat(:,3);
hhcv=char('hhg3','hha3','hhfp3','hhs3','hhr3','hhf3','hhk3','hhch3','hhsig3','hhmse','hhcv3','hhplugin');
hodcv=char('gcv3','acv3','fpcv3','scv3','rcv3','fcv3','kcv3','chcv3','sigcv3','fmse','cv3','fplugin');
namecv=char('gcv','acv','fpe','scv','rcv','fcv','kcv','chi','sig','mse','CV','pin');
symb=char('**','- -','-.-. ','....  ','_ _','__','__ ','-.-.','__','--','__','--');
zpus=char('r*','g:','b-.','y.','m--','c-','k','b-.','g','r','y','c--');
barvy=char('r','g','b','y','m','c','k','b','g','r','y','c');

indgm=find((1:12).*Invec');
figure;
title('CV dependence on h for GM estimator');
hold on;
for i=indgm
   hacka=eval(hhcv(i,:));
   hod=eval(hodcv(i,:));[kk,l]=min(hod);
   plot(hacka,hod,zpus(i,:));plot(hacka(l),kk,'o');
uicontrol('Style','push','Units','normalized', ...
          'Position',[.4,.9-i*.03,.03,.03], ...
          'Callback',['pom=get(gcbo,''Position'');close;',...
          'j=round((-pom(2)+.9)/.03);Inmat(j,3)=0;jj=j;drallgm;'],...
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

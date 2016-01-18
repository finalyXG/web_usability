function[]=HAZARD_eye;
%HAZARD_eye  "eye" method for selection of smoothing parameter
%         for kernel hazard function estimates
%
% (C) Jiri Zelinka, Jan Kolacek, Masaryk University (Czech Republic)


eyefighndl=figure( ...
	'Visible','on', ...
	'Tag','HAZARD_eyefig', ...
	'Name','"Eye" method', ...
        'NumberTitle','off');

axes( ...
        'Units','normalized', ...
        'Position',[0.08 0.08 0.75 0.87]);

% take data and kernel
sf=findobj('Tag','HAZARD_setting');udata=get(sf,'UserData');K=udata.K;
mf=findobj('Tag','HAZARD_MAIN');udata_m=get(mf,'UserData');X=udata_m.X;d=udata_m.d;
xx=udata_m.xx; bounds=udata_m.bounds;
nX=length(X);
h0=round(500*(bounds(2)-bounds(1))/nX)/100;
hstep=h0/10;
handles=struct('runHndl',[],'stopHndl',[],'leftHndl',[],'rightHndl',[],'drawHndl',[],'h0Hndl',[],'stepHndl',[],'usehHndl',[]);
eyedata=struct('K',K,'X',X,'d',d,'xx',xx,'h0',h0,'hstep',hstep,'handles',handles);
set(eyefighndl,'UserData',eyedata);

lam_est=K_hafest(X,d,K,xx,h0);
figure(eyefighndl);
plot(xx,lam_est);

% if ff==1 hold on;plot(t,fx,rr);end;
     

% The CONSOLE frame
    uicontrol( ...
        'Style','frame', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.86,0,.15,1], ...
        'BackgroundColor',[0.50 0.50 0.50]);



% The run button
  callrunStr1='ef=findobj(''Tag'',''HAZARD_eyefig'');udata=get(ef,''UserData'');K=udata.K;xx=udata.xx;X=udata.X;d=udata.d;h0hndl=findobj(''Tag'',''EYE_h0Hndl'');h0s=get(h0hndl,''String'');h0=eval(h0s);stephndl=findobj(''Tag'',''EYE_stepHndl'');step_s=get(stephndl,''String'');step=eval(step_s);'; 
  callrunStr2='if h0<=0, HAZARD_warning(''The bandwidth have to be positive. Correction was made, please check the parameters again.'');if h0<0, h0=-h0;else,h0=round(500*(max(X)-min(X))/length(X))/100;end;set(h0hndl,''String'',num2str(h0));set(h0hndl,''UserData'',h0);';
  callrunStr3='elseif step<=0, HAZARD_warning(''The step have to be positive. Correction was made, please check the parameters again.''); step=h0/10;set(stephndl,''String'',num2str(step));';
  callrunStr4='else, set(gcbo,''Enable'',''off'');stophndl=findobj(''Tag'',''EYE_stopHndl''); set(stophndl,''Enable'',''On'');righthndl=findobj(''Tag'',''EYE_rightHndl''); set(righthndl,''Enable'',''Off'');lefthndl=findobj(''Tag'',''EYE_leftHndl''); set(lefthndl,''Enable'',''Off'');drawhndl=findobj(''Tag'',''EYE_drawHndl''); set(drawhndl,''Enable'',''Off'');';
  callrunStr5='stop=0; while stop==0 && h0<(max(X)-min(X)), h0=h0+step;lam_est=K_hafest(X,d,K,xx,h0);figure(ef);plot(xx,lam_est);pause(1);stop=get(stophndl,''UserData'');set(h0hndl,''String'',num2str(h0));set(h0hndl,''UserData'',h0);end;';
  callrunStr6='set(gcbo,''Enable'',''On''); set(stophndl,''Enable'',''Off'');set(stophndl,''UserData'',0); set(righthndl,''Enable'',''On'');set(lefthndl,''Enable'',''On'');set(drawhndl,''Enable'',''On'');end;';
  runHndl=uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
	'Tag','EYE_runHndl', ...
	'TooltipString','Draws estimates by steps', ...
        'FontUnits','normalized',...
        'Position',[0.88,.89,.05,0.05], ...
        'String','->>', ...
        'Callback',[callrunStr1,callrunStr2,callrunStr3,callrunStr4,callrunStr5,callrunStr6]);
handles.runHndl=runHndl;

% The stop button
  callstopStr1='set(gcbo,''UserData'',1); ';
  stopHndl=uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.94,.89,.05,0.05], ...
	'TooltipString','Stops drawing the estimates', ...
	'Tag','EYE_stopHndl', ...
        'String','Stop', ...
        'UserData',0, ...
        'Enable','off',...
        'Callback',callstopStr1);
handles.stopHndl=stopHndl;

% The <- button
    callleftStr1='ef=findobj(''Tag'',''HAZARD_eyefig'');udata=get(ef,''UserData'');K=udata.K;xx=udata.xx;X=udata.X;d=udata.d;h0hndl=findobj(''Tag'',''EYE_h0Hndl'');h0s=get(h0hndl,''String'');h0=eval(h0s);stephndl=findobj(''Tag'',''EYE_stepHndl'');step_s=get(stephndl,''String'');step=eval(step_s);'; 
    callleftStr2='if h0<=0, HAZARD_warning(''The bandwidth have to be positive. Correction was made, please check the parameters again.'');if h0<0, h0=-h0;else,h0=round(500*(max(X)-min(X))/length(X))/100;end;set(h0hndl,''String'',num2str(h0));set(h0hndl,''UserData'',h0);';
    callleftStr3='elseif step<=0 || step>h0, HAZARD_warning(''The step have to be positive and less then bandwidth. Correction was made, please check the parameters again.''); step=h0/10;set(stephndl,''String'',num2str(step));';
    callleftStr4='else, h0=h0-step;set(h0hndl,''String'',num2str(h0));set(h0hndl,''UserData'',h0);lam_est=K_hafest(X,d,K,xx,h0);figure(ef);plot(xx,lam_est);end;';
    leftHndl=uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'Position',[0.88,.83,.03,0.05], ...
        'String','<-', ...
	'TooltipString','Draw estimate for h0-step', ...
        'FontUnits','normalized',...
        'FontSize',0.4,...
	'Tag','EYE_leftHndl', ...
        'Callback',[callleftStr1,callleftStr2,callleftStr3,callleftStr4]);
handles.leftHndl=leftHndl;

% The Draw button
    calldrawStr1='ef=findobj(''Tag'',''HAZARD_eyefig'');udata=get(ef,''UserData'');K=udata.K;xx=udata.xx;X=udata.X;d=udata.d;h0hndl=findobj(''Tag'',''EYE_h0Hndl'');h0s=get(h0hndl,''String'');h0=eval(h0s);'; 
    calldrawStr2='if h0<=0, HAZARD_warning(''The bandwidth have to be positive. Correction was made, please check the parameters again.'');if h0<0, h0=-h0;else,h0=round(500*(max(X)-min(X))/length(X))/100;end;';
    calldrawStr3='set(h0hndl,''String'',num2str(h0));set(h0hndl,''UserData'',h0);else,lam_est=K_hafest(X,d,K,xx,h0);figure(ef);plot(xx,lam_est);end;';
    drawHndl=uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'Position',[0.91,.83,.05,0.05], ...
	'TooltipString','Draw estimate for h0', ...
        'String','Draw', ...
        'FontUnits','normalized',...
        'FontSize',0.4,...
	'Tag','EYE_drawHndl', ...
        'Callback',[calldrawStr1,calldrawStr2,calldrawStr3]);
handles.drawHndl=drawHndl;

% The -> button
    callrightStr1='ef=findobj(''Tag'',''HAZARD_eyefig'');udata=get(ef,''UserData'');K=udata.K;xx=udata.xx;X=udata.X;d=udata.d;h0hndl=findobj(''Tag'',''EYE_h0Hndl'');h0s=get(h0hndl,''String'');h0=eval(h0s);stephndl=findobj(''Tag'',''EYE_stepHndl'');step_s=get(stephndl,''String'');step=eval(step_s);'; 
    callrightStr2='if h0<=0, HAZARD_warning(''The bandwidth have to be positive. Correction was made, please check the parameters again.'');if h0<0, h0=-h0;else,h0=round(500*(max(X)-min(X))/length(X))/100;end;set(h0hndl,''String'',num2str(h0));set(h0hndl,''UserData'',h0);';
    callrightStr3='elseif step<=0, HAZARD_warning(''The step have to be positive. Correction was made, please check the parameters again.''); step=h0/10;set(stephndl,''String'',num2str(step));';
    callrightStr4='else, h0=h0+step;set(h0hndl,''String'',num2str(h0));set(h0hndl,''UserData'',h0);lam_est=K_hafest(X,d,K,xx,h0);figure(ef);plot(xx,lam_est);end;';
    rightHndl=uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'Position',[0.96,.83,.03,0.05], ...
	'Tag','EYE_rightHndl', ...
	'TooltipString','Draw estimate for h0+step', ...
        'FontUnits','normalized',...
        'FontSize',0.4,...
        'String','->', ...
        'Callback',[callrightStr1,callrightStr2,callrightStr3,callrightStr4]);
handles.rightHndl=rightHndl;
     
% Then the text label
    uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'Position',[.875,.78,.04,.04], ...
        'BackgroundColor',[0.50 0.50 0.50], ...
        'FontUnits','normalized',...
        'ForegroundColor',[1 1 1], ...
        'String','h = ');

% Then the editable text field
   h0Hndl=uicontrol( ...
	'Style','edit', ...
        'Units','normalized', ...
        'String',num2str(h0),...%
        'BackgroundColor',[1 1 1], ...
        'UserData',h0,...
	'Tag','EYE_h0Hndl', ...
        'Position',[.91,.78,.08,.045], ...
        'HorizontalAlignment','left');
handles.h0Hndl=h0Hndl;
     
% Then the text label
    uicontrol( ...
	'Style','text', ...
        'Units','normalized', ...
        'Position',[.862,.71,.05,.05], ...
        'BackgroundColor',[0.50 0.50 0.50], ...
        'ForegroundColor',[1 1 1], ...
        'UserData',hstep,...
        'String','Step');
     
% Then the editable text field
   stepHndl=uicontrol( ...
	'Style','edit', ...
        'Units','normalized', ...
        'String',num2str(hstep),...%
        'BackgroundColor',[1 1 1], ...
	'Tag','EYE_stepHndl', ...
        'Position',[.91,.725,.08,.045], ...
        'HorizontalAlignment','left');
handles.stepHndl=stepHndl;
     
  OKstr1='h0h=findobj(''Tag'',''EYE_h0Hndl'');h0=get(h0h,''UserData'');sf=findobj(''Tag'',''HAZARD_setting'');udata=get(sf,''UserData'');udata.h=h0;set(sf,''UserData'',udata);';
  OKstr2='sb=findobj(''Tag'',''SelBand'');set(sb,''String'',num2str(h0));set(sb,''UserData'',h0);mainok=findobj(''Tag'',''HAZARD_setMainOK'');set(mainok,''Enable'',''on'');set(gcf,''CloseRequestFcn'',''closereq'');delete(gcf);';
  usehHndl=uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
	'Tag','EYE_useHndl', ...
        'FontUnits','normalized',...
        'Position',[0.88,.6,.11,0.07], ...
        'String','<html>Use current h<br>&nbsp;for estimate.', ...
	'FontSize',0.3, ...
        'Callback',[OKstr1,OKstr2]);
handles.usehHndl=usehHndl;

% button Cancel
       closeStr='set(gcf,''CloseRequestFcn'',''closereq'');delete(gcf);';
       uicontrol('Style','push','Units','normalized', ...
          'FontUnits','normalized',...
          'Position',[0.88,.03,.11,0.07], ...
          'Callback',closeStr, ...
          'BackgroundColor',[.5,0.5,0.5], ...
          'String','Cancel');

eyedata=get(eyefighndl,'UserData');
eyedata.handles=handles;
set(eyefighndl,'UserData',eyedata);
     
set(gcf,'Units','normalized','Position',[0.1059 0.1655 0.7700 0.6898]);

  
end %function

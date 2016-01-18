%  function HAZARD_kerchoice

mf=findobj('Tag','HAZARD_MAIN');
udata=get(mf,'UserData');
h=udata.h;
hh=[h,h];
xx=udata.xx;
lb=min(xx);
ub=max(xx);
nx=length(xx);
bandfig=figure( ...
   'Visible','on', ...
   'Name','Bandwidth Choice', ...
   'Units','Normalized',...
   'UserData',hh,...
   'Tag','HAZARD_BANDCHOICE',...
   'NumberTitle','off');

uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.25,.85,.5,.1], ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.5,...
        'String','Bandwidth Choice');

% actual value
uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.1,.75,.4,.1], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'Tag','HAZARD_BAND_ACTU',...
        'String',['Actual value: ',num2str(h)]);

% new value
uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.5,.75,.4,.1], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'Tag','HAZARD_BAND_NEW',...
        'String',['New value: ',num2str(h)]);

% predefined methods
uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.1,.65,.4,.1], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'String','Predefined methods:');
bandpredef1='mf=findobj(''Tag'',''HAZARD_MAIN'');udata=get(mf,''UserData'');K=udata.K;X=udata.X;bch=findobj(''Tag'',''HAZARD_BAND_METH'');bmeth=get(bch,''Value'');';
bandpredef2='switch bmeth, case 1,  h_m=h_ms(X,K);hn=h_F(X,K); case 2, hn=h_Altman(X,K); case 3, hn=h_Fms(X,K);end; ';
bandpredef3='bandact=findobj(''Tag'',''HAZARD_BAND_NEW'');set(bandact,''String'',[''New value: '',num2str(hn)]);';
bandpredef4='bandchoi=findobj(''Tag'',''HAZARD_BANDCHOICE'');hh=get(bandchoi,''UserData'');hh(2)=hn;set(bandchoi,''UserData'',hh);';
bandchoice=uicontrol( ...
        'Style','popup', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.4,.71,.5,0.05], ...
        'String',' Iterative method| Direct plug-in| Maximal smoothing', ...
        'Tag','HAZARD_BAND_METH', ...
        'Callback',[bandpredef1,bandpredef2,bandpredef3,bandpredef4]);

% manually
uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.1,.55,.4,.1], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'String','Set bandwidth manually');
% edit field
uicontrol( ...
        'Style','edit', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.5,.60,.15,.065], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.9 0.9 0.9], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'Tag','HAZARD_BAND_MAN',...
        'String',[' ',num2str(h)]);
%  button OK
bandman1='b_man=findobj(''Tag'',''HAZARD_BAND_MAN'');hn=eval(get(b_man,''String''));';
bandman2='bandact=findobj(''Tag'',''HAZARD_BAND_NEW'');set(bandact,''String'',[''New value: '',num2str(hn)]);';
bandman3='bandchoi=findobj(''Tag'',''HAZARD_BANDCHOICE'');hh=get(bandchoi,''UserData'');hh(2)=hn;set(bandchoi,''UserData'',hh);';
uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.7,0.61,.05,0.05], ...
        'String','OK', ...
        'Callback',[bandman1,bandman2,bandman3]);

% button New value
nval1='bandchoi=findobj(''Tag'',''HAZARD_BANDCHOICE'');hh=get(bandchoi,''UserData'');h=hh(2);mf=findobj(''Tag'',''HAZARD_MAIN'');udata=get(mf,''UserData'');';
nval2='K=udata.K;X=udata.X;d=udata.d;xx=udata.xx;F_est=K_hafest(X,d,K,xx,h);udata.h=h;udata.F_est=F_est;set(mf,''UserData'',udata);';
nval3='bandact=findobj(''Tag'',''HAZARD_BAND_ACTU'');set(bandact,''String'',[''Actual value: '',num2str(h)]);';
    CloseBHndl=uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.1,0.5,.25,0.05], ...
        'String','Use new value', ...
        'Callback',[nval1,nval2,nval3]);
% x-axis     
uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.25,.30,.5,.1], ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.5,...
        'String','Point of x-axis');
% l-band
uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.1,.2,.2,.1], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'String','Lower bound');
% edit field
uicontrol( ...
        'Style','edit', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.3,.24,.1,.065], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.9 0.9 0.9], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'Tag','HAZARD_LBOUND',...
        'String',[' ',num2str(lb)]);

% u-band
uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.45,.2,.2,.1], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'String','Upper bound');
% edit field
uicontrol( ...
        'Style','edit', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.65,.24,.1,.065], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.9 0.9 0.9], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'Tag','HAZARD_UBOUND',...
        'String',[' ',num2str(ub)]);

% nx
uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.1,.10,.3,.1], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'String','Number of points');
% edit field
uicontrol( ...
        'Style','edit', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.4,.14,.1,.065], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.9 0.9 0.9], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'Tag','HAZARD_NX',...
        'String',[' ',num2str(nx)]);

%  button Accept
acc1='lb_hndl=findobj(''Tag'',''HAZARD_LBOUND'');lb=eval(get(lb_hndl,''String''));ub_hndl=findobj(''Tag'',''HAZARD_UBOUND'');ub=eval(get(ub_hndl,''String''));';
acc2='nx_hndl=findobj(''Tag'',''HAZARD_NX'');nx=eval(get(nx_hndl,''String''));xx=linspace(lb,ub,nx);mf=findobj(''Tag'',''HAZARD_MAIN'');udata=get(mf,''UserData'');';
acc3='K=udata.K;X=udata.X;d=udata.d;h=udata.h;F_est=K_hafest(X,d,K,xx,h);udata.xx=xx;udata.F_est=F_est;set(mf,''UserData'',udata);';
uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.7,0.15,.15,0.05], ...
        'String','Accept', ...
        'Callback',[acc1,acc2,acc3]);

% Close button
uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.8,0.05,.15,0.05], ...
        'String','Close', ...
        'Callback','close(gcf)');

end % function


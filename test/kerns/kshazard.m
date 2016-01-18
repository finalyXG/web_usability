function[]=kshazard(X,d)
% function kshazard(X,d)
% GUI for Kernel HAZARD Estimation
% X - random sample
% d - censoring variable
%
% (C) Jiri Zelinka and Jan Kolacek, Masaryk University, Brno, Czech Republic
%

w=which('kshazard.m');
w(end-10:end)=[];
addpath(w);
addpath([w,'/hazard']);
addpath([w,'/hazard/base']);
addpath([w,'/hazard/functions']);
%addpath([w,'/regress']);
%addpath([w,'/quality']);
%addpath([w,'/distrib']);
%addpath([w,'/bivardens']);


% initial definitions

K=[];
LoH=[]; % list of handles

% create the main window

CreateMainStr='save HAZARD_tempsavedata;clear all';
CloseMainStr='mf=findobj(''Tag'',''HAZARD_MAIN'');set(gcf,''CloseRequestFcn'',''closereq'');close(mf);clear all;if exist(''HAZARD_tempsavedata.mat'')==2,load HAZARD_tempsavedata;delete HAZARD_tempsavedata.mat;end';

main_fig=figure( ...
   'Visible','on', ...
   'Name','Kernel Hazard Function Estimate', ...
   'CreateFcn',CreateMainStr,...
   'CloseRequestFcn',CloseMainStr,...
   'Units','Normalized',...
   'NumberTitle','off',...
   'Tag','HAZARD_MAIN');
LoH=[LoH,main_fig];

axes('Position',[0.08 0.08 0.7 0.85]);

RightBorder=uicontrol( ...
        'Style','frame', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.85,0,.20,1], ...
        'BackgroundColor',[0.50 0.50 0.50]);

top=0.825;
%  text Data
    DataHndl1=uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.86,top+0.0855,.125,0.05], ...
        'BackgroundColor',[0.50 0.50 0.50], ...
        'String','Data');
%  button Data input
    DataHndl2=uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.86,top+0.05,.125,0.05], ...
        'String','Input', ...
        'Callback','HAZARD_datainput');
%  button Data view
    DataHndl3=uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.86,top,.125,0.05], ...
        'String','View', ...
        'Callback','HAZARD_datadraw');
%  button Data save
    DataHndl4=uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.86,top-0.05,.125,0.05], ...
        'String','Save', ...
        'Callback','HAZARD_datasave');
LoH=[LoH,DataHndl2,DataHndl3,DataHndl4];


top=.65;
% button Kaplan-Meier
    EmpHndl10=uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'FontSize',0.5,...
        'Position',[0.86,top+0.05,.125,0.05], ...
        'BackgroundColor',[0.50 0.50 0.50], ...
        'String','Kaplan-Meier');
   EmpHndl1=uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.86,top+0.005,.125,0.05], ...
        'String','View', ...
        'Callback','HAZARD_kmdraw');
LoH=[LoH,EmpHndl1];

top=.525;
% button Setting
   SetHndl=uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.86,top,.125,0.1], ...
        'String','Setting', ...
        'Callback','HAZARD_setting');
LoH=[LoH,SetHndl];

top=0.425;
%  estimates
    EstHndl1=uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'FontSize',0.5,...
        'Position',[0.86,top+0.035,.125,0.05], ...
        'BackgroundColor',[0.50 0.50 0.50], ...
        'String','Hazard fun.');
    EstHndl2=uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.86,top,.125,0.05], ...
        'String','View', ...
        'Callback','HAZARD_estimdraw');

LoH=[LoH,EstHndl2];

top=0.375;
%  conf. intervals
    Confint2=uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'FontSize',0.45,...
        'Position',[0.86,top,.125,0.05], ...
        'String','Conf.intervals', ...
        'Callback','HAZARD_confi');

LoH=[LoH,Confint2];

top=0.15;
%  estimates
    EstHndl3=uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'FontSize',0.5,...
        'Position',[0.86,top+0.035,.125,0.05], ...
        'BackgroundColor',[0.50 0.50 0.50], ...
        'String','Survial fun.');
    EstHndl4=uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.86,top,.125,0.05], ...
        'String','View', ...
        'Callback','HAZARD_survdraw');

LoH=[LoH,EstHndl4];

top=.27;
% button Setting
   MaxDecrHndl=uicontrol( ...
        'Style','push', ...
        'Tag','HAZARD_MaxDecr', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'FontSize',0.275,...
        'UserData',0,...
        'Position',[0.86,top,.125,0.075], ...
        'String','Max decr. points', ...
        'Callback','HAZARD_MaxDecr');
LoH=[LoH,MaxDecrHndl];



top=0.005;
% button Close
CloseStr='mf=findobj(''Tag'',''HAZARD_MAIN'');set(gcf,''CloseRequestFcn'',''closereq'');close(mf);clear all;if exist(''HAZARD_tempsavedata.mat'')==2,load HAZARD_tempsavedata;delete HAZARD_tempsavedata.mat;end';
mf=findobj('Tag','HAZARD_MAIN');
figure(mf);

    CloseHndl=uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.86,top+0.025,.125,0.075], ...
        'String','Close', ...
        'Callback',CloseStr);


if nargin==0 % load or simulate data
  % creating data structure
  X=[];
  d=[];
  xx=[];
  h=[];
  lam_est=[];
  bounds=[];
  f=char([]);
  nH=length(LoH);
  for ii=3:nH
    set(LoH(ii),'Enable','off');
  end
else % nargin>0, initial definitions
  minX=min(X);
  maxX=max(X);
  DX=maxX-minX;
%  xx=linspace(minX-0.1*DX,maxX+0.1*DX,201);
  xx=linspace(0,maxX+0.1*DX,201);
%  h=h_ms(X,K);
%  lam_est=K_dest(xx,X,h,K);
  h=[];
  lam_est=[];
  bounds=[min(X),max(X)];
  nH=length(LoH);
  for ii=7:nH
    set(LoH(ii),'Enable','off');
  end
end % nargin>0
    
    
main_data=struct('K',K,'X',X,'d',d,'xx',xx,'h',h,'lam_est',lam_est,'bounds',bounds,'LoH',LoH);
set(main_fig,'UserData',main_data);

% button print
    callprint1='curr=get(gcf,''CurrentAxes'');fig=figure;cc=copyobj(curr,fig);';
    callprint2='set(cc,''Position'',[0.08 0.08 0.85 0.85]);';
    uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.001,.96,.067,0.035], ...
        'String','Print', ...
        'Callback',[callprint1,callprint2]);
    
% button grid
    uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'FontSize',0.6,...
        'Position',[0.001,0.001,.067,0.035], ...
        'String','Grid', ...
        'Callback','grid;');


set(main_fig,'Position',[0.1059 0.1655 0.7700 0.6898]);

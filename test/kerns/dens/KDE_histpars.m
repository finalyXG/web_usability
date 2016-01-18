function KDE_histpars

mf=findobj('Tag','KDE_MAIN');
udata=get(mf,'UserData');
hist_bits=udata.hist_bits;
hbs=num2str(hist_bits);

datafig=figure( ...
   'Visible','on', ...
   'Name','Histogram Parameter', ...
   'Units','Normalized',...
   'Tag','KDE_HISTP',...
   'NumberTitle','off');

uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.275,.85,.45,.1], ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.5,...
        'String','Histogram Parameters');

uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.1,.7,.6,.1], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'String','Put the number of bits for histogram:');

% setting of bins
hb=uicontrol( ...
        'Style','edit', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.7,.75,.1,0.05], ...
        'BackgroundColor',[0.9 0.9 0.9], ...
        'ForegroundColor',[0 0 0], ...
        'String',hbs, ...
	'Tag','KDE_HPAR');

SaveHistBins1='hb=findobj(''Tag'',''KDE_HPAR'');hist_bits=eval(get(hb,''String''));';
SaveHistBins2='mf=findobj(''Tag'',''KDE_MAIN'');udata=get(mf,''UserData'');';
SaveHistBins3='udata.hist_bits=hist_bits;set(mf,''UserData'',udata);delete(gcf);KDE_histdraw';
%  button OK
uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.825,0.75,.05,0.05], ...
        'String','OK', ...
        'Callback',[SaveHistBins1,SaveHistBins2,SaveHistBins3]);

end % function


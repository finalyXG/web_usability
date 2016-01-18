function KDE_countbands
% count bandwidths


sf=findobj('Tag','KDE_setting');udata=get(sf,'UserData');K=udata.K;
mf=findobj('Tag','KDE_MAIN');udata_m=get(mf,'UserData');X=udata_m.X;

hit=KDE_bandw(X,K,'it');
hdp=KDE_bandw(X,K,'dp');
hms=KDE_bandw(X,K,'ms');
hbc=KDE_bandw(X,K,'bc');
hlc=KDE_bandw(X,K,'lc');
hrd=KDE_bandw(X,K,'rd');

bh=udata.bhandles;
%nofbh=length(bh);

set(bh(1,1),'UserData',hit);
set(bh(1,2),'UserData',hdp);
set(bh(1,3),'UserData',hms);
set(bh(1,4),'UserData',hbc);
set(bh(1,5),'UserData',hlc);
set(bh(1,6),'UserData',hrd);

set(bh(2,1),'String',num2str(hit));
set(bh(2,2),'String',num2str(hdp));
set(bh(2,3),'String',num2str(hms));
set(bh(2,4),'String',num2str(hbc));
set(bh(2,5),'String',num2str(hlc));
set(bh(2,6),'String',num2str(hrd));

end % function


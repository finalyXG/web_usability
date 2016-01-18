function CDF_countbands
% count bandwidths


sf=findobj('Tag','CDF_setting');udata=get(sf,'UserData');K=udata.K;
mf=findobj('Tag','CDF_MAIN');udata_m=get(mf,'UserData');X=udata_m.X;

hit=CDF_bandw(X,K,'it');
hdp=CDF_bandw(X,K,'dp');
hms=CDF_bandw(X,K,'ms');
hrd=CDF_bandw(X,K,'rd');

bh=udata.bhandles;
%nofbh=length(bh);

set(bh(1,1),'UserData',hit);
set(bh(1,2),'UserData',hdp);
set(bh(1,3),'UserData',hms);
set(bh(1,4),'UserData',hrd);

set(bh(2,1),'String',num2str(hit));
set(bh(2,2),'String',num2str(hdp));
set(bh(2,3),'String',num2str(hms));
set(bh(2,4),'String',num2str(hrd));

end % function


function HAZARD_countbands
% count bandwidths


sf=findobj('Tag','HAZARD_setting');udata=get(sf,'UserData');K=udata.K;
mf=findobj('Tag','HAZARD_MAIN');udata_m=get(mf,'UserData');X=udata_m.X;d=udata_m.d;

%hit=h_iter(X,d,K);
%hcv=cvmin(X,d,K);
%hml=mlmax(X,d,K);
hit=HAZARD_bandw(X,d,K,'it');
hcv=HAZARD_bandw(X,d,K,'cv');
hml=HAZARD_bandw(X,d,K,'ml');
%hit=41.9048;
%hcv=73.3325;
%hml=26.1556;

bh=udata.bhandles;
%nofbh=length(bh);

set(bh(1,1),'UserData',hit);
set(bh(1,2),'UserData',hcv);
set(bh(1,3),'UserData',hml);

set(bh(2,1),'String',num2str(hit));
set(bh(2,2),'String',num2str(hcv));
set(bh(2,3),'String',num2str(hml));

end % function


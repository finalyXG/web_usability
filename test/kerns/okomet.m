%OKOMET calls up a demonstration window to show the optimal
%       bandwidth dependence on the order of kernel

T=74;
Nmax = 14;funkce;f=f3;s=s3;
[xx,yy]=rozhaz(f,0,1,T,s);close;
t = 0.03:.02:1;
m=length(t);
yps = zeros(m,T,Nmax/2);
     %x = zeros(size(xx));
len=length(.03:.02:1);
H=waitbar(0,'Moment please ...');
for k=2:2:Nmax
   i=1;
   for hac=.03:.02:1
   [S,x]=nw(xx,yy,0,k,1,hac);
   yps(i,:,k/2) = x;
   i=i+1;waitbar(i*k/(Nmax*len));
   end;
   h=plugin(xx,yy,0,k,1,1);
   [hmin,ind]=min(abs(t-h));
   t1(k/2,:)=(m-ind+1)*ones(1,T);
end;
close(H);

hh = gca;
ha = axes('pos',[0 0 1 1],'Visible','off');set(gcf,'visible','off');
axis([0 1 0 1]);
tx(1) = text(.94,.7,'2','HorizontalAlignment','right');
tx(2) = text(.94,.95,int2str(Nmax),'HorizontalAlignment','right');
tx(3) = text(.94,.825,'Kernel Order:','HorizontalAlignment','right');
set(tx,'Visible','off')
fig = gcf;

s = ['N = 2*ceil(get(gco,''Value'')/2);' ...
    'y = yps(:,:,N/2);if ~ismember(N/2,NN) NN=[NN,N/2];end;' ...
    'surfHndl=findobj(gcf,''Type'',''surface'');' ...
    'set(surfHndl,''ZData'',rot90(y,-1),''CData'',rot90(y,-1));' ...
    'fi3=findobj(gcf,''Type'',''line'');set(fi3,''XData'',t1(N/2,:));'...
    'title([ ''Kernel Order: '' int2str(N)]);set(gca,''cameraposition'',cam);',...
    'M(:,N/2)=getframe(gca);'];

sliderHndl = uicontrol(fig,'Style','slider', 'Units', 'normalized', 'Position',[0.95 0.70 0.03 0.25],...
    'Min',2,'Max',Nmax,'sliderstep',[1/(Nmax/2) 1], ...
    'Value',2,'CallBack',s,'visible','on','FontUnits','normalized');

 % Make the slider 16 pixels wide
set(sliderHndl,'Units','pixel');
pos=get(sliderHndl,'Position');
set(sliderHndl,'Position',[pos(1:2) 16 pos(4)]);
set(sliderHndl,'Units','normalized');


set(fig,'currentaxes',hh);
%   Now plot this as a 3-d surface to show the transition to a square wave.
surfHndl=surf(rot90(yps(:,:,1),-1));
shading interp
set(surfHndl,'EdgeColor',[0.6 0.3 0.4])
axis ij
axis off
%       You can move the slider to change the number of terms in the series.
axis(axis);
hold on;
%t1=(m-5)*ones(1,T);
x=xx;
hodn=eval(f);
fi3=plot3(t1(1,:),1:T,hodn,'linewidth',2);
%%%%toto vykresli i opravdovou regresni funkci

P = pink(64);
colormap(flipud(P(17:64,:)));
title(['Kernel Order: ' int2str(2)])
hold on;
set(sliderHndl,'visible','on');
set(tx,'visible','on');
set(fig,'CurrentAxes',hh);
set(fig,'NextPlot','replace')
%set(gca,'view',[0 60]);
cam=get(gca,'cameraposition');

videoHndl=uicontrol(fig,'style','push','units','normalized', ...
   'position',[0.8 0.1 .15 .1],'callback','title(''VIDEO'');movie(gca,M(:,NN),1);', ...
   'string','video','enable','on','FontUnits','normalized');
NN=1;
M=moviein(Nmax/2,gca);
M(:,1)=getframe(gca);

set(gcf,'Units','normalized','Position',[0.1059 0.1655 0.7700 0.6898]);

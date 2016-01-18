function[] = putsigma()

G=findobj('Tag','sigma');
ax=axis;
roz=ax([2,4])-ax([1,3]);
newpos=[ax(2)+0.27*roz(1),ax(3)+0.66*roz(2), 0];
set(G,'position',newpos);


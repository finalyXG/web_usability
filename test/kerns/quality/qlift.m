function y = qlift(x,r,q,C)

[z,ind]=find(x==q);
if ~isempty(ind)
    ind=min(ind);
    y=r(ind);
else
    [z1,ind1]=find(x<q);
    ind1=max(ind1);
    [z2,ind2]=find(x>q);
    ind2=min(ind2);
    y=mean(r([ind1,ind2]));
end

if nargin==4
    figure(C);
    hold on;
    plot([q q],[0 y],'k:');
end
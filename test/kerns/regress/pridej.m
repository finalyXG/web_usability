function[y]=pridej(prom,x)
%
% supplemental script

n = size(prom,1);
y = prom;
prazdny=zeros(n,1);
jetam=zeros(n,1);
for i = 1:n
    jet = findstr(prom(i,:),x);
    prazd = findstr(prom(i,:),'[]');
    if ~isempty(jet)
        jetam(i)=1;
    end
    if ~isempty(prazd)
        prazdny(i)=1;
    end
end

if sum(jetam)==0
    k=find(prazdny);
    if ~isempty(k)
        prom(k(1),:)=[];
    end
    y = char(x,prom);
end
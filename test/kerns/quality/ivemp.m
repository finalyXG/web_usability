function [ival,iv,xiv,p1,p2] = ivemp(x1,x2,k)

if nargin < 3
    k=10;
end
n1 = length(x1);
n2 = length(x2);
smes=[x1,x2];
p=0:1/k:1;
q=quantile(smes,p);
p1=histc(x1,q);
p1(end-1)=p1(end-1)+p1(end);
p1(end)=[];
p2=histc(x2,q);
p2(end-1)=p2(end-1)+p2(end);
p2(end)=[];

p1=p1/n1;
p2=p2/n2;

iv=(p2-p1).*mylog(p2,p1);
xiv=(q(1:end-1)+q(2:end))/2;

ival=sum(iv);

function [z] = mylog(x,y)

sx=(x==0);
x(sx)=0.0001;
sy=(y==0);
y(sy)=0.0001;

n=sum(sx)+sum(sy);

% if n>0
%     disp([num2str(n),'-times came 0!']);
% end

z=log(x./y);
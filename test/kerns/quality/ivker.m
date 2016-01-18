function [ival,iv,xiv,p1,p2] = ivker(x1,x2)

smes=[x1,x2];
xmin=min(smes);
xmax=max(smes);
xx=linspace(xmin,xmax);
nn=(xmax-xmin)/100;

K=K_def('epan');
h0=h_ms(x1,K);
h1=iter_bistef(h0,x1,K);
p1=ksd(x1,0,2,1,h1,xx);
h0=h_ms(x2,K);
h2=iter_bistef(h0,x2,K);
p2=ksd(x2,0,2,1,h2,xx);

iv=(p2-p1).*mylog(p2,p1);
xiv=xx;

ival=sum(iv)*nn;

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
%HLEDANI  calls up a window for estimation of optimal bandwidth
%
%     Use only in procedure KERN
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

figNumber=figure( ...
   'Name','Choosing of the smoothing parametr', ...
   'NumberTitle','off',...
   'Tag','eclos',...
   'Color',[.7 .7 .7]);

%Inmat=zeros(9,4);Inp=Inmat;
vert=.04;hor=.95;
vys=0.05;sir=0.15;
load v.mat;load w.mat;
    
hndlList=get(figNumber,'Userdata');
g=get(hndlList(5:8),'value');
rozh=[g{1},g{2},g{3},g{4}];
rozh=find(rozh==1);
hor=hor+.04;

clear figNumber

switch rozh
case {1}
   choosnw;
case {2}
   choosll;
case {3}
   choosgm;
case {4}
   choospch;
end;


     
      

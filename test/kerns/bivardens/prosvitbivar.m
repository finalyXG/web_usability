function[]=prosvitbivar(C)
%PROSVITBIVAR  help procedure for KSBIVARDENS
%
%     Use only in procedure KSBIVARDENS
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

G=get(figure(C),'Userdata');
hndlList=G.hndlList;
%n=length(hndlList);

for i=[2:3]
   H=hndlList(i);
   set(H,'Enable','on');
end;

function[]=prosvit(C)
%PROSVIT  help procedure for KERN
%
%     Use only in procedure KERN
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

hndlList=get(figure(C),'Userdata');
n=length(hndlList);

for i=1:8
   H=hndlList(i);
   set(H,'Enable','on');
end;

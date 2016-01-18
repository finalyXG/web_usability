function[f]=genf(n);
%GENF  generate function
%
%[f]=genf(n)
%    f ... text string of random function
%    n ... number of sum elements
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

t=['sin ';'cos ';'tan ';'cot ';'abs ';'log ';'asin';'acos';'atan';'acot';
'exp ';'sqrt'];
op=[' +';' -';'.*';'./';'.^'];

gt=round(rand(n))+ones(n);%gt=ones(n);   %gt je n x n
gk=round(20*rand(10));
go=round(4*rand(10))+ones(10);
m=1;

for i=1:n
a=[num2str(gk(i,1)),op(go(i,1),:),'x',op(go(i,2),:),num2str(gk(i,3))];
b=[num2str(gk(i,4)),op(go(i,5),:),t(gt(i,1),:),'(',a,')'];
k=length(b);
for j=1:k
f(m+j-1)=b(j);
end;
if i~=n
f(m+k)=op(go(i,6),1);
f(m+k+1)=op(go(i,6),2);
end;
m=k+m+2;
end;
f=f(find(f~=' '));
fplot(f,[0,1]);
pause;
close;

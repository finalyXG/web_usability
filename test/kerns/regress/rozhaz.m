function[x,y]=rozhaz(fce,a,b,n,r,C)
%ROZHAZ   generates random design points
%
%[x,y]=rozhaz(fce,a,b,n,var)
%      [x,y] ... data set, x - equidistantly distributed on interval [a,b]
%                          y - random measurements
%       fce .... regression function in variable 'x'
%      [a,b] ... interval for x - points
%       n ...... number of points
%       var .... variance
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)


%x=(b-a)*rand(1,n)+a;     %neekvidistantni
%x=sort(x);
r=sqrt(r);
x=linspace(a,b,n);       %ekvidistantni
xx=x;
if ~ischar(fce)
    error('The function should be a string!');
end
ind=findstr(fce,'x');
if isempty(ind)
    error('The variable should be ''x''!');
end
f=vectorize(fce);
y=eval(f);
y=y+r*randn(1,n);
%k=(max(y)-min(y))/4;
%y=y+k*randn(1,n);
if nargin < 6
    C=1;
end
figure(C);
plot(x,y,'x');hold on;axis(axis);
x=linspace(a,b);
plot(x,eval(f),'k:');
hold off;
x=xx;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Cyklicky model
%z=zeros(1,length(x));
%figure;plot([x-1,x,x+1],[y,y,y],'x',[x-1,x,x+1],[yy,yy,yy],'g');
%line([-1,2],[0,0]);xlabel('x');ylabel('y');osy=axis;
%figure;
%plot(x,y,'x');hold on;%axis(axis);
%fplot(fce,[a,b],'g');axis(osy);xlabel('x');ylabel('y');
%line([-1,2],[0,0]);
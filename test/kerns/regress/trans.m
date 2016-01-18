function[xx]=trans(x,a,b);
%TRANS   transformation of vector to interval [a,b]
%
%[xx]=trans(x,a,b)
%     xx ..... transformated vector
%     x ...... original vector
%    [a,b] ... transformation interval, a < b
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

m=min(x);M=max(x);
d=M-m;
u=(x-m)/d;
xx=u*(b-a)+a;

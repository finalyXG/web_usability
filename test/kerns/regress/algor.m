function[kk,h,L]=algor(x,y,est,met,kbound);
%ALGOR  estimation of optimal smoothing parameters for all types of
%       estimators
%
%[kmin,hmin,L]=algor(x,y,est,met,kbound)
%       kmin ... estimated value of optimal order of kernel
%       hmin ... estimated value of optimal bandwidth
%       L ...... a matrix of size 2 x (|kbound|/2)
%                1.row - values of error function for each k
%                2.row - values of optimal h for each k
%       [x,y] ... data set
%       est ..... text string, the type of used estimator 
%                 'nw' ... Nadaraya - Watson
%                 'll' ... local - linear
%                 'gm' ... Gasser - Mueller
%                 'pch'... Pristley - Chao
%       met ..... text string, the type of used method for selection of
%                 optimal bandwidth
%                 'acv' .... Akaike's information criterion
%                 'fcv' .... full crossvalidation
%                 'fpecv'... finite prediction error
%                 'gcv' .... generalized crossvalidation
%                 'k' ...... Kolacek's penalizing function
%                 'rcv' .... Rice's penalizing function
%                 'scv' .... Shibata's penalizing function
%                 'cv' ..... classic crossvalidation
%                 'ch' ..... Fourier transformation
%                 'sig' .... Mallows method
%                 'plugin'.. plug-in method
%       kbound .. vector [kmin kmax], kmin, kmax should be even, set the
%                 range of order of kernel
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

kbound=sort(kbound);
kmin=kbound(1);
kmax=kbound(2);

if ~isstr(est)
   switch est
   case 1
      est='nw';
   case 2
      est='ll';
   case 3
      est='gm';
   case 4
      est='pch';
   otherwise
      disp('Parameter est should be an integer between 1 and 4!');
      return;
   end;
end;

if ~isstr(met)
   switch met
   case 1
      met='acv';
   case 2
      met='fpecv';
   case 3
      met='fcv';
   case 4
      met='gcv';
   case 5
      met='k';
   case 6
      met='rcv';
   case 7
      met='scv';
   case 8
      met='cv';
   case 9
      met='ch';
   case 10
      met='sig';
   case 11
      met='plugin';
   otherwise
      disp('Parameter met should be an integer between 1 and 11!');
      return;
   end;
end;

if strcmp(met,'plugin')
   est=[];
end;

n=length(x);
for k=(kmin:2:kmax)/2
   [K,beta,delta,V]=jadro(0,2*k,1);
   hh(k)=eval([met,est,'(x,y,0,2*k,1)']);
   h(k)=hh(k)*n/delta;
   L(k)=(abs(beta)*V^(2*k))^(2/(4*k+1))*((4*k+1)/(4*k*h(k)));
end;
[LL,kk]=min(L(L~=0));
kk=kk+kmin/2-1;
h=hh(kk);
kk=2*kk;
L=[L;hh];   
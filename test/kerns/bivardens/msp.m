function[H]=msp(X,ny,k,mi,styl)
% MSP Maximal Smoothing Principle
%
% H=msp(X,nu,k,mi,style)
% estimates a bandwidth matrix H by Maximal Smoothing Principle
% X............ matrix of observations
% nu,k,mi ..... order of kernel ([0,2,1] = Epanechnik)
% style ....... style of kernel ('gaus','prod','sphe')
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)
[dim,n]=size(X);

wai=waitbar(0,'Computing the bandwidth matrix by MSP ...');

S=cov(X');

waitbar(1/3,wai);

switch styl
    case 'prod'
        [z,zz,V]=productkern(ny,k,mi,ones(2,n));
    case 'sphe'
        [z,zz,V]=spherickern(ny,k,mi,ones(2,n));
    case 'gaus'
        [z,zz,V]=gausskern(ones(2,n));
    otherwise
        close(wai);
        error('wrong style!');
end;
waitbar(2/3,wai);

H=(((dim+8)^(dim/2+3)*pi^(dim/2)*V)/(16*n*(dim+2)*gamma(dim/2+4)))^(2/(dim+4))*S;
waitbar(1,wai);
close(wai);

% H je ve tvaru "na druhou"
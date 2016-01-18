function[y,F0,countdiv]=hledej(Xi,ny,k,mi,h1,h2,chyba)
% auxiliary function for KSBIVARDENS toolbox
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

[dim,n]=size(Xi);
countdiv=0;

if dim~=2
    error('Wrong dimension of X!');
end

if nargin<7
    chyba=0.01;
end

if nargin<5
    h_plcv=plcv(Xi,[ny,k,mi]);
    h1=h_plcv(1,1)^(1/2);
    h2=h_plcv(2,2)^(1/2);
end

F=[funkce_g(Xi,ny,k,mi,h1,h2)-1;funkce_g3(Xi,ny,k,mi,h1,h2)];
F0=F;

h_start=[h1;h2];
h_puv=h_start;
%  plot(h1,h2,'r*');
%  hold on;
step=eps^(1/2);
%step=.1;
J=zeros(2);
J(1,1)=(funkce_g(Xi,ny,k,mi,h1+step,h2)-1-F(1))/step;
J(1,2)=(funkce_g(Xi,ny,k,mi,h1,h2+step)-1-F(1))/step;
J(2,1)=(funkce_g3(Xi,ny,k,mi,h1+step,h2)-F(2))/step;
J(2,2)=(funkce_g3(Xi,ny,k,mi,h1,h2+step)-F(2))/step;

delta=-J\F;
%delta=delta/(1+(norm(F))^(1/8));
h_new=h_start+delta;
it=1;
wai=waitbar(0,'Computing the bandwidth matrix by IT 2 ...');
while (norm(F,inf)>chyba)&&(it<100)
    h1=h_new(1);
    h2=h_new(2);
    %    plot(h1,h2,'*');pause;
    h_start=h_new;
    F=[funkce_g(Xi,ny,k,mi,h1,h2)-1;funkce_g3(Xi,ny,k,mi,h1,h2)];
    J(1,1)=(funkce_g(Xi,ny,k,mi,h1+step,h2)-1-F(1))/step;
    J(1,2)=(funkce_g(Xi,ny,k,mi,h1,h2+step)-1-F(1))/step;
    J(2,1)=(funkce_g3(Xi,ny,k,mi,h1+step,h2)-F(2))/step;
    J(2,2)=(funkce_g3(Xi,ny,k,mi,h1,h2+step)-F(2))/step;
    %J
    if (det(J)==0)||(it==99)
        countdiv=1;
        disp('Divergence!');
        disp(['Starting approximations: ', num2str(h_puv')]);
        y=izelpokus2(Xi,ny,k,mi,[h_puv(1)/10,h_puv(1)],[h_puv(2)/10,h_puv(2)],100);
        y=diag(y);
        return;
        %         rand('state',sum(100*clock));
        %         J=rand(2);
        %         h_start=rand(2,1);
    end
    delta=-J\F;
    %    delta=delta/(1+(norm(F))^(1/8));
    h_new=h_start+delta;
    %    plot(abs(h_new(1)),abs(h_new(2)),'*');%pause
    it=it+1;
    waitbar(chyba/norm(F,inf),wai);
end
close(wai);
%disp(['  Number of iterations: ', num2str(it)]);
y=diag(abs(h_new)).^2;  %?
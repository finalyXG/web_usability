function[H]=steff_spec(Xi,ny,k,mi,eps,h1_poc)
% auxiliary function for KSBIVARDENS toolbox
%
% (C) Jan Kolacek, Masaryk University (Czech Republic)

if nargin<5
    eps=.00001;
end
m1=var(Xi(1,:));
m2=var(Xi(2,:));
fli=0;

if m1<m2
    Xi=flipud(Xi);
    fli=1;
end

[h_w,cons_odh]=wand(Xi);

h_w=h_w.^(1/2);

cons_odh=cons_odh^(1/2);

if nargin<6
    a=h_w(1,1);      % mala bisekce :-)
    b=4*a;
else
    a=h1_poc;
    b=4*a;
end
rozdil=b-a;
contr=0;fa=0;fb=0;count=1;
while contr~=-1
    a=a-sign(fa)*min(rozdil,9*a/10);
    b=b-sign(fb)*min(rozdil,9*a/10);
    fa=funkce_g(Xi,ny,k,mi,a,a/cons_odh)-1;
    fb=funkce_g(Xi,ny,k,mi,b,b/cons_odh)-1;
    contr=sign(fa)*sign(fb);
    count=count+1;
    if count==50
        error('Something is wrong...');
    end
end
s=(a+b)/2;
fs=funkce_g(Xi,ny,k,mi,s,s/cons_odh)-1;
wai=waitbar(0,'Computing the bandwidth matrix by IT 1 ...');
while abs(b-a)>eps
    if fa*fs<0
        b=s;
        fb=funkce_g(Xi,ny,k,mi,b,b/cons_odh)-1;
    else
        a=s;
        fa=funkce_g(Xi,ny,k,mi,a,a/cons_odh)-1;
    end
    s=(a+b)/2;
    fs=funkce_g(Xi,ny,k,mi,s,s/cons_odh)-1;
    waitbar(eps/abs(b-a),wai);
end
close(wai);
h1=a;


H=diag([h1,h1/cons_odh]);
if fli==1
    H=rot90(H,2);
end
H=H.^2;


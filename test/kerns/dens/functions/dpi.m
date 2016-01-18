% Funkce pro vypocet optimalni sirky vyhlazovaciho okna h
% n-stupnovou Direct plug-in metodou
%
% Vstupni parametry: X ... radkovy vektor pozorovanych bodu
%                    K ... jadro (defaultne=kvarticke)
%                    l ... pocet stupnu=iteraci (defaultne=2)
%                    L ... pomocne jadro uzite v iteracnim cyklu (defaultne=gausovo)
%
% Vystupni parametry: h_DPI_l ... optimalni sirka vyhlazovaciho okna h
%
% Syntaxe: h_DPI_l=dpi(X,K,l,L)
%
% (C) Michal Laska and Jiri Zelinka, Masaryk University, Brno, Czech Republic

function h_DPI_l=dpi(X,K,l,L)

% pridani cesty k pomocnym funkcim
%addpath functions;

X=row(X);

% defaultni jadro
if (nargin<2) K=K_def('quart'); end

% defaultni l
if (nargin<3) l=2; end

% defaultni pomocne jadro
if (nargin<4) L=K_def('gauss'); end

% pocet pozorovanych bodu
n=length(X);

% odhad vyberove smerodatne odchylky
sigma=std(X);

% matice Xi-Xj
XX=(X'*ones(1,n)-ones(n,1)*X);

% vypocet r. derivace psi za poziti odhadu normalniho rozlozeni
r=K.k*(l+2); %1. krok algoritmu DPI
psiR=((-1)^(r/2)*factorial(r))/(sqrt(pi)*(2*sigma)^(r+1)*factorial(r/2));

% pomocne prirazeni pro derivaci jadra
%L_der=L;

% faktorial stupne pomocneho jadra
factLk=factorial(L.k);

% iterace - zde se pocita s pomocnym jadrem L
while (r>2*K.k)
  % vypocet g
  r=r-K.k; %2. az predposledni krok algoritmu DPI
  L_der=K_der(L,r);
  g=((-factLk*K_val(L_der,0))/(n*L.beta*psiR))^(1/(r+L.k+1));

  % vypocet r. derivace psi s sirkou vyhlazovaciho okna g
  matX=XX/g;
  matY=K_val(L_der,matX);
  psiR=sum(sum(matY))/(g*n^2);
end

% vysledne h
h_DPI_l=((K.var*factorial(K.k)^2)/(2*K.k*n*K.beta^2*psiR))^(1/(2*K.k+1)); %posledni krok algoritmu DPI


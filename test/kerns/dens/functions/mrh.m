% Funkce pro vypocet optimalni sirky vyhlazovaciho okna h
% Metodou referencni hustoty pro jadra radu 2
%
% Vstupni parametry: X ... radkovy vektor pozorovanych bodu
%                    K ... jadro (defaultne=kvarticke)
%
% Vystupni parametry: h_MRH_2 ... optimalni sirka vyhlazovaciho okna h
%
% Syntaxe: h_MRH_2=mrh(X,K)
%
% (C) Michal Laska and Jiri Zelinka, Masaryk University, Brno, Czech Republic

function h_MRH_2=mrh(X,K)

% pridani cesty k pomocnym funkcim
% addpath functions;

X=row(X);

% defaultni jadro
if (nargin<2) K=K_def('quart'); end

% kontrola radu jadra
%if (K.k~=2)
%  error = 'Chyba: Jadro neni radu 2!'
%  return
%end

% pocet pozorovanych bodu
n=length(X);

% odhad vyberove smerodatne odchylky
sigma=std(X);

% vysledne h
h_MRH_2=sigma*((8*sqrt(pi)*K.var)/(3*n*K.beta^2))^(1/5);


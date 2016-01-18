% Funkce pro vypocet optimalni sirky vyhlazovaciho okna h metodou
% Biased cross-validation
%
% Vstupni parametry: X ... radkovy vektor pozorovanych bodu
%                    K ... jadro (defaultne=kvarticke)
%                          nefunkcni pro Gaussovo jadro
%                    len ... jemnost intervalu, ve kterem hledame optimalni h (defaultne=1000)
%
% Vystupni parametry: h_BCV ... vysledne optimalni h
%
% Syntaxe: h_BCV=bcv(X,K,len)
%
% (C) Michal Laska and Jiri Zelinka, Masaryk University, Brno, Czech Republic

function h_BCV=bcv(X,K,len)

% pridani cesty k pomocnym funkcim
% addpath functions;

X=row(X);

% defaultni jadro
if (nargin<2) K=K_def('quart'); end

% defaultni delka vektoru hh
if (nargin<3) len=1000; end

% kontrola spojitosti radu derivace
%if (K.mi+1<K.k)
%	error = 'Chyba: Jadro nema dostatecny pocet spojitych derivaci'
%  return
%end

% uprava jemnosti intervalu pro vyssi rychlost vypoctu
len=ceil(len^(1/3));

% pocet pozorovanych bodu
n=length(X);

% odhad vyberove smerodatne odchylky
% sigma=std(X);

% vypocet b_k;
% bk=2*sqrt(2*K.k+5)*(((2*K.k+1)*(2*K.k+5)*(K.k+1)^2*gamma(K.k+1)^4*K.var)/(K.k*gamma(2*K.k+4)*gamma(2*K.k+3)*K.beta^2))^(1/(2*K.k+1));

% horni hranice
% hu=sigma*bk*n^(-1/(2*K.k+1));
hu=h_ms(X,K);

% dolni hranice intervalu
hl=(max(X)-min(X))/n;

% interval, ve kterem se bude hledat optialni h
hh=linspace(hl,2*hu,len);

% matice Xi-Xj
XX=(X'*ones(1,n)-ones(n,1)*X);

% konvoluce dvou jader
Kc=Kconv_def(K,2);

% 2*K.k-ta derivace konvoluce
for i=1:(2*K.k) Kc=Kconv_der(Kc); end

% faktorial stupne jadra
factKk=factorial(K.k);

% vektor hodnot LSCV v hh
for j=1:3
	BCV=[];
	for i=1:len
		h=hh(i);
		
		% vypocet konvoluce
		matX=XX/h;
		matY=Kconv_val(Kc,matX);
		matY=matY-diag(diag(matY));

		% vysledek
		BCV(i)=(K.var/n+sum(sum(matY))*((K.beta)/(n*factKk))^2)/h;
	end
	
	% zjemneni intervalu
	[min_BCV,ind]=min(BCV);
	if (ind==1) ind=2; end
	if (ind==len) ind=len-1; end
	if (j<3) hh=linspace(hh(ind-1),hh(ind+1),len); end
end

% vysledne optimalni h
h_BCV=hh(ind);


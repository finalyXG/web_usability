% Funkce pro vypocet optimalni sirky vyhlazovaciho okna h metodou
% Least squares cross-validation
%
% Vstupni parametry: X ... radkovy vektor pozorovanych bodu
%                    K ... jadro (defaultne=kvarticke)
%                          nefunkcni pro Gaussovo jadro
%                    len ... jemnost intervalu, ve kterem hledame optimalni h (defaultne=1000)
%
% Vystupni parametry: h_LSCV ... vysledne optimalni h
%
% Syntaxe: h_LSCV=lscv(X,K,len)
%
% (C) Michal Laska and Jiri Zelinka, Masaryk University, Brno, Czech Republic

function h_LSCV=lscv(X,K,len)

% pridani cesty k pomocnym funkcim
% addpath functions;

X=row(X);


% defaultni jadro
if (nargin<2) K=K_def('quart'); end

% defaultni jemnost intervalu
if (nargin<3) len=1000; end

% uprava jemnosti intervalu pro vyssi rychlost vypoctu
len=ceil(len^(1/3));

% pocet pozorovanych bodu
n=length(X);

% odhad vyberove smerodatne odchylky
%sigma=std(X);

% vypocet b_k;
%bk=2*sqrt(2*K.k+5)*(((2*K.k+1)*(2*K.k+5)*(K.k+1)^2*gamma(K.k+1)^4*K.var)/(K.k*gamma(2*K.k+4)*gamma(2*K.k+3)*K.beta^2))^(1/(2*K.k+1));

% horni hranice
%hu=sigma*bk*n^(-1/(2*K.k+1));
hu=h_ms(X,K);

% dolni hranice intervalu
hl=(max(X)-min(X))/n;

% interval, ve kterem se bude hledat optialni h
hh=linspace(hl,2*hu,len);

% matice Xi-Xj
XX=(X'*ones(1,n)-ones(n,1)*X);

% konvoluce 2 jader
Kc=Kconv_def(K,2);

% nemenna cast clena bez konvoluce
noKonv=-2/(n-1);

% nemenna cast clena s konvoluci
konv=1/n;

% vektor hodnot LSCV v hh
for j=1:3
	LSCV=[];
	for i=1:len
		h=hh(i);
		
		% clen bez konvoluce
		matX=XX/h;
		matY=K_val(K,matX);
		matY=matY-diag(diag(matY));
		y1=sum(sum(matY))*(noKonv/h);

		% clen s konvoluci
		y2=sum(sum(Kconv_val(Kc,-matX)))*(konv/h);

		% vysledek
		LSCV(i)=y1+y2;
	end
	LSCV=LSCV./n;
	
	% zjemneni intervalu
	[min_LSCV,ind]=min(LSCV);
	if (ind==1) ind=2; end
	if (ind==len) ind=len-1; end
	if (j<3) hh=linspace(hh(ind-1),hh(ind+1),len); end
end

% vysledne optimalni h
h_LSCV=hh(ind);


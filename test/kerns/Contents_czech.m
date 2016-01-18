% Kernel Smoothing Toolbox.
% Version 1.0.0  06-Oct-2004
%
%
% GUI tools
%   kern        - uvodni nabidka.
%
% Jadrove vyhlazovani: Obecne.
%   kern        - uvodni nabidka.
%   jadro       - vypocet jadra.
%   drkern      - vykresleni jadra.
%
% Typy odhadu
%   nw          - Nadarayaovy - Watsononovy
%   ll          - lokalne - linearni
%   pch         - Pristleyovy - Chaovy
%   gm          - Gasserovy - Muellerovy
%
% Cyklicky model
%   nwc         - Nadarayaovy - Watsononovy
%   llc         - lokalne - linearni
%   pchc        - Pristleyovy - Chaovy
%   gmc         - Gasserovy - Muellerovy
%
% Hledani optimalni sirky okna
%
% 1.Metoda krizoveho overovani
%   cvnw          - pro Nadarayaovy - Watsononovy odhady
%   cvll          - pro lokalne - linearni odhady
%   cvpch         - pro Pristleyovy - Chaovy odhady
%   cvgm          - pro Gasserovy - Muellerovy odhady
%
% 2.Penalizacni funkce
%
% 2.1.Akaike information criterion
%   acvnw          - pro Nadarayaovy - Watsononovy odhady
%   acvll          - pro lokalne - linearni odhady
%   acvpch         - pro Pristleyovy - Chaovy odhady
%   acvgm          - pro Gasserovy - Muellerovy odhady
%
% 2.2.Finite prediction error
%   fpecvnw          - pro Nadarayaovy - Watsononovy odhady
%   fpecvll          - pro lokalne - linearni odhady
%   fpecvpch         - pro Pristleyovy - Chaovy odhady
%   fpecvgm          - pro Gasserovy - Muellerovy odhady
%
% 2.3.Full crosswalidation
%   fcvnw          - pro Nadarayaovy - Watsononovy odhady
%   fcvll          - pro lokalne - linearni odhady
%   fcvpch         - pro Pristleyovy - Chaovy odhady
%   fcvgm          - pro Gasserovy - Muellerovy odhady
%
% 2.4.Rice
%   rcvnw          - pro Nadarayaovy - Watsononovy odhady
%   rcvll          - pro lokalne - linearni odhady
%   rcvpch         - pro Pristleyovy - Chaovy odhady
%   rcvgm          - pro Gasserovy - Muellerovy odhady
%
% 2.5.Kolacek
%   knw          - pro Nadarayaovy - Watsononovy odhady
%   kll          - pro lokalne - linearni odhady
%   kpch         - pro Pristleyovy - Chaovy odhady
%   kgm          - pro Gasserovy - Muellerovy odhady
%
% 2.6.Generalized crossvalidation
%   gcvnw          - pro Nadarayaovy - Watsononovy odhady
%   gcvll          - pro lokalne - linearni odhady
%   gcvpch         - pro Pristleyovy - Chaovy odhady
%   gcvgm          - pro Gasserovy - Muellerovy odhady
%
% 2.7.Shibata
%   scvnw          - pro Nadarayaovy - Watsononovy odhady
%   scvll          - pro lokalne - linearni odhady
%   scvpch         - pro Pristleyovy - Chaovy odhady
%   scvgm          - pro Gasserovy - Muellerovy odhady
%
% 3.Riceho selektor
%   signw          - pro Nadarayaovy - Watsononovy odhady
%   sigll          - pro lokalne - linearni odhady
%   sigpch         - pro Pristleyovy - Chaovy odhady
%   siggm          - pro Gasserovy - Muellerovy odhady
%
% 4.Metoda Fourierovy transformace
%   chnw          - pro Nadarayaovy - Watsononovy odhady
%   chll          - pro lokalne - linearni odhady
%   chpch         - pro Pristleyovy - Chaovy odhady
%   chgm          - pro Gasserovy - Muellerovy odhady
%
% 5.Plug-in metoda
%   plugin        - pro vsechny metody
%
% 6.Stredni kvadraticka chyba (MSE)
%   mse           - pouze pro znamou regresni funkci
%
%
%

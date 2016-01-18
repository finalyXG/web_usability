% Kernel Smoothing Toolbox.
% Version 1.0.0  06-Oct-2004
%
%
% GUI tools
%   ksregress   - kernel regression menu
%   ksquality   - kernel quality indexes
%
% Kernel smoothing: General
%   jadro       - computation of kernel function
%   drkern      - draw the kern
%
% Types of regression estimators
%   nw          - Nadaraya - Watson
%   ll          - local - linear
%   pch         - Pristley - Chao
%   gm          - Gasser - Mueller
%
% Cyclic model
%   nwc          - Nadaraya - Watson
%   llc          - local - linear
%   pchc         - Pristley - Chao
%   gmc          - Gasser - Mueller
%
% Optimal bandwidth selection for regression
%
% 1.Cross-validation method
%   cvnw          - for Nadaraya - Watson estimator
%   cvll          - for local - linear estimator
%   cvpch         - for Pristley - Chao estimator
%   cvgm          - for Gasser - Mueller estimator
%
% 2.Penalizing functions
%
% 2.1.Akaike information criterion
%   acvnw          - for Nadaraya - Watson estimator
%   acvll          - for local - linear estimator
%   acvpch         - for Pristley - Chao estimator
%   acvgm          - for Gasser - Mueller estimator
%
% 2.2.Finite prediction error
%   fpecvnw          - for Nadaraya - Watson estimator
%   fpecvll          - for local - linear estimator
%   fpecvpch         - for Pristley - Chao estimator
%   fpecvgm          - for Gasser - Mueller estimator
%
% 2.3.Full cross-validation
%   fcvnw          - for Nadaraya - Watson estimator
%   fcvll          - for local - linear estimator
%   fcvpch         - for Pristley - Chao estimator
%   fcvgm          - for Gasser - Mueller estimator
%
% 2.4.Rice
%   rcvnw          - for Nadaraya - Watson estimator
%   rcvll          - for local - linear estimator
%   rcvpch         - for Pristley - Chao estimator
%   rcvgm          - for Gasser - Mueller estimator
%
% 2.5.Kolacek
%   knw          - for Nadaraya - Watson estimator
%   kll          - for local - linear estimator
%   kpch         - for Pristley - Chao estimator
%   kgm          - for Gasser - Mueller estimator
%
% 2.6.Generalized crossvalidation
%   gcvnw          - for Nadaraya - Watson estimator
%   gcvll          - for local - linear estimator
%   gcvpch         - for Pristley - Chao estimator
%   gcvgm          - for Gasser - Mueller estimator
%
% 2.7.Shibata
%   scvnw          - for Nadaraya - Watson estimator
%   scvll          - for local - linear estimator
%   scvpch         - for Pristley - Chao estimator
%   scvgm          - for Gasser - Mueller estimator
%
% 3.Mallows method
%   signw          - for Nadaraya - Watson estimator
%   sigll          - for local - linear estimator
%   sigpch         - for Pristley - Chao estimator
%   siggm          - for Gasser - Mueller estimator
%
% 4.Fourier transformation method
%   chnw          - for Nadaraya - Watson estimator
%   chll          - for local - linear estimator
%   chpch         - for Pristley - Chao estimator
%   chgm          - for Gasser - Mueller estimator
%
% 5.Plug-in method
%   plugin        - for all estimators
%
% 6.Mean square error
%   mse           - only for known regression function
%
%
%

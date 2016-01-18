%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPAP105
% Project Title: Solving Bin Packing Problem using Genetic Algorithm
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function [z, sol] = BinPackingCost(q, model)

    n = model.n;
    v = model.v;
    Vmax = model.Vmax;
    
    Sep = find(q>n);
    
    From = [0 Sep] + 1;
    To = [Sep 2*n] - 1;
    
    B = {};
    for i=1:n
        Bi = q(From(i):To(i));
        if numel(Bi)>0
            B = [B; Bi]; %#ok
        end
    end
    
    nBin = numel(B);
    Viol = zeros(nBin,1);
    
    for i=1:nBin
        Vi = sum(v(B{i}));
        Viol(i) = max(Vi/Vmax-1, 0);
    end
    
    MeanViol = mean(Viol);
    
    alpha = 10*n;
    
    z = nBin + alpha*MeanViol;
    
    sol.nBin = nBin;
    sol.B = B;
    sol.Viol = Viol;
    sol.MeanViol = MeanViol;
    
end
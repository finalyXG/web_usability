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

function model = CreateModel()

    model.v = [6 3 4 6 8 7 4 7 7 5 5 6 7 7 6 4 8 7 8 8 2 3 4 5 6 5 5 7 7 12];
    
    model.n = numel(model.v);
    
    model.Vmax = 30;

end